import 'package:flutter/material.dart';

class CustomShadowBgWidget extends StatelessWidget {
  const CustomShadowBgWidget({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 4.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 5  horizontally
              2.0, // Move to bottom 5 Vertically
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
