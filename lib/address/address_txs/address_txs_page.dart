import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';
import 'package:thorchain_explorer/_utils/address_utils.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/paginator.dart';
import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

import 'package:thorchain_explorer/address/_widgets/address_header.dart';

class AddressTxsPage extends HookWidget {
  final String address;
  final int limit = 10;

  AddressTxsPage(this.address);

  @override
  Widget build(BuildContext context) {
    final offset = useState<int>(0);
    final params =
        FetchActionParams(offset: offset.value, limit: 10, address: address);
    final ThemeMode mode = useProvider(userThemeProvider);
    final List<SubNavigationItem> subNavListItems = buildAddressSubNavList(
        address: address, activeArea: ActiveAddressArea.Txs);

    return TCScaffold(
        currentArea: PageOptions.Transactions,
        child: HookBuilder(builder: (context) {
          final response = useProvider(actions(params));

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SubNavigationItemList(subNavListItems),
                AddressHeader(address),
                SizedBox(
                  height: 16,
                ),
                response.when(
                  loading: () => Container(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: CircularProgressIndicator())),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (actionsResponse) => Column(
                    children: [
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(4.0),
                        child: Container(
                          decoration: containerBoxDecoration(context, mode),
                          child: TxList(actionsResponse.actions),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Paginator(
                          offset: offset.value,
                          limit: limit,
                          totalCount: (int.parse(actionsResponse.count)),
                          updateOffset: (i) => offset.value = i)
                    ],
                  ),
                )
              ]);
        }));
  }
}
