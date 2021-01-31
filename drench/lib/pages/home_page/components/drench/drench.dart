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
  final double topWidgetHeight = 10;
  final double bottomWidgetHeight = 230;

  double get maxDrenchBoardHeight =>
      MediaQuery.of(context).size.height -
      topWidgetHeight -
      bottomWidgetHeight -
      56;

  double get drenchBoardSize => min(
        MediaQuery.of(context).size.width - 10,
        maxDrenchBoardHeight,
      );

  DrenchGame drenchGame;
  List<Color> colors = DrenchGame.colors;

  bool over = false;

  _DrenchState(DrenchController _controller) {
    _controller.newGame = newGame;
    this.setDrenchGame();
  }

  setDrenchGame() {
    this.drenchGame = DrenchGame(maxClicks: 10, size: 5);
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
      child: Column(
        children: <Widget>[
          _topWidget(),
          DrenchMatrix(
            drenchGame: this.drenchGame,
            widgetSize: drenchBoardSize,
          ),
          _bottomWidget(),
        ],
      ),
    );
  }

  Widget _topWidget() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: max(topWidgetHeight, 0),
      ),
      child: SizedBox(
        height: max(topWidgetHeight, 0),
      ),
    );
  }

  Widget _bottomWidget() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: bottomWidgetHeight,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildBottomMenu(),
            buildBottomStatus(),
            buildBottomOption(),
          ],
        ),
      ),
    );
  }

  Container buildBottomOption() {
    if (over == true) {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: drenchBoardSize,
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

  Container buildBottomMenu() {
    List<Container> buttons = [];

    for (int i = 0; i < 6; i++) {
      buttons.add(Container(
        height: drenchBoardSize / 8,
        width: drenchBoardSize / 8,
        color: DrenchGame.getColor(i),
        child: FlatButton(
          color: DrenchGame.getColor(i),
          onPressed: () {
            updateCanvas(i);
          },
          child: SizedBox.shrink(),
        ),
      ));
    }

    return Container(
      width: drenchBoardSize,
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[...buttons],
      ),
    );
  }
}
