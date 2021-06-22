import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_const/pool_sub_nav_items.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_widgets/liquidity_providers_table.dart';
import 'package:thorchain_explorer/_widgets/paginator.dart';
import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';

class PoolLiqudityProviders extends HookWidget {
  final String asset;
  final int limit = 20;
  const PoolLiqudityProviders({required this.asset});

  @override
  Widget build(BuildContext context) {
    final subNavListItems =
        buildPoolSubNavList(asset: asset, activeArea: ActivePoolArea.LPs);
    final ThemeMode mode = useProvider(userThemeProvider);
    final offset = useState<int>(0);

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: Column(children: [
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
              Text("$asset LPs", style: Theme.of(context).textTheme.headline1),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          HookBuilder(builder: (context) {
            final response = useProvider(poolLpsProvider(asset));
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
                      SelectableText('1) Please try again later.'),
                      SelectableText(
                          '2) If error persists, please file an issue at https://github.com/asgardex/thorchain_explorer/issues.')
                    ],
                  ));
                },
                data: (lps) {
                  return Column(
                    children: [
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(4.0),
                        child: Container(
                          child: LiquidityProvidersTable(
                              liquidityProviders: lps.sublist(
                                  offset.value,
                                  (offset.value + limit) < lps.length
                                      ? (offset.value + limit)
                                      : lps.length)),
                          decoration: containerBoxDecoration(context, mode),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Paginator(
                          totalCount: lps.length,
                          limit: limit,
                          offset: offset.value,
                          updateOffset: (updatedOffset) {
                            offset.value = updatedOffset;
                          })
                    ],
                  );
                });
          })
        ]));
  }
}
