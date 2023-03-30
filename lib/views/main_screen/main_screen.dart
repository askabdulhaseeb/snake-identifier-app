import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/snake.dart';
import '../../providers/snake_provider.dart';
import '../../widgets/snake/snakes_gridview.dart';
import '../snakes/add_snake_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text(
              'Campare',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<SnakeProvider>(
          builder: (BuildContext context, SnakeProvider snakePro, _) =>
              SnakesGridView(snakes: snakePro.snakes),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddSnakeScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
