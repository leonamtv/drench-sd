import 'dart:convert';

import 'package:drench/features/multiplayer/grpc/drench_grpc_service.dart';
import 'package:drench/features/drench_game/drench_multiplayer/drench_multiplayer_connection_service.dart';
import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/generated/drench.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/subjects.dart';

class GRPCConnectionService {
  Server server;

  ClientChannel clientChannel;
  DrenchClient stub;

  ReplaySubject<UpdateBoardData> updateBoard$ =
      ReplaySubject<UpdateBoardData>();

  ReplaySubject<SyncBoardData> syncBoard$ = ReplaySubject<SyncBoardData>();

  void connect(ConnectionParams connectionParams,
      DrenchMultiplayerConnectionService drenchMultiplayerConnectionService) {
    if (connectionParams.isServer) {
      openGRPCServer(connectionParams, drenchMultiplayerConnectionService);
      return;
    }

    openGRPCClient(connectionParams, drenchMultiplayerConnectionService);
  }

  openGRPCServer(
      ConnectionParams connectionParams,
      DrenchMultiplayerConnectionService
          drenchMultiplayerConnectionService) async {
    print('/// open grpc server');

    this.server =
        Server([DrenchGRPCService(drenchMultiplayerConnectionService, this)]);

    await server.serve(port: connectionParams.port);
  }

  openGRPCClient(ConnectionParams connectionParams,
      DrenchMultiplayerConnectionService drenchMultiplayerConnectionService) {
    clientChannel = ClientChannel(
      connectionParams.ipAddress,
      port: connectionParams.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    stub = DrenchClient(
      clientChannel,
      options: CallOptions(),
    );

    this.stub.subscribeSyncBoard(voidNoParam()).listen((value) {
      drenchMultiplayerConnectionService.syncBoard({
        'board': json.decode(value.board),
        'reset': value.reset,
      });
    });

    this.stub.subscribeUpdateBoard(voidNoParam()).listen((value) {
      drenchMultiplayerConnectionService.updateBoard(value.colorIndex);
    });
  }

  sendBoardSync(List<List<int>> board, bool reset) {
    final data = SyncBoardData(board: json.encode(board), reset: reset);

    if (this.server == null) {
      this.stub.syncBoard(data);
      return;
    }

    this.syncBoard$.add(data);
  }

  sendBoardUpdate(int colorIndex) {
    final data = UpdateBoardData(colorIndex: colorIndex);

    if (this.server == null) {
      this.stub.updateBoard(data);
      return;
    }

    this.updateBoard$.add(data);
  }

  closeActiveConnections() {
    if (this.server != null) {
      this.server.shutdown();
    }

    if (this.clientChannel != null) {
      this.clientChannel.shutdown();
    }
  }
}
