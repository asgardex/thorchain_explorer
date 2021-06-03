import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool_liquidity_provider.dart';
import 'dart:math';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_utils/address_utils.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';

class LiquidityProvidersTable extends HookWidget {
  final List<PoolLiquidityProvider> liquidityProviders;
  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  LiquidityProvidersTable({required this.liquidityProviders});

  @override
  Widget build(BuildContext context) {
    final cgProvider = useProvider(coinGeckoProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowHeight: 48,
        showCheckboxColumn: false,
        columns: [
          DataColumn(label: Text("Asset")),
          DataColumn(label: Text("Asset Address")),
          DataColumn(label: Text("RUNE Address")),
          DataColumn(label: Text("Units")),
          DataColumn(label: Text("Asset Deposit Value")),
          DataColumn(label: Text("RUNE Deposit Value")),
          DataColumn(label: Text("Last Add Height")),
          DataColumn(label: Text("Last Withdraw Height")),
          DataColumn(label: Text("Pending RUNE")),
          DataColumn(label: Text("Pending Asset")),
        ],
        rows: liquidityProviders.map((node) {
          return DataRow(
              // onSelectChanged: (_) {
              //   // Navigator.pushNamed(
              //   //     context, '/nodes/${node.address}');
              // },
              cells: [
                DataCell(AssetIcon(
                  node.asset,
                  width: 24,
                )),
                DataCell(
                    SelectableText(compactAddress(node.assetAddress ?? ''))),
                DataCell(
                    SelectableText(compactAddress(node.runeAddress ?? ''))),
                DataCell(
                  SelectableText(f.format(
                      ((int.tryParse(node.units) ?? 0) / pow(10, 8)).ceil())),
                ),
                DataCell(
                  SelectableText(f.format(
                      ((int.tryParse(node.assetDepositValue) ?? 0) / pow(10, 8))
                          .ceil())),
                ),
                DataCell(Row(
                  children: [
                    SelectableText(f.format(
                        ((int.tryParse(node.runeDepositValue) ?? 0) /
                                pow(10, 8))
                            .ceil())),
                    SelectableText(
                      cgProvider.runePrice != null
                          ? "(\$${f.format((int.tryParse(node.runeDepositValue) ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
                          : "",
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )),
                DataCell(SelectableText("${node.lastAddHeight}")),
                DataCell(SelectableText("${node.lastWithdrawHeight ?? '-'}")),
                DataCell(
                  SelectableText(f.format(
                      ((int.tryParse(node.pendingRune) ?? 0) / pow(10, 8))
                          .ceil())),
                ),
                DataCell(
                  SelectableText(f.format(
                      ((int.tryParse(node.pendingAsset) ?? 0) / pow(10, 8))
                          .ceil())),
                ),
              ]);
        }).toList(),
      ),
    );
  }
}
