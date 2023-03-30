import 'package:flutter/material.dart';

import '../../models/snake.dart';
import 'snake_small_tile.dart';

class SnakesGridView extends StatelessWidget {
  const SnakesGridView({required this.snakes, Key? key}) : super(key: key);
  final List<Snake> snakes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 4 / 5,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: snakes.length,
      itemBuilder: (BuildContext context, int index) =>
          SnakeSmallTile(snake: snakes[index]),
    );
  }
}
