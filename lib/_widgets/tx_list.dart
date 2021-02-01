import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_widgets/address_link.dart';
import 'package:thorchain_explorer/_widgets/coin_amounts_list.dart';
import 'package:thorchain_explorer/_widgets/meta_tag.dart';
import 'package:thorchain_explorer/_widgets/tx_link.dart';

class TxList extends StatelessWidget {

  final List<TcAction> actions;
  final dateFormatter = new DateFormat('M/d/yy H:m:s');

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

    // Color tagColor = tag == 'In' ? Colors.blue : Colors.green;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.map((tx) {

          DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(tx.date) ~/ 1000);

          return Container(
            // padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: (tx.date != actions[actions.length - 1].date)
                  ? Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).dividerColor
                    )
                  )
                  : Border()
            ),
            child: Container(
              padding: EdgeInsets.only(top: 12, bottom: 8, left: 12, right: 12),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tx.type),
                        Text(dateFormatter.format(dateTime))
                      ],
                    ),
                  ),

                  Container(
                    // width: 200,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(width: 12,),
                                  TxLink(input.txID)
                                ],
                              ),
                              SizedBox(height: 6,),
                              CoinAmountsList(input.coins),
                              SizedBox(height: 6,),
                              AddressLink(input.address),
                              SizedBox(height: 6,),
                            ],
                          ),
                        );
                      }
                      ).toList(),
                    ),
                  ),
                  // SizedBox(width: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tx.outputs.map((output) {
                      return Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MetaTag('Out', Colors.green),
                                SizedBox(width: 12,),
                                TxLink(output.txID)
                              ],
                            ),
                            SizedBox(height: 6,),
                            CoinAmountsList(output.coins),
                            SizedBox(height: 6,),
                            AddressLink(output.address),
                            SizedBox(height: 6,),
                          ],
                        ),
                      );
                    },
                    ).toList(),
                  ),
                  // Expanded()
                  // SizedBox(height: 12,)
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
