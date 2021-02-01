import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';

class DrenchController {
  void Function() newGame;
  void Function(int colorIndex) updateBoard;
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
    }
  }

  sendBoardUpdate(int colorIndex) {
    this._socketConnectionService.sendData({
      'type': 'updateBoard',
      'colorIndex': colorIndex,
    });
  }
}
