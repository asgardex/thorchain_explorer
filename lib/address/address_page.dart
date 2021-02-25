import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/tc_actions_provider.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

class AddressPage extends HookWidget {
  final String address;

  AddressPage(this.address);

  @override
  Widget build(BuildContext context) {
    final params = FetchActionParams(offset: 0, limit: 10, address: address);

    return TCScaffold(
        currentArea: PageOptions.Transactions,
        child: HookBuilder(builder: (context) {
          final response = useProvider(actions(params));

          return response.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (actionsResponse) {
              return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    SizedBox(
                      height: 32,
                    ),
                    Material(
                      elevation: 1,
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(4.0),
                      child: TxList(actionsResponse.actions),
                    ),
                  ]);
            },
          );
        }));
  }
}
