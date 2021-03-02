import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/tc_actions_provider.dart';
import 'package:thorchain_explorer/_widgets/address_link.dart';
import 'package:thorchain_explorer/_widgets/coin_amounts_list.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/meta_tag.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_link.dart';

class TransactionPage extends HookWidget {
  final String query;
  // final String graphQlQuery;

  TransactionPage(this.query);

  final dateFormatter = new DateFormat.yMMMMd('en_US').add_jm();

  @override
  Widget build(BuildContext context) {
    final params = FetchActionParams(offset: 0, limit: 10, txId: query);

    return TCScaffold(
      currentArea: PageOptions.Transactions,
      child: HookBuilder(builder: (context) {
        final response = useProvider(actions(params));
        //
        return response.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (response) {
            print("RESPONSE IN VIEW $response");

            int count = int.parse(response.count);

            if (0 < count) {
              TcAction action = response.actions[0];
              DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(action.date) ~/ 1000);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          'Transaction',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SelectableText(
                          query,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SelectableText(dateFormatter.format(dateTime)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      decoration: containerBoxDecoration(context),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: createActionTxItems(
                                      context, action.inputs, 'In'),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: createActionTxItems(
                                      context, action.outputs, 'Out'),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          "Block",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize: 12),
                                        ),
                                        SelectableText(action.height)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          "Status",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize: 12),
                                        ),
                                        SelectableText(action.status)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          "Type",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize: 12),
                                        ),
                                        SelectableText(action.type)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Material(
                elevation: 1,
                child: Container(
                  decoration: containerBoxDecoration(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 72),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sorry, we're unable to find this transaction",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.blueGrey[900]
                                : Colors.blueGrey[100],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: SelectableText(
                                    'THORChain.net only provides an overview of the current state of the blockchain such as your transaction status, but we have no control over these transactions.'),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: SelectableText(
                                      '1) If you have just submitted a transaction please wait for at least 30 seconds before refreshing this page.'),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: SelectableText(
                                      '2) It could still be processing on a different network, waiting to be picked up by the THORChain network.'),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: SelectableText(
                                      '3) When the network is busy it can take a while for your transaction to propagate through the network and for Midgard to index it.'),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }

  List<Widget> createActionTxItems(
      BuildContext context, List<ActionTx> txs, String tag) {
    Color tagColor = tag == 'In' ? Colors.blue : Colors.green;

    return txs
        .map((tx) => Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MetaTag(tag, tagColor),
                      SizedBox(
                        width: 12,
                      ),
                      TxLink(tx.txID),
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                              iconSize: 12,
                              icon: Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: tx.txID));

                                final snackBar = SnackBar(
                                    content: Text('Transaction ID Copied'));

                                // Find the Scaffold in the widget tree and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }),
                        ),
                      ),
                    ],
                  ),
                  CoinAmountsList(tx.coins),
                  SizedBox(height: 12),
                  AddressLink(tx.address ?? ''),
                  SelectableText(
                    tx.memo ?? '',
                  )
                ],
              ),
            ))
        .toList();
  }
}
