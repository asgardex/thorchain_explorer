import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';
import 'dart:math';

class AddressPage extends HookWidget {
  final String address;

  AddressPage(this.address);

  @override
  Widget build(BuildContext context) {
    final params = FetchActionParams(offset: 0, limit: 10, address: address);
    final f = new NumberFormat.currency(name: '', decimalDigits: 2);

    return TCScaffold(
        currentArea: PageOptions.Transactions,
        child: HookBuilder(builder: (context) {
          final response = useProvider(actions(params));
          final thorBalance = useProvider(bankBalancesProvider(address));

          return response.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (actionsResponse) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            'Address',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SelectableText(
                            address,
                            style: TextStyle(fontSize: 16),
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
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        orElse: () => Container())
                                  ],
                                )
                              : Container()
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
                          child: TxList(actionsResponse.actions)),
                    ),
                  ]);
            },
          );
        }));
  }
}
