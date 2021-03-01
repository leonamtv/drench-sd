import 'dart:convert';

import 'package:drench/features/drench_game/drench_multiplayer/drench_multiplayer_connection_service.dart';
import 'package:drench/features/multiplayer/grpc/grpc_connection_service.dart';
import 'package:drench/generated/drench.pbgrpc.dart';
import 'package:grpc/src/server/call.dart';

class DrenchGRPCService extends DrenchServiceBase {
  DrenchMultiplayerConnectionService drenchMultiplayerConnectionService;
  GRPCConnectionService gRPCConnectionService;

  DrenchGRPCService(
      this.drenchMultiplayerConnectionService, this.gRPCConnectionService);

  @override
  Stream<SyncBoardData> subscribeSyncBoard(
      ServiceCall call, voidNoParam request) {
    return this.gRPCConnectionService.syncBoard$;
  }

  @override
  Stream<UpdateBoardData> subscribeUpdateBoard(
      ServiceCall call, voidNoParam request) {
    return this.gRPCConnectionService.updateBoard$;
  }

  @override
  Future<voidNoParam> syncBoard(ServiceCall call, SyncBoardData request) async {
    this
        .drenchMultiplayerConnectionService
        .syncBoard$
        .add({'board': json.decode(request.board), 'reset': request.reset});

    return voidNoParam();
  }

  @override
  Future<voidNoParam> updateBoard(
      ServiceCall call, UpdateBoardData request) async {
    print(this.drenchMultiplayerConnectionService);

    this
        .drenchMultiplayerConnectionService
        .updateBoard$
        .add(request.colorIndex);

    return voidNoParam();
  }
}
