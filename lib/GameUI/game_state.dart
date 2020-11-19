import 'package:TikTacToe_AI/ReuseCodes/Shapes/circle.dart';
import 'package:TikTacToe_AI/ReuseCodes/Shapes/cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Victory/victory.dart';
import 'Victory/victoryLine.dart';

List<List<String>> field = [
  ['', '', ''],
  ['', '', ''],
  ['', '', '']
];

Victory victory;

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
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        buildCell(0, 0),
        buildCell(0, 1),
        buildCell(0, 2),
      ])),
      Expanded(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        buildCell(1, 0),
        buildCell(1, 1),
        buildCell(1, 2),
      ])),
      Expanded(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
