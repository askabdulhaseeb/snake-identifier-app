import 'package:flutter/material.dart';

class SnakeScaleUrlNotAvailable extends StatelessWidget {
  const SnakeScaleUrlNotAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Text('No Scale'),
    );
  }
}