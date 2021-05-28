import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/paginator.dart';
import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

class PoolTxsPage extends HookWidget {
  final int limit = 10;
  final String asset;
  PoolTxsPage({required this.asset});

  @override
  Widget build(BuildContext context) {
    final offset = useState<int>(0);
    final List<SubNavigationItem> subNavListItems = [
      SubNavigationItem(path: '/pools/$asset', label: 'Overview'),
      SubNavigationItem(
          path: '/pools/$asset/txs', label: 'Pool Txs', active: true),
    ];

    final params =
        FetchActionParams(offset: offset.value, limit: limit, asset: asset);
    final ThemeMode mode = useProvider(userThemeProvider);

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: Column(
          children: [
            SubNavigationItemList(subNavListItems),
            Row(
              children: [
                AssetIcon(
                  asset,
                  width: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("$asset Txs",
                    style: Theme.of(context).textTheme.headline1),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            HookBuilder(builder: (context) {
              final response = useProvider(actions(params));

              return response.when(
                  loading: () => Padding(
                        padding: const EdgeInsets.all(48),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  error: (err, stack) {
                    print(err);
                    print(stack.toString());
                    return Center(
                        child: ErrorDisplay(
                      subHeader: err.toString(),
                      instructions: [
                        '1) Please try again later.',
                        '2) If error persists, please file an issue at https://github.com/asgardex/thorchain_explorer/issues.'
                      ],
                    ));
                  },
                  data: (actionsResponse) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(4.0),
                            child: Container(
                              child: TxList(actionsResponse.actions),
                              decoration: containerBoxDecoration(context, mode),
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
                        ]);
                  });
            }),
          ],
        ));
  }
}
