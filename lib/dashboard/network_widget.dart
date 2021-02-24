import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_network.dart';
import 'package:thorchain_explorer/_widgets/stat_list_item.dart';

class NetworkWidget extends StatelessWidget {
  final TCNetwork network;
  NetworkWidget(this.network);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );

    return Container(
      height: 540,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Network"),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Theme.of(context).dividerColor))),
          ),
          StatListItem(
              label: "Bonding APY",
              value: network.bondingAPY.round().toString()),
          StatListItem(
              label: "Active Node Count",
              value: f.format(network.activeNodeCount)),
          StatListItem(
              label: "Liquidity APY", value: "${network.liquidityAPY}%"),
          StatListItem(
              label: "Next Churn Height",
              value: network.nextChurnHeight.toString()),
          StatListItem(
              label: "Pool Activation Countdown",
              value: network.poolActivationCountdown.toString()),
          StatListItem(
              label: "Pool Share Factor", value: "${network.poolShareFactor}"),
          StatListItem(
              label: "Total Reserve",
              value: f.format(network.totalReserve / pow(10, 8))),
          StatListItem(
              label: "Standby Node Count",
              value: f.format(network.standbyNodeCount)),
          StatListItem(
              label: "Total Pooled Rune",
              value: f.format(network.totalPooledRune / pow(10, 8))),

          // // hide until implemented
          Container(
            child: Expanded(
              child: FlatButton(
                child: Text(
                  'View Network Details',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () => Navigator.pushNamed(context, '/network'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
