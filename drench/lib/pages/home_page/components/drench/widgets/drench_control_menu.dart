import 'package:drench/features/drench_game/drench_game.model.dart';
import 'package:drench/pages/home_page/components/drench/drench_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrenchControlMenu extends StatelessWidget {
  final bool gameOver;
  final DrenchController controller;
  final double controlMenuSize;
  final DrenchGame drenchGame;

  DrenchControlMenu({
    this.gameOver,
    this.controller,
    this.controlMenuSize,
    this.drenchGame,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBottomMenu(),
          buildBottomStatus(),
          buildBottomOption(),
        ],
      ),
    );
  }

  Container buildBottomMenu() {
    List<Container> buttons = [];

    print('------');
    print(controlMenuSize);

    for (int i = 0; i < 6; i++) {
      buttons.add(Container(
        height: controlMenuSize / 8,
        width: controlMenuSize / 8,
        color: DrenchGame.getColor(i),
        child: FlatButton(
          color: DrenchGame.getColor(i),
          onPressed: () {
            this.controller.updateBoard(i);
          },
          child: SizedBox.shrink(),
        ),
      ));
    }

    return Container(
      width: controlMenuSize,
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[...buttons],
      ),
    );
  }

  Container buildBottomStatus() {
    print(controlMenuSize);

    if (gameOver != true) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: <Widget>[
            Text(
              'Restando ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Text(
              this.drenchGame.remainingPaints.toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: (this.drenchGame.remainingPaints > 5)
                      ? Colors.black
                      : Colors.red),
            ),
            Text(
              this.drenchGame.remainingPaints > 1
                  ? ' tentativas'
                  : ' tentativa',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'O jogo acabou ',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w500, color: Colors.red),
          ),
        ),
      );
    }
  }

  Container buildBottomOption() {
    if (!gameOver) {
      return Container(
        child: SizedBox.shrink(),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: controlMenuSize,
      child: FlatButton(
        color: Colors.green,
        onPressed: () {
          this.controller.newGame();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            'Novo Jogo',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
