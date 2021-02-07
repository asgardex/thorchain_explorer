import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/tc_actions_provider.dart';
import 'package:thorchain_explorer/_widgets/app_bar.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

class AddressPage extends HookWidget {

  final String address;

  AddressPage(this.address);

  @override
  Widget build(BuildContext context) {

    final params = FetchActionParams(offset: 0, limit: 10, address: address);

    return Scaffold(
          appBar: ExplorerAppBar(),
          body: HookBuilder(
            builder: (context) {
              final response = useProvider(actions(params));

              return response.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
                data: (actionsResponse) {
                  return SingleChildScrollView(
                    child: FluidContainer(
                      child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectableText(
                          'Address',
                          style: TextStyle(
                            fontSize: 24
                          ),
                        ),
                        SizedBox(height: 8,),
                        SelectableText(
                          address,
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        SizedBox(height: 32,),
                        Material(
                          elevation: 4,
                          child: Container(
                            // padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: TxList(actionsResponse.actions),
                          ),
                        )
                      ])
                  ),
                  );
                },
              );
            }
          )
    );
  }

}
