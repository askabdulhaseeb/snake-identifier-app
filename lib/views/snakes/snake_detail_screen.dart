import 'package:flutter/material.dart';

import '../../models/snake.dart';
import '../../widgets/custom_widgets/custom_url_slider.dart';

class SnakeDetailScreen extends StatelessWidget {
  const SnakeDetailScreen({required this.snake, super.key});
  final Snake snake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(snake.name)),
      body: Column(
        children: <Widget>[
          CustomUrlSlider(urls: snake.imageURL),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
