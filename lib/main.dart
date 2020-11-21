import 'package:TikTacToe_AI/Screen/splashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //AI integration not done

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI ko ALU CROSS',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
