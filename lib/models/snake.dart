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
    String? scaleURL,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? sid,
    String? uploadedBy,
    List<EditHistory>? history,
  })  : sid = sid ?? AuthMethods.uniqueID,
        scaleURL = scaleURL ?? '',
        image1 = image1 ?? '',
        image2 = image2 ?? '',
        image3 = image3 ?? '',
        image4 = image4 ?? '',
        uploadedBy = uploadedBy ?? AuthMethods.uid,
        history = history ?? <EditHistory>[];

  final String sid;
  String name;
  String scientificName;
  final List<String> imageURL;
  double averageLengthCM;
  String scaleURL;
  String image1;
  String image2;
  String image3;
  String image4;
  List<String> tags;
  VenomousLevel level;
  List<String> properties;
  final String uploadedBy;
  final List<EditHistory> history;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sid': sid,
      'name': name,
      'scientific_name': scientificName,
      'image_url': imageURL,
      'average_length_cm': averageLengthCM,
      'scale_url': scaleURL,
      'image_url_1': image1,
      'image_url_2': image2,
      'image_url_3': image3,
      'image_url_4': image4,
      'tags': tags,
      'level': level.json,
      'properties': properties,
      'uploaded_by': uploadedBy,
      'history': history.map((EditHistory e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> updateSnake() {
    return <String, dynamic>{
      'name': name,
      'scientific_name': scientificName,
      'average_length_cm': averageLengthCM,
      'scale_url': scaleURL,
      'image_url_1': image1,
      'image_url_2': image2,
      'image_url_3': image3,
      'image_url_4': image4,
      'tags': tags,
      'level': level.json,
      'properties': properties,
      'history': history.map((EditHistory e) => e.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory Snake.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final List<dynamic> data = doc.data()?['history'] ?? <dynamic>[];
    final List<EditHistory> editHistory = <EditHistory>[];
    for (dynamic element in data) {
      editHistory.add(EditHistory.fromMap(element));
    }
    return Snake(
      sid: doc.data()?['sid'] ?? '',
      name: doc.data()?['name'] ?? '',
      uploadedBy: doc.data()?['name'] ?? 'uploaded_by',
      scientificName: doc.data()?['scientific_name'] ?? '',
      imageURL: List<String>.from((doc.data()?['image_url'] ?? <String>[])),
      scaleURL: doc.data()?['scale_url'] ?? '',
      image1: doc.data()?['image_url_1'] ?? '',
      image2: doc.data()?['image_url_2'] ?? '',
      image3: doc.data()?['image_url_3'] ?? '',
      image4: doc.data()?['image_url_4'] ?? '',
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
