import 'package:cloud_firestore/cloud_firestore.dart';

import '../enum/venomous_type.dart';

class Snake {
  Snake({
    required this.name,
    required this.scientificName,
    required this.imageURL,
    required this.averageLengthCM,
    required this.tags,
    required this.level,
    required this.properties,
  });

  final String name;
  final String scientificName;
  final List<String> imageURL;
  final double averageLengthCM;
  final List<String> tags;
  final VenomousLevel level;
  final List<String> properties;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'scientific_name': scientificName,
      'image_url': imageURL,
      'average_length_cm': averageLengthCM,
      'tags': tags,
      'level': level.json,
      'properties': properties,
    };
  }

  // ignore: sort_constructors_first
  factory Snake.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Snake(
      name: doc.data()?['name'] ?? '',
      scientificName: doc.data()?['scientific_name'] ?? '',
      imageURL: List<String>.from((doc.data()?['image_url'] ?? <String>[])),
      averageLengthCM: doc.data()?['average_length_cm'] ?? 0.0,
      tags: List<String>.from((doc.data()?['tags'] ?? <String>[])),
      level: VenomousLevelConvertor().toEnum(
        doc.data()?['level'] ?? VenomousLevel.cautionVenomous.json,
      ),
      properties: List<String>.from((doc.data()?['properties'] ?? <String>[])),
    );
  }
}
