import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'dart:math';

class AddressHeader extends HookWidget {
  final String address;

  const AddressHeader(this.address);

  @override
  Widget build(BuildContext context) {
    final thorBalance = useProvider(bankBalancesProvider(address));
    final f = new NumberFormat.currency(name: '', decimalDigits: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'Address',
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SelectableText(
              address,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 8,
            ),
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                    iconSize: 16,
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: address));

                      final snackBar =
                          SnackBar(content: Text('Address Copied'));

                      // Find the Scaffold in the widget tree and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
              ),
            ),
          ],
        ),
        (thorBalance != null)
            ? Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  thorBalance.maybeWhen(
                      data: (data) => (data != null)
                          ? Row(
                              children: [
                                AssetIcon(
                                  'THOR.RUNE',
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                SelectableText(
                                  "Balance: ${(data.result.length > 0) ? f.format(double.parse(data.result[0].amount) / pow(10, 8)) : 0}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          : Container(),
                      orElse: () => Container())
                ],
              )
            : Container()
      ],
    );
  }
}
