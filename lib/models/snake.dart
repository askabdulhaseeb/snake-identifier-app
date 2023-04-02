import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/auth_methods.dart';
import '../enum/venomous_type.dart';
import 'edit_history.dart';

class Snake {
  Snake({
    required this.name,
    required this.scientificName,
    required this.imageURL,
    required this.averageLengthCM,
    required this.tags,
    required this.level,
    required this.properties,
    String? uploadedBy,
    List<EditHistory>? history,
  })  : uploadedBy = uploadedBy ?? AuthMethods.uid,
        history = history ?? <EditHistory>[];

  final String name;
  final String scientificName;
  final List<String> imageURL;
  final double averageLengthCM;
  final List<String> tags;
  final VenomousLevel level;
  final List<String> properties;
  final String uploadedBy;
  final List<EditHistory> history;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'scientific_name': scientificName,
      'image_url': imageURL,
      'average_length_cm': averageLengthCM,
      'tags': tags,
      'level': level.json,
      'properties': properties,
      'uploaded_by': uploadedBy,
      'history': history.map((EditHistory e) => e.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory Snake.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final List<dynamic> data = doc.data()?['history'] ?? <dynamic>[];
    final List<EditHistory> editHistory = <EditHistory>[];
    for (dynamic element in data) {
      editHistory.add(EditHistory.fromDoc(element));
    }
    return Snake(
      name: doc.data()?['name'] ?? '',
      uploadedBy: doc.data()?['name'] ?? 'uploaded_by',
      scientificName: doc.data()?['scientific_name'] ?? '',
      imageURL: List<String>.from((doc.data()?['image_url'] ?? <String>[])),
      averageLengthCM: doc.data()?['average_length_cm'] ?? 0.0,
      tags: List<String>.from((doc.data()?['tags'] ?? <String>[])),
      level: VenomousLevelConvertor().toEnum(
        doc.data()?['level'] ?? VenomousLevel.cautionVenomous.json,
      ),
      properties: List<String>.from((doc.data()?['properties'] ?? <String>[])),
      history: editHistory,
    );
  }
}
