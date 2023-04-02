import 'package:cloud_firestore/cloud_firestore.dart';

class EditHistory {
  EditHistory({
    required this.uid,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final String uid;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  // ignore: sort_constructors_first
  factory EditHistory.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return EditHistory(
      uid: doc.data()?['uid'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
    );
  }
}
