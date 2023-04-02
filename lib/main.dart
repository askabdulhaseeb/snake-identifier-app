import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/auth_methods.dart';
import 'firebase_options.dart';
import 'providers/mail_auth_provider.dart';
import 'providers/snake_provider.dart';
import 'providers/user_provider.dart';
import 'views/auth/sign_in_screen.dart';
import 'views/auth/sign_up_screen.dart';
import 'views/main_screen/main_screen.dart';
import 'views/snakes/add_snake_screen.dart';
import 'views/snakes/snake_compare_screen.dart';
import 'views/snakes/snakes_screen.dart';
import 'views/user_screens/user_search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) => UserProvider(),
        ),
        ChangeNotifierProvider<SnakeProvider>(
          create: (BuildContext context) => SnakeProvider(),
        ),
        ChangeNotifierProvider<MailAuthProvider>.value(
          value: MailAuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Snakes Info',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthMethods.getCurrentUser == null
            ? const SignInScreen()
            : const MainScreen(),
        routes: <String, WidgetBuilder>{
          SignInScreen.routeName: (_) => const SignInScreen(),
          SignUpScreen.routeName: (_) => const SignUpScreen(),
          MainScreen.routeName: (_) => const MainScreen(),
          UserSearchScreen.routeName: (_) => const UserSearchScreen(),
          SnakesScreen.routeName: (_) => const SnakesScreen(),
          AddSnakeScreen.routeName: (_) => const AddSnakeScreen(),
          SnakeCompareScreen.routeName: (_) => const SnakeCompareScreen(),
        },
      ),
    );
  }
}
