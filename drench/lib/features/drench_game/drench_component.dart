import 'dart:math';
import 'package:drench/features/drench_game/drench_game.model.dart';
import 'package:drench/features/drench_game/widgets/drench_control_menu.dart';
import 'package:drench/features/drench_game/widgets/drench_matrix.dart';
import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/features/drench_game/drench_controller.dart';
import 'package:flutter/material.dart';

class DrenchComponent extends StatefulWidget {
  final DrenchController controller;

  DrenchComponent({Key key, this.controller});

  @override
  _DrenchComponentState createState() =>
      _DrenchComponentState(controller: controller);
}

class _DrenchComponentState extends State<DrenchComponent> {
  final DrenchController controller;

  final double topWidgetHeight = 10;
  double get bottomWidgetHeight => min(
        0.5 * MediaQuery.of(context).size.height,
        275,
      );

  double get maxDrenchBoardHeight => max(
        MediaQuery.of(context).size.height -
            topWidgetHeight -
            bottomWidgetHeight -
            56,
        0,
      );

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

  ConnectionParams connectionParams;

  bool gameOver = false;

  _DrenchComponentState({this.controller}) {
    controller.newGame = newGame;
    controller.updateBoard = updateBoard;
    controller.syncBoard = syncBoard;
    controller.setConnectionParams = setConnectionParams;

    this.setDrenchGame();
  }

  setDrenchGame() {
    this.drenchGame = DrenchGame(maxClicks: 10, size: 5);
  }

  void newGame(bool syncBoard) {
    setState(() {
      this.setDrenchGame();
      gameOver = false;
    });

    if (syncBoard && this.connectionParams != null) {
      this.controller.sendBoardSync(this.drenchGame.matrix, true);
    }
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

  void syncBoard(List<List<int>> board) {
    setState(() {
      this.drenchGame.matrix = board;
    });
  }

  void setConnectionParams(ConnectionParams connectionParams) {
    setState(() {
      this.connectionParams = connectionParams;
    });
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
        connectionParams: this.connectionParams,
      ),
    );
  }
}
