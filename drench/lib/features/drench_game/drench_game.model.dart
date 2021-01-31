import 'dart:math';

import 'package:flutter/material.dart';

class DrenchGame {
  static final List<Color> colors = [
    Colors.green,
    Colors.pink[300],
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.yellow,
  ];

  final int maxClicks;
  final int size;

  int _paintsCount;
  List<List<int>> _matrix;

  DrenchGame({@required this.maxClicks, @required this.size}) {
    _paintsCount = 0;

    _matrix = List.generate(size, (i) => List(size), growable: false);

    var rng = new Random();
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        _matrix[i][j] = rng.nextInt(100) % 6;
      }
    }
  }

  List<List<int>> get matrix => this._matrix;
  int get remainingPaints => this.maxClicks - this._paintsCount;

  bool isGameOver() {
    if (_paintsCount >= maxClicks) {
      return true;
    }

    int val = _matrix[0][0];
    int cont = 0;

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (_matrix[i][j] != val) {
          return false;
        }

        cont++;
      }
    }

    return cont == (size * size);
  }

  void paintFirstSquare(int colorIndex) {
    if (colorIndex == _matrix[0][0]) {
      return;
    }

    _paintsCount++;

    this.propagateColorInMatrix(colorIndex, _matrix[0][0]);
  }

  void propagateColorInMatrix(int newValue, int oldValue, [x = 0, y = 0]) {
    if (x >= size || y >= size || x < 0 || y < 0) {
      return;
    }

    if (_matrix[x][y] != oldValue && (x != 0 || y != 0)) {
      return;
    }

    _matrix[x][y] = newValue;

    propagateColorInMatrix(newValue, oldValue, x, y + 1);
    propagateColorInMatrix(newValue, oldValue, x, y - 1);
    propagateColorInMatrix(newValue, oldValue, x + 1, y);
    propagateColorInMatrix(newValue, oldValue, x - 1, y);
  }

  static Color getColor(int i) {
    return colors[i];
  }
}
