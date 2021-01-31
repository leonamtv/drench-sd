import 'package:drench/features/drench_game/drench_game_utils.dart';
import 'package:flutter/widgets.dart';

class DrenchMatrix extends StatelessWidget {
  final List<List<int>> matrix;
  final double widgetSize;

  DrenchMatrix({this.matrix, this.widgetSize});

  @override
  Widget build(BuildContext context) {
    List<Widget> result = [];

    for (int i = 0; i < DrenchGameUtils.size; i++) {
      result.add(
        _row(i),
      );
    }

    return Column(children: result);
  }

  _row(i) {
    List<Widget> auxRow = [];

    for (int j = 0; j < DrenchGameUtils.size; j++) {
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
      height: this.widgetSize / DrenchGameUtils.size,
      width: this.widgetSize / DrenchGameUtils.size,
      color: DrenchGameUtils.getColor(this.matrix[i][j]),
    );
  }
}
