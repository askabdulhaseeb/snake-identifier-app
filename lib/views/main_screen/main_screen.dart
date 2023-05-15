import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../enum/user_role.dart';
import '../../models/app_user.dart';
import '../../providers/user_provider.dart';
import '../../widgets/dashboard/dashboard_gridview.dart';
import '../snakes/add_snake_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    final UserRole role =
        (Provider.of<UserProvider>(context).user(AuthMethods.uid) ??
                AppUser(uid: '', email: '', role: UserRole.user))
            .role;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Australian Snake Identification'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await AuthMethods().signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            SizedBox(height: 16),
            DashboardGridview(),
            SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: role == UserRole.user
          ? null
          : FloatingActionButton(
              onPressed: () => AuthMethods.getCurrentUser == null
                  ? null
                  : Navigator.of(context).pushNamed(AddSnakeScreen.routeName),
              child: const Icon(Icons.add),
            ),
    );
  }
}
