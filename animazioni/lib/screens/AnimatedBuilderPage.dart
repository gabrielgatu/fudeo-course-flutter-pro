import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBuilderPage extends StatefulWidget {
  @override
  _AnimatedBuilderPageState createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedBuilder"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => animationController.stop(),
            icon: Icon(Icons.stop),
          ),
          IconButton(
            onPressed: () => animationController.repeat(),
            icon: Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: Container(color: Colors.black, child: Center(child: galaxy())),
    );
  }

  Widget galaxy() => AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Transform.rotate(
            angle: animationController.value * math.pi * 2,
            child: child,
          ),
      child: Image.network("https://upload.wikimedia.org/wikipedia/commons/8/83/Galaxy.png"));
}
