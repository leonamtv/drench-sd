import 'dart:math';
import 'package:drench/features/drench_game/drench_game.model.dart';
import 'package:drench/pages/home_page/components/drench/drench_controller.dart';
import 'package:drench/pages/home_page/components/drench/widgets/drench_control_menu.dart';
import 'package:drench/pages/home_page/components/drench/widgets/drench_matrix.dart';
import 'package:flutter/material.dart';

class Drench extends StatefulWidget {
  final DrenchController controller;

  Drench({Key key, this.controller});

  @override
  _DrenchState createState() => _DrenchState(controller: controller);
}

class _DrenchState extends State<Drench> {
  final DrenchController controller;

  final double topWidgetHeight = 10;
  double get bottomWidgetHeight => min(
        0.5 * MediaQuery.of(context).size.height,
        230,
      );

  double get maxDrenchBoardHeight =>
      MediaQuery.of(context).size.height -
      topWidgetHeight -
      bottomWidgetHeight -
      56;

  double get drenchBoardSize => min(
        MediaQuery.of(context).size.width - 10,
        maxDrenchBoardHeight,
      );

  double get controlMenuSize => min(
        MediaQuery.of(context).size.width,
        max(
          drenchBoardSize,
          300,
        ),
      );

  DrenchGame drenchGame;
  List<Color> colors = DrenchGame.colors;

  bool gameOver = false;

  _DrenchState({this.controller}) {
    controller.newGame = newGame;
    controller.updateBoard = updateBoard;

    this.setDrenchGame();
  }

  setDrenchGame() {
    this.drenchGame = DrenchGame(maxClicks: 10, size: 5);
  }

  void newGame() {
    setState(() {
      this.setDrenchGame();
      gameOver = false;
    });
  }

  void updateBoard(int value) {
    if (gameOver == true) {
      return;
    }

    this.drenchGame.paintFirstSquare(value);

    if (this.drenchGame.isGameOver()) {
      gameOver = true;
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
      child: DrenchControlMenu(
        gameOver: this.gameOver,
        controller: this.controller,
        controlMenuSize: this.controlMenuSize,
        drenchGame: this.drenchGame,
      ),
    );
  }
}
