import 'package:flutter/material.dart';

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
            child: const Text('Campare'),
          ),
        ],
      ),
      body: Center(
        child: Text('Main'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>Navigator.of(context).pushNamed(AddSnakeScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
