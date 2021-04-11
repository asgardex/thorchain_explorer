import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TxLink extends StatelessWidget {
  final String txId;

  TxLink(this.txId);

  @override
  Widget build(BuildContext context) {
    return (txId != null && txId.length > 4)
        ? Tooltip(
            message: txId,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/txs/$txId');
                },
                child: Text(
                  '${txId.substring(0, 4)}...${txId.substring(txId.length - 4, txId.length)}',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        : Container();
  }
}
