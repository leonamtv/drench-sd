import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drench',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Drench(),
    );
  }
}

class Drench extends StatefulWidget {

  final int size = 14;

  List<List<int>> _matrix;

  Drench({ Key key }) {
    _matrix = List.generate(size, (i) => List(size), growable: false);
    var rng = new Random();
    for ( int i = 0; i < size; i++ ) {
      for ( int j = 0; j < size; j++ ) {
        _matrix[i][j] = rng.nextInt(100) % 6;
      }
    }
  }

  @override
  _DrenchState createState() => _DrenchState();
}

class _DrenchState extends State<Drench> {

  List<List<int>> _matrix;

  Color getColor ( int i ) {
    switch (i) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.pink;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.red;
      case 5:
        return Colors.yellow;
      default:
        return Colors.transparent;
    }
  }
  
  Widget buildWidgetMatrix () {
    List<Widget> result = [];
    _matrix = widget._matrix;
    for ( int i = 0; i < widget.size; i++ ) {
      List<Widget> auxRow = [];
      for ( int j = 0; j < widget.size; j++ ) {
        auxRow.add(
          Container(
            height: MediaQuery.of(context).size.width / widget.size,
            width: MediaQuery.of(context).size.width / widget.size,
            color: getColor(_matrix[i][j]),
          )
        );
      }
      result.add(
        Row( children: auxRow )
      );
    }
    return Column( children: result );
  }

  void updateCanvas( int value ) {
    updateWidgetMatrix(value, _matrix[0][0]);
    setState(() {});
  }

  void updateWidgetMatrix ( int value, int oldValue, [ x = 0, y = 0 ]) {
    if ( x < widget.size && y < widget.size && x >= 0 && y >= 0 ) {
      if ( _matrix[x][y] == oldValue || ( x == 0 && y == 0 )) {
        _matrix[x][y] = value;
        updateWidgetMatrix ( value, oldValue, x, y + 1 );
        updateWidgetMatrix ( value, oldValue, x, y - 1 );
        updateWidgetMatrix ( value, oldValue, x + 1, y );
        updateWidgetMatrix ( value, oldValue, x - 1, y );
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drench"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            buildWidgetMatrix(),
            buildBottomMenu()
          ],
        ),
      ),
    );
  }

  Container buildBottomMenu() {
    List<Container> buttons = [];

    for ( int i = 0 ; i < 6; i++ ) {
      buttons.add(
        Container(
          height: MediaQuery.of(context).size.width / 8,
          width: MediaQuery.of(context).size.width / 8,
          color: getColor(i),
          child: FlatButton(
            color: getColor(i),
            onPressed: () { 
              updateCanvas(i);
            },
            child: SizedBox.shrink(),
          ),
        )
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ...buttons
        ],
      ),
    );
  }
}
