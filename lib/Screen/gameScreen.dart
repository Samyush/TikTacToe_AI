import 'package:TikTacToe_AI/GameUI/Victory/victory.dart';
import 'package:TikTacToe_AI/GameUI/Victory/victoryLine.dart';
import 'package:TikTacToe_AI/ReuseCodes/Shapes/circle.dart';
import 'package:TikTacToe_AI/ReuseCodes/Shapes/cross.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BuildContext _context;

  List<List<String>> field = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];
  Victory victory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Builder(builder: (BuildContext context) {
        _context = context;
        return Center(
            child: Stack(
                children: [buildGrid(), buildField(), buildVictoryLine()]));
      }),
    );
  }

  Widget buildGrid() => AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            buildHorizontalLine,
            buildHorizontalLine,
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            buildVerticalLine,
            buildVerticalLine,
          ])
        ],
      ));

  Container get buildVerticalLine => Container(
      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
      color: Colors.grey,
      width: 5.0);

  Container get buildHorizontalLine => Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      color: Colors.grey,
      height: 5.0);

  Widget buildField() => AspectRatio(
      aspectRatio: 1.0,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              buildCell(0, 0),
              buildCell(0, 1),
              buildCell(0, 2),
            ])),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              buildCell(1, 0),
              buildCell(1, 1),
              buildCell(1, 2),
            ])),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              buildCell(2, 0),
              buildCell(2, 1),
              buildCell(2, 2),
            ]))
      ]));

  Widget buildCell(int row, int column) => AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
          onTap: () {
            // if (!gameIsDone() && playersTurn) {
            //   setState(() {
            //     displayPlayersTurn(row, column);
            //
            //     if (!gameIsDone() && type == null) {
            //       displayAiTurn();
            //     }
            //   });
            // }
          },
          child: buildCellItem(row, column)));

  Widget buildCellItem(int row, int column) {
    var cell = field[row][column];
    if (cell.isNotEmpty) {
      if (cell == 'X') {
        return Container(padding: EdgeInsets.all(24.0), child: Cross());
      } else {
        return Container(padding: EdgeInsets.all(24.0), child: Circle());
      }
    } else {
      return null;
    }
  }

  Widget buildVictoryLine() => AspectRatio(
      aspectRatio: 1.0, child: CustomPaint(painter: VictoryLine(victory)));
}
