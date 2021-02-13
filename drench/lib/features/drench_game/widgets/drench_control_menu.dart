import 'package:drench/features/drench_game/drench_game.model.dart';
import 'package:drench/features/drench_game/widgets/drench_connection_status.dart';
import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:drench/pages/home_page/components/drench/drench_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrenchControlMenu extends StatelessWidget {
  final bool gameOver;
  final DrenchController controller;
  final double controlMenuSize;
  final DrenchGame drenchGame;
  final ConnectionParams connectionParams;

  DrenchControlMenu({
    this.gameOver,
    this.controller,
    this.controlMenuSize,
    this.drenchGame,
    this.connectionParams,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBottomMenu(),
          buildBottomConnectionStatus(),
          buildBottomStatus(),
          buildBottomOption(),
        ],
      ),
    );
  }

  Container buildBottomMenu() {
    List<Container> buttons = [];

    for (int i = 0; i < 6; i++) {
      buttons.add(Container(
        height: controlMenuSize / 8,
        width: controlMenuSize / 8,
        color: DrenchGame.getColor(i),
        child: FlatButton(
          color: DrenchGame.getColor(i),
          onPressed: () {
            this.controller.updateBoard(i);
            this.controller.sendBoardUpdate(i);
          },
          child: SizedBox.shrink(),
        ),
      ));
    }

    return Container(
      width: controlMenuSize,
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[...buttons],
      ),
    );
  }

  buildBottomConnectionStatus() {
    return DrenchConnectionStatus(connectionParams: this.connectionParams);
  }

  Container buildBottomStatus() {
    if (gameOver) {
      return _gameFinished();
    }

    return _remaingingPaints();
  }

  Widget _remaingingPaints() {
    var remainingPaints = this.drenchGame.remainingPaints;

    TextStyle textStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: <Widget>[
          Text('Restando ', style: textStyle),
          Text(
            remainingPaints.toString(),
            style: textStyle.copyWith(
              color: (remainingPaints > 5) ? Colors.black : Colors.red,
            ),
          ),
          Text(
            remainingPaints > 1 ? ' tentativas' : ' tentativa',
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget _gameFinished() {
    TextStyle textStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: Colors.red,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          'O jogo acabou ',
          style: textStyle,
        ),
      ),
    );
  }

  Container buildBottomOption() {
    if (!gameOver) {
      return Container(
        child: SizedBox.shrink(),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
      width: controlMenuSize,
      child: FlatButton(
        color: Colors.green,
        onPressed: () {
          this.controller.newGame();
          
          if ( this.connectionParams != null ) {
            this.controller.syncBoard(this.drenchGame.matrix);
            this.controller.sendBoardSync(this.drenchGame.matrix);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            'Novo Jogo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
