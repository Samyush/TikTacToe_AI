import 'package:flutter/material.dart';

import 'circlePainter.dart';

class Circle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CircleState();
}

class CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  CirclePainter painter;
  Animation<double> animation;
  AnimationController controller;
  double fraction = 0.0;

  //TO:DO to solve up the error upon vsync of this page

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          fraction = animation.value;
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    painter = CirclePainter(fraction);
    return CustomPaint(painter: painter);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
