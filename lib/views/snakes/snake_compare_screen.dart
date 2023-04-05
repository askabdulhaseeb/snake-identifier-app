import 'package:flutter/material.dart';

import '../../models/snake.dart';
import '../../widgets/custom_widgets/custom_network_image.dart';
import '../../widgets/snake/snake_search_widget.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final Snake? temp = await showDialog<Snake?>(
                        context: context,
                        builder: (BuildContext context) =>
                            const SnakeSearchWidget(),
                      );
                      if (temp != null) {
                        setState(() {
                          snake1 = temp;
                        });
                      }
                    },
                    child: SelectSnakeWidget(
                      title: 'Select 1st',
                      snake: snake1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Snake? temp = await showDialog<Snake?>(
                        context: context,
                        builder: (BuildContext context) =>
                            const SnakeSearchWidget(),
                      );
                      if (temp != null) {
                        setState(() {
                          snake2 = temp;
                        });
                      }
                    },
                    child: SelectSnakeWidget(
                      title: 'Select 2nd',
                      snake: snake2,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(24),
                child: Divider(color: Colors.grey),
              ),
              snake1 == null || snake2 == null
                  ? const Center(
                      child: Text(
                      'Select Both snake to Compare',
                      style: TextStyle(color: Colors.grey),
                    ))
                  : Column(
                      children: <Widget>[
                        Text(
                          'Basic',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        _Name(snake1: snake1, snake2: snake2),
                        const SizedBox(height: 16),
                        Text(
                          'Length',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        _Length(snake1: snake1, snake2: snake2),
                        const SizedBox(height: 16),
                        Text(
                          'Venomous Level',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              snake1!.level.title,
                              style: TextStyle(color: snake1!.level.color),
                            ),
                            Text(
                              snake2!.level.title,
                              style: TextStyle(color: snake2!.level.color),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Properties',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        _Properties(snake1: snake1, snake2: snake2),
                        const SizedBox(height: 40),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Properties extends StatelessWidget {
  const _Properties({required this.snake1, required this.snake2});

  final Snake? snake1;
  final Snake? snake2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: snake1!.properties.length,
            itemBuilder: (BuildContext context, int index) =>
                Text('${index + 1} - ${snake1!.properties[index]}'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: snake2!.properties.length,
            itemBuilder: (BuildContext context, int index) =>
                Text('${index + 1} - ${snake2!.properties[index]}'),
          ),
        ),
      ],
    );
  }
}

class _Length extends StatelessWidget {
  const _Length({required this.snake1, required this.snake2});

  final Snake? snake1;
  final Snake? snake2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Average Length\n ${snake1!.averageLengthCM} CM',
          textAlign: TextAlign.center,
        ),
        Text(
          'Average Length\n ${snake2!.averageLengthCM} CM',
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({required this.snake1, required this.snake2});

  final Snake? snake1;
  final Snake? snake2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              snake1!.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              snake1!.scientificName,
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              snake2!.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              snake2!.scientificName,
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SelectSnakeWidget extends StatelessWidget {
  const SelectSnakeWidget({
    required this.title,
    required this.snake,
    super.key,
  });
  final String title;
  final Snake? snake;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120,
        width: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: snake != null
              ? SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomNetworkImage(imageURL: snake?.imageURL[0] ?? ''),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const Text(
                      'Tap to choose',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
