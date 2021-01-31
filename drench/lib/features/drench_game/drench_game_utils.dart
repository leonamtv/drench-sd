import 'package:flutter/material.dart';

class DrenchGameUtils {
  static final List<Color> colors = [
    Colors.green,
    Colors.pink[300],
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.yellow,
  ];

  static final int maxClicks = 30;
  static final int size = 14;

  static Color getColor(int i) {
    return colors[i];
  }

  static bool isGameOver(clicksCounter, List<List<int>> matrix) {
    if (clicksCounter >= maxClicks) {
      return true;
    }

    int val = matrix[0][0];
    int cont = 0;

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (matrix[i][j] != val) {
          return false;
        }

        cont++;
      }
    }

    return cont == (size * size);
  }

  static void propagateColorInMatrix(
      List<List<int>> matrix, int newValue, int oldValue,
      [x = 0, y = 0]) {
    if (x >= size || y >= size || x < 0 || y < 0) {
      return;
    }

    if (matrix[x][y] != oldValue && (x != 0 || y != 0)) {
      return;
    }

    matrix[x][y] = newValue;

    propagateColorInMatrix(matrix, newValue, oldValue, x, y + 1);
    propagateColorInMatrix(matrix, newValue, oldValue, x, y - 1);
    propagateColorInMatrix(matrix, newValue, oldValue, x + 1, y);
    propagateColorInMatrix(matrix, newValue, oldValue, x - 1, y);
  }
}
