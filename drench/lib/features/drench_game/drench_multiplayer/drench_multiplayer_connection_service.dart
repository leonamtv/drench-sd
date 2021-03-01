import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/features/multiplayer/grpc/grpc_connection_service.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';
import 'package:rxdart/subjects.dart';

class DrenchMultiplayerConnectionService {
  BehaviorSubject<ConnectionParams> currentConnectionParams$ =
      BehaviorSubject<ConnectionParams>();

  ReplaySubject<int> updateBoard$ = ReplaySubject<int>();

  ReplaySubject<Map<String, dynamic>> syncBoard$ =
      ReplaySubject<Map<String, dynamic>>();

  SocketConnectionService _socketConnectionService;
  GRPCConnectionService _gRPCConnectionService;

  DrenchMultiplayerConnectionService() {
    this.createSocketService();
    this.createGRPCService();
  }

  createSocketService() {
    final socketService = SocketConnectionService();
    this._socketConnectionService = socketService;

    socketService.currentConnectionParams$
        .listen((params) => this.currentConnectionParams$.add(params));

    socketService.dataReceiving$.listen(handleSocketData);
  }

  createGRPCService() {
    final gRPCService = GRPCConnectionService();
    this._gRPCConnectionService = gRPCService;
  }

  void connect(ConnectionParams connectionParams) {
    closeActiveConnections();

    if (connectionParams.isSocket) {
      this._socketConnectionService.connect(connectionParams);
      return;
    }

    this._gRPCConnectionService.connect(connectionParams);
  }

  closeActiveConnections() {
    this._socketConnectionService.closeActiveConnections();
    this._gRPCConnectionService.closeActiveConnections();
  }

  void handleSocketData(value) {
    if (value['type'] == 'updateBoard') {
      updateBoard(value['colorIndex']);
      return;
    }

    if (value['type'] == 'syncBoard') {
      syncBoard(value);
      return;
    }
  }

  updateBoard(int colorIndex) {
    this.updateBoard$.add(colorIndex);
  }

  syncBoard(value) {
    this.syncBoard$.add(value);
  }

  sendBoardSync(List<List<int>> board, bool reset) {
    this
        ._socketConnectionService
        .sendData({'type': 'syncBoard', 'board': board, 'reset': reset});
  }

  sendBoardUpdate(int colorIndex) {
    this._socketConnectionService.sendData({
      'type': 'updateBoard',
      'colorIndex': colorIndex,
    });
  }
}
