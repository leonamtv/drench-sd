import 'dart:math';
import 'package:drench/features/drench_game/drench_game_utils.dart';
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
  final int maxClicks = DrenchGameUtils.maxClicks;
  final int size = DrenchGameUtils.size;

  List<List<int>> _matrix;
  List<Color> colors = DrenchGameUtils.colors;

  int _counter = 0;

  bool over = false;

  _DrenchState(DrenchController _controller) {
    _controller.newGame = newGame;

    _matrix = List.generate(size, (i) => List(size), growable: false);
    this.redo();
  }

  Color getColor(int i) {
    return colors[i];
  }

  double getWidgetSize() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return min(screenWidth, screenHeight - 270);
  }

  void redo() {
    var rng = new Random();
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        _matrix[i][j] = rng.nextInt(100) % 6;
      }
    }
  }

  void newGame() {
    setState(() {
      this.redo();
      _counter = 0;
      over = false;
    });
  }

  void updateCanvas(int value) {
    if (over == true) {
      return;
    }

    if (value == _matrix[0][0]) {
      return;
    }

    _counter++;
    DrenchGameUtils.propagateColorInMatrix(_matrix, value, _matrix[0][0]);

    setState(() {});

    if (DrenchGameUtils.isGameOver(_counter, _matrix)) {
      over = true;
      return;
    }
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
              matrix: _matrix,
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
              (maxClicks - _counter).toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color:
                      ((maxClicks - _counter) > 5) ? Colors.black : Colors.red),
            ),
            Text(
              (maxClicks - _counter) > 1 ? ' tentativas' : ' tentativa',
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
