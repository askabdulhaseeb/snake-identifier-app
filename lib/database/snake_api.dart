import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/snake.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class SnakeAPI {
  static const String _collection = 'snakes';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<void> add(Snake snake) async {
    try {
      await _instance.collection(_collection).doc().set(snake.toMap());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<Snake?> snake(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _instance.collection(_collection).doc(id).get();
      return Snake.fromMap(doc);
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return null;
    }
  }

  Future<List<Snake>> allSnakes(Snake snake) async {
    final List<Snake> snakes = <Snake>[];
    try {
      final QuerySnapshot<Map<String, dynamic>> docs =
          await _instance.collection(_collection).get();
      for (DocumentSnapshot<Map<String, dynamic>> element in docs.docs) {
        final Snake temp = Snake.fromMap(element);
        snakes.add(temp);
      }
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return snakes;
  }
}
