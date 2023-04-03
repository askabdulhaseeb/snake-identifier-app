import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/auth_methods.dart';

class EditHistory {
  EditHistory({
    String? uid,
    DateTime? timestamp,
  })  : uid = uid ?? AuthMethods.uid,
        timestamp = timestamp ?? DateTime.now();

  final String uid;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  // ignore: sort_constructors_first
  factory EditHistory.fromMap(Map<String, dynamic> map) {
    return EditHistory(
      uid: map['uid'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
    );
  }
}
