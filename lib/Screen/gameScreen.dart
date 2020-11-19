import 'package:TikTacToe_AI/GameUI/game_state.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BuildContext _context;

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
}
