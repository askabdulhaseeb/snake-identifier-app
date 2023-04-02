import 'package:cloud_firestore/cloud_firestore.dart';

import '../enum/user_role.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.email,
    this.displayName = '',
    this.imageURL = '',
    UserRole? role,
  }) : role = role ?? UserRole.user;

  final String uid;
  String displayName;
  String imageURL;
  final String email;
  UserRole role;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': displayName,
      'image_url': imageURL,
      'role': role.json,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(
      uid: doc.data()?['uid'] ?? '',
      displayName: doc.data()?['name'] ?? '',
      imageURL: doc.data()?['image_url'] ?? '',
      email: doc.data()?['email'] ?? '',
      role:
          UserRoleConvertor().toEnum(doc.data()?['role'] ?? UserRole.user.json),
    );
  }
}
