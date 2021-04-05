import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_widgets/address_link.dart';
import 'package:thorchain_explorer/_widgets/coin_amounts_list.dart';
import 'package:thorchain_explorer/_widgets/meta_tag.dart';
import 'package:thorchain_explorer/_widgets/tx_link.dart';

class TxList extends StatelessWidget {
  final List<TcAction> actions;
  final dateFormatter = new DateFormat.yMd().add_jm();

  TxList(this.actions);

  @override
  Widget build(BuildContext context) {
    return actions.length < 1
        ? Center(
            child: Text('No Transactions Found'),
          )
        : buildActionsList(actions, context);
  }

  Widget buildActionsList(List<TcAction> actions, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: actions.map((tx) {
        DateTime dateTime =
            DateTime.fromMicrosecondsSinceEpoch(int.parse(tx.date) ~/ 1000);

        return Container(
          height: 100,
          decoration: BoxDecoration(
              border: (tx.date != actions[actions.length - 1].date)
                  ? Border(
                      bottom: BorderSide(
                          width: 1, color: Theme.of(context).dividerColor))
                  : Border()),
          child: Container(
            padding: EdgeInsets.only(top: 12, bottom: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 12),
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tx.type),
                      Text(dateFormatter.format(dateTime))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: tx.inputs.map((input) {
                      return Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MetaTag('In', Colors.blue),
                                SizedBox(
                                  width: 12,
                                ),
                                TxLink(input.txID)
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            CoinAmountsList(input.coins),
                            SizedBox(
                              height: 6,
                            ),
                            AddressLink(input.address),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tx.outputs.map(
                    (output) {
                      return Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MetaTag('Out', Colors.green),
                                SizedBox(
                                  width: 12,
                                ),
                                TxLink(output.txID)
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            CoinAmountsList(output.coins),
                            SizedBox(
                              height: 6,
                            ),
                            AddressLink(output.address),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
