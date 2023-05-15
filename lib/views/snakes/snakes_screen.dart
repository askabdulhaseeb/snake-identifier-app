import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/snake_provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/snake/snakes_gridview.dart';
import 'snake_compare_screen.dart';

class SnakesScreen extends StatelessWidget {
  const SnakesScreen({super.key});
  static const String routeName = '/snakes';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.forest),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SnakeCompareScreen.routeName),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Compare',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Consumer<SnakeProvider>(
          builder: (BuildContext context, SnakeProvider snakePro, _) =>
              SnakesGridView(snakes: snakePro.snakes),
        ),
      ),
    );
  }
}
