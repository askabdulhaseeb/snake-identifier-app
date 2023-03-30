import 'package:flutter/material.dart';

import '../../models/snake.dart';

class SnakeCompareScreen extends StatefulWidget {
  const SnakeCompareScreen({super.key});
  static const String routeName = '/snake-compare';

  @override
  State<SnakeCompareScreen> createState() => _SnakeCompareScreenState();
}

class _SnakeCompareScreenState extends State<SnakeCompareScreen> {
  Snake? snake1;
  Snake? snake2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Compare Snakes',
      )),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
