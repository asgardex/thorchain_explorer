import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';

class CoinAmountsList extends StatelessWidget {

  final List<CoinAmount> amounts;
  CoinAmountsList(this.amounts);

  final simpleCurrency = new NumberFormat.simpleCurrency();
  final test = new NumberFormat.currency(name: '');

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: amounts.map(
                  (e) => Row(
                children: [
                  AssetIcon(
                    e.asset,
                    width: 24,
                  ),
                  SizedBox(width: 8,),
                  Text(test.format(double.parse(e.amount) / pow(10, 8)))
                  // Text( (double.parse(e.amount) / pow(10, 8)).toStringAsFixed(4) )
                ],
              )
          ).toList(),
        ),
      );
  }
}
