import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_utils/asset_utils.dart';
import 'package:thorchain_explorer/_widgets/address_link.dart';
import 'package:thorchain_explorer/_widgets/coin_amounts_list.dart';
import 'package:thorchain_explorer/_widgets/external_explorer_link.dart';
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
                                TxLink(input.txID),
                                SizedBox(
                                  width: 8,
                                ),
                                input.coins.length > 0 &&
                                        assetFromString(input.coins[0].asset)
                                                ?.chain !=
                                            'THOR'
                                    ? ExternalExplorerLink(
                                        type: ExplorerLinkType.Tx,
                                        hash: input.txID,
                                        asset: input.coins[0].asset)
                                    : Container()
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
                                TxLink(output.txID),
                                SizedBox(
                                  width: 8,
                                ),
                                output.coins.length > 0 &&
                                        assetFromString(output.coins[0].asset)
                                                ?.chain !=
                                            'THOR'
                                    ? ExternalExplorerLink(
                                        type: ExplorerLinkType.Tx,
                                        hash: output.txID,
                                        asset: output.coins[0].asset)
                                    : Container()
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
