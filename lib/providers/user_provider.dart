import 'package:flutter/material.dart';

import '../database/user_api.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _init();
  }

  AppUser? user(String uid) {
    int index = _indexOf(uid);
    return index < 0 ? null : _users[index];
  }

  List<AppUser> filterUser() {
    return _users
        .where((AppUser element) => (element.displayName)
            .toLowerCase()
            .contains(_searchText.trim().toLowerCase()))
        .toList();
  }

  onSearch(String? value) {
    _searchText = value ?? '';
    notifyListeners();
  }

  final List<AppUser> _users = <AppUser>[];
  String _searchText = '';

  Future<void> refresh() async {
    _users.addAll(await UserAPI().getAllUsers());
    notifyListeners();
  }

  _init() async {
    _users.addAll(await UserAPI().getAllUsers());
    notifyListeners();
  }

  int _indexOf(String uid) {
    int index = _users.indexWhere((AppUser element) => element.uid == uid);
    return index;
  }
}
