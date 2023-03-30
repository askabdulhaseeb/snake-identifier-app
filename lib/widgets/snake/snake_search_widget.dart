import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/snake.dart';
import '../../providers/snake_provider.dart';
import '../custom_widgets/custom_network_image.dart';

class SnakeSearchWidget extends StatefulWidget {
  const SnakeSearchWidget({super.key});

  @override
  State<SnakeSearchWidget> createState() => _SnakeSearchWidgetState();
}

class _SnakeSearchWidgetState extends State<SnakeSearchWidget> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            CupertinoSearchTextField(
              onChanged: (String? value) => setState(() {
                search = value ?? '';
              }),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<SnakeProvider>(
                builder: (
                  BuildContext context,
                  SnakeProvider snakePro,
                  _,
                ) {
                  final List<Snake> snakes = snakePro.filterByName(search);
                  return ListView.builder(
                    itemCount: snakes.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(snakes[index]);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CustomNetworkImage(
                              imageURL: snakes[index].imageURL[0],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(snakes[0].name),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
