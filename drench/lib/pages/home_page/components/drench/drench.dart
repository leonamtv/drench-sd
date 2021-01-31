import 'dart:math';
import 'package:drench/features/drench_game/drench_game.model.dart';
import 'package:drench/pages/home_page/components/drench/drench_controller.dart';
import 'package:drench/pages/home_page/components/drench/widgets/drench_matrix.dart';
import 'package:flutter/material.dart';

class Drench extends StatefulWidget {
  final DrenchController controller;

  Drench({Key key, this.controller});

  @override
  _DrenchState createState() => _DrenchState(controller);
}

class _DrenchState extends State<Drench> {
  DrenchGame drenchGame;
  List<Color> colors = DrenchGame.colors;

  bool over = false;

  _DrenchState(DrenchController _controller) {
    _controller.newGame = newGame;
    this.setDrenchGame();
  }

  Color getColor(int i) {
    return colors[i];
  }

  double getWidgetSize() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return min(screenWidth, screenHeight - 270);
  }

  setDrenchGame() {
    this.drenchGame = DrenchGame(maxClicks: 30, size: 14);
  }

  void newGame() {
    setState(() {
      this.setDrenchGame();
      over = false;
    });
  }

  void updateCanvas(int value) {
    if (over == true) {
      return;
    }

    this.drenchGame.paintFirstSquare(value);

    if (this.drenchGame.isGameOver()) {
      over = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DrenchMatrix(
              drenchGame: this.drenchGame,
              widgetSize: getWidgetSize(),
            ),
            buildBottomMenu(),
            buildBottomStatus(),
            buildBottomOption()
          ],
        ),
      ),
    );
  }

  Container buildBottomOption() {
    if (over == true) {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: getWidgetSize(),
        child: FlatButton(
          color: Colors.green,
          onPressed: () {
            newGame();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'Novo Jogo',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }
    return Container(
      child: SizedBox.shrink(),
    );
  }

  Container buildBottomStatus() {
    if (over != true) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                fontSize: 35, fontWeight: FontWeight.w500, color: Colors.red),
          ),
        ),
      );
    }
  }

  Container buildBottomMenu() {
    List<Container> buttons = [];

    for (int i = 0; i < 6; i++) {
      buttons.add(Container(
        height: getWidgetSize() / 8,
        width: getWidgetSize() / 8,
        color: getColor(i),
        child: FlatButton(
          color: getColor(i),
          onPressed: () {
            updateCanvas(i);
          },
          child: SizedBox.shrink(),
        ),
      ));
    }

    return Container(
      width: getWidgetSize(),
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[...buttons],
      ),
    );
  }
}
