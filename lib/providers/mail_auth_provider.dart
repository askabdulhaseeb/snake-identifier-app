import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../database/auth_methods.dart';
import '../../database/user_api.dart';
import '../../models/app_user.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class MailAuthProvider extends ChangeNotifier {
  onLogin(BuildContext context) async {
    if (!loginKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    final User? user = await AuthMethods()
        .loginWithEmailAndPassword(_email.text.trim(), _password.text.trim());
    if (user == null) {
      CustomToast.errorToast(message: 'Invalid email or password');
      return;
    }
    final AppUser? appUser = await UserAPI().user(uid: user.uid);
    if (appUser == null) {
      CustomToast.errorToast(
          message: 'Something wents wrong, please contact support');
      return;
    }
    _isLoading = false;
    notifyListeners();
    // ignore: use_build_context_synchronously
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     DashboardScreen.routeName, (Route<dynamic> route) => false);
  }

  register(BuildContext context) async {
    if (!registerKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    final User? user = await AuthMethods()
        .signupWithEmailAndPassword(_email.text.trim(), _password.text.trim());
    if (user == null) {
      CustomToast.errorToast(message: 'Invalid email or password');
      _isLoading = false;
      notifyListeners();
      return;
    }
    final AppUser appUser = AppUser(
      uid: user.uid,
      email: _email.text,
      displayName: _name.text.trim(),
    );
    final bool done = await UserAPI().register(user: appUser);
    _isLoading = false;
    notifyListeners();
    if (!done) {
      return;
    }
    // ignore: use_build_context_synchronously
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     DashboardScreen.routeName, (Route<dynamic> route) => false);
  }

  //
  // Getter
  TextEditingController get name => _name;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  bool get isLoading => _isLoading;
  //
  // Variable
  bool _isLoading = false;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
}
