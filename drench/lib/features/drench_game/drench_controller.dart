import 'package:drench/features/drench_game/drench_multiplayer/drench_multiplayer_connection_service.dart';
import 'package:drench/features/multiplayer/connection_params.model.dart';

class DrenchController {
  void Function(bool newGame) newGame;
  void Function(int colorIndex) updateBoard;
  void Function(List<List<int>> colorIndex) syncBoard;
  void Function(ConnectionParams connectionParams) setConnectionParams;

  DrenchMultiplayerConnectionService _drenchMultiplayerConnectionService;

  setMultiplayerConnectionService(
      DrenchMultiplayerConnectionService multiplayerConnectionService) {
    this._drenchMultiplayerConnectionService = multiplayerConnectionService;

    _drenchMultiplayerConnectionService.currentConnectionParams$
        .listen(handleChangeConnectionParams);

    _drenchMultiplayerConnectionService.updateBoard$.listen(handleUpdateBoard);
    _drenchMultiplayerConnectionService.syncBoard$.listen(handleSyncBoard);
  }

  handleChangeConnectionParams(ConnectionParams connectionParams) {
    this.setConnectionParams(connectionParams);
  }

  handleUpdateBoard(int colorIndex) {
    this.updateBoard(colorIndex);
  }

  handleSyncBoard(Map<String, dynamic> args) {
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
    this._drenchMultiplayerConnectionService.sendBoardSync(board, reset);
  }

  sendBoardUpdate(int colorIndex) {
    this._drenchMultiplayerConnectionService.sendBoardUpdate(colorIndex);
  }
}
