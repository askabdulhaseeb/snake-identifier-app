import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../views/auth/sign_in_screen.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;
  static String get uid => _auth.currentUser?.uid ?? 'guest';
  static String get uniqueID =>
      '''${_auth.currentUser?.uid ?? 'null'}${DateTime.now().microsecondsSinceEpoch}''';

  Future<User?>? signupWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  Future<void> deleteAccount() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    final QuerySnapshot<Map<String, dynamic>> products = await FirebaseFirestore
        .instance
        .collection('products')
        .where('uid', isEqualTo: uid)
        .get();
    if (products.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in products.docs) {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(doc.data()?['pid'])
            .delete();
      }
      await FirebaseStorage.instance.ref('products/$uid').delete();
    }
    await _auth.currentUser!.delete();
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName, (Route<dynamic> route) => false);
  }
}
