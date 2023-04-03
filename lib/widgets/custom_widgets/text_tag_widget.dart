import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextTagWidget extends StatelessWidget {
  const TextTagWidget({required this.text, this.onDelete, super.key});
  final String text;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          if (onDelete != null)
            GestureDetector(
              onTap: onDelete,
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
