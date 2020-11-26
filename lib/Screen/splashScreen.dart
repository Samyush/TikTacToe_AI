import 'dart:async';

import 'package:TikTacToe_AI/Screen/gameScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Category category;
  List<Category> status;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                Game(title: 'AI ko ALU CROSS'))));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: queryData.size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/brainGame.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
            child: Image.asset(
          'images/alucross.gif',
          height: queryData.size.height / 1.8,
          width: queryData.size.width / 1.8,
        )),
      ),
    );
  }
}
