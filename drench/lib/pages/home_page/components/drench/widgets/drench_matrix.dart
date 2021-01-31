import 'package:drench/features/drench_game/drench_game.model.dart';
import 'package:flutter/widgets.dart';

class DrenchMatrix extends StatelessWidget {
  final DrenchGame drenchGame;
  final double widgetSize;

  DrenchMatrix({this.drenchGame, this.widgetSize});

  @override
  Widget build(BuildContext context) {
    List<Widget> result = [];

    for (int i = 0; i < this.drenchGame.size; i++) {
      result.add(
        _row(i),
      );
    }

    return Column(children: result);
  }

  _row(i) {
    List<Widget> auxRow = [];

    for (int j = 0; j < this.drenchGame.size; j++) {
      auxRow.add(_square(i, j));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: auxRow,
    );
  }

  _square(i, j) {
    return Container(
      height: this.widgetSize / this.drenchGame.size,
      width: this.widgetSize / this.drenchGame.size,
      color: DrenchGame.getColor(this.drenchGame.matrix[i][j]),
    );
  }
}
