import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';
import 'package:rxdart/subjects.dart';

class MultiplayerConnectionService {
  BehaviorSubject<ConnectionParams> currentConnectionParams$ =
      BehaviorSubject<ConnectionParams>();

  ReplaySubject<int> updateBoardRequest$ = ReplaySubject<int>();

  ReplaySubject<Map<String, dynamic>> syncBoardRequest$ =
      ReplaySubject<Map<String, dynamic>>();

  SocketConnectionService _socketConnectionService;

  MultiplayerConnectionService() {
    this.createSocketService();
  }

  createSocketService() {
    final socketService = SocketConnectionService();

    this._socketConnectionService = socketService;

    socketService.currentConnectionParams$
        .listen((params) => this.currentConnectionParams$.add(params));

    socketService.dataReceiving$.listen(handleSocketData);
  }

  void connect(ConnectionParams connectionParams) {
    this._socketConnectionService.connect(connectionParams);
  }

  void handleSocketData(value) {
    if (value['type'] == 'updateBoard') {
      this.updateBoardRequest$.add(value['colorIndex']);
      return;
    }

    if (value['type'] == 'syncBoard') {
      this.syncBoardRequest$.add(value);
      return;
    }
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
