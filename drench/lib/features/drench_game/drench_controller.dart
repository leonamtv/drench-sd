import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/features/multiplayer/multiplayer_connection_service.dart';

class DrenchController {
  void Function(bool newGame) newGame;
  void Function(int colorIndex) updateBoard;
  void Function(List<List<int>> colorIndex) syncBoard;
  void Function(ConnectionParams connectionParams) setConnectionParams;

  MultiplayerConnectionService _multiplayerConnectionService;

  setMultiplayerConnectionService(
      MultiplayerConnectionService multiplayerConnectionService) {
    this._multiplayerConnectionService = multiplayerConnectionService;

    _multiplayerConnectionService.currentConnectionParams$
        .listen(handleChangeConnectionParams);

    _multiplayerConnectionService.updateBoardRequest$
        .listen(handleUpdateBoardRequest);

    _multiplayerConnectionService.syncBoardRequest$
        .listen(handleSyncBoardRequest);
  }

  handleChangeConnectionParams(ConnectionParams connectionParams) {
    this.setConnectionParams(connectionParams);
  }

  handleUpdateBoardRequest(int colorIndex) {
    this.updateBoard(colorIndex);
  }

  handleSyncBoardRequest(Map<String, dynamic> args) {
    List<List<int>> board = new List<List<int>>();

    args['board'].forEach((vector) {
      List<int> list = new List<int>();

      vector.forEach((value) {
        list.add(value as int);
      });

      board.add(list);
    });

    if (args['reset'] == true) {
      this.newGame(false);
    }

    this.syncBoard(board);
  }

  sendBoardSync(List<List<int>> board, bool reset) {
    this._multiplayerConnectionService.sendBoardSync(board, reset);
  }

  sendBoardUpdate(int colorIndex) {
    this._multiplayerConnectionService.sendBoardUpdate(colorIndex);
  }
}
