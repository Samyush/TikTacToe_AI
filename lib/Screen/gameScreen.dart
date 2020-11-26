import 'dart:async';

import 'package:TikTacToe_AI/AI/ai.dart';
import 'package:TikTacToe_AI/AI/victory_checker.dart';
import 'package:TikTacToe_AI/GameUI/Victory/victory.dart';
import 'package:TikTacToe_AI/GameUI/Victory/victoryLine.dart';
import 'package:TikTacToe_AI/ReuseCodes/Shapes/circle.dart';
import 'package:TikTacToe_AI/ReuseCodes/Shapes/cross.dart';
import 'package:TikTacToe_AI/ReuseCodes/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({Key key, this.title, this.type, this.me, this.gameId, this.withId})
      : super(key: key);

  final String title, type, me, gameId, withId;

  @override
  _GameScreen createState() =>
      _GameScreen(type: type, me: me, gameId: gameId, withId: withId);
}

class _GameScreen extends State<Game> {
  BuildContext _context;
  List<List<String>> field = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];

  AI ai;

  String playerChar = 'X', aiChar = 'O';
  bool playersTurn = true;
  Victory victory;
  final String type, me, gameId, withId;

  _GameScreen({this.type, this.me, this.gameId, this.withId});

  @override
  void initState() {
    super.initState();
    if (me != null) {
      playersTurn = me == 'X';
      playerChar = me;

      // Haven't figured out how to display a Snackbar during build yet
      new Timer(Duration(milliseconds: 1000), () {
        String text = playersTurn ? 'Your turn' : 'Opponent\'s turn';
        print(text);
        Scaffold.of(_context).showSnackBar(SnackBar(content: Text(text)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('game build');
    print(type);
    print(me);
    print(gameId);
    print(withId);

    ai = AI(field, playerChar, aiChar);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(builder: (BuildContext context) {
          _context = context;
          return Center(
              child: Stack(
                  children: [buildGrid(), buildField(), buildVictoryLine()]));
        }));
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
            if (!gameIsDone() && playersTurn) {
              setState(() {
                displayPlayersTurn(row, column);

                if (!gameIsDone() && type == null) {
                  displayAiTurn();
                }
              });
            }
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
//

  void cleanUp() {
    victory = null;
    field = [
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ];
    playersTurn = me == 'X';
    String text = playersTurn ? 'Your turn' : 'Opponent\'s turn';
    print(text);
    Scaffold.of(_context).showSnackBar(SnackBar(content: Text(text)));
  }

  void restart() async {
    setState(() {
      cleanUp();
    });
  }

  void checkForVictory() {
    victory = VictoryChecker.checkForVictory(field, playerChar);
    if (victory != null) {
      String message;

      if (victory.winner == PLAYER_WINNER) {
        message = 'You Win!';
      } else if (victory.winner == AI_WINNER) {
        message = type == null ? 'AI Win!' : 'You loose!';
      } else if (victory.winner == DRAFT) {
        message = 'Draft';
      }
      print(message);
      Scaffold.of(_context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(minutes: 1),
        action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              if (type == null) {
                setState(() {
                  victory = null;
                  field = [
                    ['', '', ''],
                    ['', '', ''],
                    ['', '', '']
                  ];
                  playersTurn = true;
                });
              } else {
                restart();
              }
            }),
      ));
    }
  }

  void displayPlayersTurn(int row, int column) {
    print('clicked on row $row column $column');
    playersTurn = false;
    field[row][column] = playerChar;

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        checkForVictory();
      });
    });
  }

  void displayAiTurn() {
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        // AI turn
        var aiDecision = ai.getDecision();
        field[aiDecision.row][aiDecision.column] = aiChar;
        playersTurn = true;
        Timer(Duration(milliseconds: 600), () {
          setState(() {
            checkForVictory();
          });
        });
      });
    });
  }

  bool allCellsAreTaken() {
    return field[0][0].isNotEmpty &&
        field[0][1].isNotEmpty &&
        field[0][2].isNotEmpty &&
        field[1][0].isNotEmpty &&
        field[1][1].isNotEmpty &&
        field[1][2].isNotEmpty &&
        field[2][0].isNotEmpty &&
        field[2][1].isNotEmpty &&
        field[2][2].isNotEmpty;
  }

  bool gameIsDone() {
    return allCellsAreTaken() || victory != null;
  }
}
