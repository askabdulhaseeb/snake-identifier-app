import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../enum/user_role.dart';
import '../../models/app_user.dart';
import '../../providers/snake_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/snake/snakes_gridview.dart';
import '../snakes/add_snake_screen.dart';
import '../snakes/snake_compare_screen.dart';
import '../user_screens/user_search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    final UserRole role = (Provider.of<UserProvider>(context, listen: false)
                .user(AuthMethods.uid) ??
            AppUser(uid: '', email: '', role: UserRole.user))
        .role;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(UserSearchScreen.routeName),
            child: const Text(
              'Campare',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<SnakeProvider>(
          builder: (BuildContext context, SnakeProvider snakePro, _) =>
              SnakesGridView(snakes: snakePro.snakes),
        ),
      ),
      floatingActionButton: role == UserRole.user
          ? null
          : FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddSnakeScreen.routeName),
              child: const Icon(Icons.add),
            ),
    );
  }
}
