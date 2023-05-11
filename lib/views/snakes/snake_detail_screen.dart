import 'package:flutter/material.dart';

import '../../database/auth_methods.dart';
import '../../models/snake.dart';
import '../../widgets/custom_widgets/custom_network_image.dart';
import '../../widgets/custom_widgets/custom_url_slider.dart';
import '../../widgets/custom_widgets/text_tag_widget.dart';
import '../../widgets/snake/snake_scale_url_not_available.dart';
import 'edit_snake_screen.dart';

class SnakeDetailScreen extends StatelessWidget {
  const SnakeDetailScreen({required this.snake, super.key});
  final Snake snake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(snake.scientificName),
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
                  child: const Text('Edit Snake'),
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
                    snake.scientificName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    snake.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text('Average Length: ${snake.averageLengthCM}cm'),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: snake.scaleURL.isEmpty
                          ? const SnakeScaleUrlNotAvailable()
                          : CustomNetworkImage(imageURL: snake.scaleURL),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 4,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, int index) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: snake.scaleURL.isEmpty
                                ? SnakeScaleUrlNotAvailable(
                                    title: 'No Image ${index + 1}',
                                  )
                                : CustomNetworkImage(
                                    imageURL: index == 0
                                        ? snake.image1
                                        : index == 1
                                            ? snake.image2
                                            : index == 2
                                                ? snake.image3
                                                : snake.image4),
                          ),
                        ),
                      ),
                    ),
                  ),
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
