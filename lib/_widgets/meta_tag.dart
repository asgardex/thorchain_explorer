import 'package:flutter/material.dart';

class MetaTag extends StatelessWidget {

  final String text;
  final Color color;

  MetaTag(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color
      ),
      child: Text(
        text,
      ),
    );
  }
}
