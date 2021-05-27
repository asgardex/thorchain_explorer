import 'package:flutter/material.dart';

class PaddedTableCell extends StatelessWidget {
  final Widget child;

  PaddedTableCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: child,
    ));
  }
}
