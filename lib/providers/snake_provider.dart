import 'package:flutter/foundation.dart';
import '../database/snake_api.dart';
import '../models/snake.dart';

class SnakeProvider extends ChangeNotifier {
  SnakeProvider() {
    _init();
  }

  _init() async {
    try {
      final List<Snake> temp = await SnakeAPI().allSnakes();
      _snakes.clear();
      _snakes.addAll(temp);
    } catch (e) {
      if (kDebugMode) {
        print('Snake Provider: Error - ${e.toString()}');
      }
    }
    notifyListeners();
  }

  refresh() async {
    await _init();
  }

  List<Snake> filterByName(String value) {
    return _snakes
        .where((Snake element) =>
            element.name
                .trim()
                .toLowerCase()
                .contains(value.trim().toLowerCase()) ||
            element.scientificName
                .trim()
                .toLowerCase()
                .contains(value.trim().toLowerCase()))
        .toList();
  }

  final List<Snake> _snakes = <Snake>[];
  List<Snake> get snakes => _snakes;
}
