import 'package:flutter/material.dart';

import '../../database/auth_methods.dart';
import '../../models/snake.dart';
import '../../widgets/custom_widgets/custom_url_slider.dart';
import '../../widgets/custom_widgets/text_tag_widget.dart';
import 'edit_snake_screen.dart';

class SnakeDetailScreen extends StatelessWidget {
  const SnakeDetailScreen({required this.snake, super.key});
  final Snake snake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(snake.name),
        actions: <Widget>[
          AuthMethods.getCurrentUser == null
              ? const SizedBox()
              : TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute<EditSnakeScreen>(
                      builder: (BuildContext context) =>
                          EditSnakeScreen(snake: snake),
                    ));
                  },
                  child: const Text(
                    'Edit Snake',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomUrlSlider(urls: snake.imageURL),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snake.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    snake.scientificName,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Average Length: ${snake.averageLengthCM}cm'),
                  const SizedBox(height: 8),
                  const Divider(),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Venomous Level: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          snake.level.title,
                          style: TextStyle(
                            color: snake.level.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tags',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    children: snake.tags
                        .map((String e) => TextTagWidget(text: e))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Properties',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    children: snake.properties
                        .map((String e) => TextTagWidget(text: e))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
