import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Main')));
  }
}
