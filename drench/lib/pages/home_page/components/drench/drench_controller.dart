import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';

class DrenchController {
  void Function() newGame;
  void Function(int colorIndex) updateBoard;
  void Function(List<List<int>> colorIndex) syncBoard;
  void Function(ConnectionParams connectionParams) setConnectionParams;

  SocketConnectionService _socketConnectionService;

  setSocketConnectionService(SocketConnectionService socketConnectionService) {
    this._socketConnectionService = socketConnectionService;

    socketConnectionService.currentConnectionParams$
        .listen(handleChangeConnectionParams);

    socketConnectionService.dataReceiving$.listen(handleSocketData);
  }

  handleChangeConnectionParams(ConnectionParams connectionParams) {
    this.setConnectionParams(connectionParams);
  }

  void handleSocketData(value) {
    print('===== data received');
    print(value);

    if (value['type'] == 'updateBoard') {
      this.updateBoard(value['colorIndex']);
      return;
    }

    if (value['type'] == 'syncBoard') {
      List<List<int>> board = new List<List<int>>();

      value['board'].forEach((vector) {
        List<int> list = new List<int>();

        vector.forEach((value) {
          list.add(value as int);
        });

        board.add(list);
      });

      this.syncBoard(board);
      return;
    }
  }

  sendBoardSync(List<List<int>> board) {
    this
        ._socketConnectionService
        .sendData({'type': 'syncBoard', 'board': board});
  }

  sendBoardUpdate(int colorIndex) {
    this._socketConnectionService.sendData({
      'type': 'updateBoard',
      'colorIndex': colorIndex,
    });
  }
}
