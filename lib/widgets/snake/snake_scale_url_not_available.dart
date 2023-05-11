import 'package:flutter/material.dart';

class SnakeScaleUrlNotAvailable extends StatelessWidget {
  const SnakeScaleUrlNotAvailable({this.title = 'No Scale', super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
