import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_providers/_state.dart';

class ValueWithUsd extends HookWidget {
  final int value;
  final f = NumberFormat.currency(symbol: "", decimalDigits: 0);

  ValueWithUsd({required this.value});

  @override
  Widget build(BuildContext context) {
    final cgProvider = useProvider(coinGeckoProvider);

    return Row(
      children: [
        SelectableText(f.format(value)),
        SelectableText(
          cgProvider.runePrice != null
              ? "(\$${f.format(value * cgProvider.runePrice)})"
              : "",
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final Widget child;
  final double width;

  StatItem({required this.label, required this.child, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            label,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12),
          ),
          child
        ],
      ),
    );
  }
}
