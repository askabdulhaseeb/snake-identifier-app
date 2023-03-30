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
                  const Text(
                    'Tags',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    children: snake.tags
                        .map(
                          (String e) => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
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
                        .map(
                          (String e) => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
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
