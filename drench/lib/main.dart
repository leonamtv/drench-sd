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

  final int maxClicks = 30;
  final int size = 14;

  List<List<int>> _matrix;

  Drench({ Key key }) {
    _matrix = List.generate(size, (i) => List(size), growable: false);
    this.redo();
  }

  void redo () {
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
  List<Color> colors = [
    Colors.green,
    Colors.pink[300],
    Colors.purple,
    Colors.blue,
    Colors.red,
    Colors.yellow,
  ];
  
  int _counter = 0;

  bool over = false;

  Color getColor ( int i ) {
    return colors[i];
  }
  
  Widget buildWidgetMatrix () {
    List<Widget> result = [];
    _matrix = widget._matrix;

    for ( int i = 0; i < widget.size; i++ ) {
      List<Widget> auxRow = [];
      
      for ( int j = 0; j < widget.size; j++ ) {
        auxRow.add(
          Container(
            height: getWidgetSize() / widget.size,
            width: getWidgetSize() / widget.size,
            color: getColor(_matrix[i][j]),
          )
        );
      }

      result.add(
        Row( 
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: auxRow
        )
      );
    }
    return Column(children: result);
  }

  double getWidgetSize() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return min(screenWidth, screenHeight - 270);
  }

  void newGame () {
    setState(() {
      widget.redo();
      _counter = 0;
      over = false;
    });
  }

  bool verificaGameOver() {
    if ( _counter == widget.maxClicks ) {
      return true;
    }

    int val = _matrix[0][0];
    int cont = 0;

    for ( int i = 0; i < widget.size; i ++ ) {
      for ( int j = 0; j < widget.size; j ++ ) {
        if ( _matrix[i][j] != val ) {
          return false;
        }
        
        cont ++;
      }
    }

    return cont == ( widget.size * widget.size );
  }

  void updateCanvas( int value ) {
    if ( over == true ) {
      return;
    }

    if(value == _matrix[0][0]) {
      return;
    }

    _counter++;
    updateWidgetMatrix(value, _matrix[0][0]);
    setState(() {});

    if(verificaGameOver()) {
      over = true;
      return;
    }

  }

  void updateWidgetMatrix ( int value, int oldValue, [ x = 0, y = 0 ]) {
    if ( x >= widget.size || y >= widget.size || x < 0 || y < 0 ) {
      return;
    }

    if(_matrix[x][y] != oldValue && (x != 0 || y != 0)) {
      return;
    }
 
    _matrix[x][y] = value;
    updateWidgetMatrix ( value, oldValue, x, y + 1 );
    updateWidgetMatrix ( value, oldValue, x, y - 1 );
    updateWidgetMatrix ( value, oldValue, x + 1, y );
    updateWidgetMatrix ( value, oldValue, x - 1, y );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drench"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              newGame();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildWidgetMatrix(),
              buildBottomMenu(),
              buildBottomStatus(),
              buildBottomOption()
            ],
          ),
        ),
      ),
    );
  }

  Container buildBottomOption() {
    if ( over == true ) {
      return Container (
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
                color: Colors.white              
              ),
            ),
          ),
        ),
      );
    }
    return Container (
      child: SizedBox.shrink(),
    );
  }

  Container buildBottomStatus () {
    if ( over != true ) {
      return Container (
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Restando ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
              ),
            ),
            Text(
              (widget.maxClicks - _counter).toString(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: (( widget.maxClicks - _counter ) > 5 ) ? Colors.black : Colors.red
              ),
            ),
            Text(
              ( widget.maxClicks - _counter ) > 1 ? ' tentativas' : ' tentativa',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      );
    } else {
      return Container (
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'O jogo acabou ',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w500,
              color: Colors.red
            ),
          ),
        ),
      );
    }
  }

  Container buildBottomMenu() {
    List<Container> buttons = [];

    for ( int i = 0 ; i < 6; i++ ) {
      buttons.add(
        Container(
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
        )
      );
    }

    return Container(
      width: getWidgetSize(),
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
