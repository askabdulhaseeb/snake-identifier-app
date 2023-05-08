import 'package:flutter/foundation.dart';
import '../database/auth_methods.dart';
import '../database/user_api.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _init();
  }

  AppUser? user(String uid) {
    int index = _indexOf(uid);
    if (kDebugMode) {
      print('$uid - index:$index');
    }
    return index < 0 ? null : _users[index];
  }

  List<AppUser> filterUser() {
    final String me = AuthMethods.uid;
    return _users
        .where((AppUser element) =>
            (element.displayName)
                .toLowerCase()
                .contains(_searchText.trim().toLowerCase()) &&
            element.uid != me)
        .toList();
  }

  onSearch(String? value) {
    _searchText = value ?? '';
    notifyListeners();
  }

  final List<AppUser> _users = <AppUser>[];
  String _searchText = '';

  Future<void> refresh() async {
    _users.clear();
    _init();
    notifyListeners();
  }

  _init() async {
    final List<AppUser> temp = await UserAPI().getAllUsers();
    _users.addAll(temp);
    notifyListeners();
  }

  int _indexOf(String uid) {
    int index = _users
        .indexWhere((AppUser element) => element.uid.trim() == uid.trim());
    return index;
  }
}
