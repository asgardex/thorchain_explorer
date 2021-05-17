import 'package:flutter/material.dart';

class StatListItem extends StatelessWidget {
  final String label;
  final String value;
  final bool hideBorder;

  StatListItem(
      {@required this.label, @required this.value, this.hideBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(
            this.label,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12),
          ),
          SelectableText(this.value)
        ],
      ),
      decoration: BoxDecoration(
          border: !hideBorder
              ? Border(
                  bottom: BorderSide(
                      width: 1, color: Theme.of(context).dividerColor))
              : null),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }
}
