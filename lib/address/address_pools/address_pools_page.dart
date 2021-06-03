import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/member_details.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_utils/address_utils.dart';
import 'package:thorchain_explorer/_utils/date_utils.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/address/_widgets/address_header.dart';

class AddressPoolsPage extends HookWidget {
  final String address;
  const AddressPoolsPage({required this.address});

  @override
  Widget build(BuildContext context) {
    final subNavListItems = buildAddressSubNavList(
        address: address, activeArea: ActiveAddressArea.Pools);
    final ThemeMode mode = useProvider(userThemeProvider);

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: Column(children: [
          SubNavigationItemList(subNavListItems),
          AddressHeader(address),
          SizedBox(
            height: 16,
          ),
          HookBuilder(builder: (context) {
            final response = useProvider(memberDetailsProvider(address));
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
                data: (details) {
                  return Column(
                    children: [
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(4.0),
                        child: Container(
                          child: MemberPoolsTable(pools: details.pools),
                          decoration: containerBoxDecoration(context, mode),
                        ),
                      ),
                    ],
                  );
                });
          })
        ]));
  }
}

class MemberPoolsTable extends HookWidget {
  final List<MemberPool> pools;

  const MemberPoolsTable({required this.pools});

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );
    final cgProvider = useProvider(coinGeckoProvider);
    final df = new DateFormat('MM/dd/yy hh:mm a');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            dataRowHeight: 48,
            showCheckboxColumn: false,
            columns: [
              DataColumn(label: Text("Asset")),
              DataColumn(label: Text("Asset Address")),
              DataColumn(label: Text("RUNE Address")),
              DataColumn(label: Text("Units")),
              DataColumn(label: Text("Asset Added")),
              DataColumn(label: Text("RUNE Added")),
              DataColumn(label: Text("Asset Withdrawn")),
              DataColumn(label: Text("RUNE Withdrawn")),
              DataColumn(label: Text("Date First Added")),
              DataColumn(label: Text("Date Last Added")),
            ],
            rows: pools.map((pool) {
              final firstAdded =
                  unixDateStringToDisplay(pool.dateFirstAdded, df);
              final lastAdded = unixDateStringToDisplay(pool.dateLastAdded, df);

              return DataRow(
                  // onSelectChanged: (_) {
                  //   // Navigator.pushNamed(
                  //   //     context, '/nodes/${node.address}');
                  // },
                  cells: [
                    DataCell(AssetIcon(
                      pool.pool,
                      width: 24,
                    )),
                    DataCell(Container(
                      width: 112,
                      child: SelectableText(
                          compactAddress(pool.assetAddress ?? '')),
                    )),
                    DataCell(Container(
                        width: 112,
                        child: SelectableText(
                            compactAddress(pool.runeAddress ?? '')))),
                    DataCell(
                      Container(
                        width: 112,
                        child: SelectableText(f.format(
                            ((int.tryParse(pool.liquidityUnits) ?? 0) /
                                    pow(10, 8))
                                .ceil())),
                      ),
                    ),
                    DataCell(
                      SelectableText(f.format(
                          ((int.tryParse(pool.assetAdded) ?? 0) / pow(10, 8))
                              .ceil())),
                    ),
                    DataCell(Row(
                      children: [
                        SelectableText(f.format(
                            ((int.tryParse(pool.runeAdded) ?? 0) / pow(10, 8))
                                .ceil())),
                        SelectableText(
                          cgProvider.runePrice != null
                              ? "(\$${f.format((int.tryParse(pool.runeAdded) ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
                              : "",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )),
                    DataCell(
                      SelectableText(f.format(
                          ((int.tryParse(pool.assetWithdrawn) ?? 0) /
                                  pow(10, 8))
                              .ceil())),
                    ),
                    DataCell(Row(
                      children: [
                        SelectableText(f.format(
                            ((int.tryParse(pool.runeWithdrawn) ?? 0) /
                                    pow(10, 8))
                                .ceil())),
                        SelectableText(
                          cgProvider.runePrice != null
                              ? "(\$${f.format((int.tryParse(pool.runeWithdrawn) ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
                              : "",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )),
                    DataCell(Container(
                        width: 132, child: SelectableText(firstAdded))),
                    DataCell(Container(
                        width: 132, child: SelectableText(lastAdded))),
                  ]);
            }).toList(),
          ),
          (pools.length <= 0)
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SelectableText(
                    'No Pools found for user',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
