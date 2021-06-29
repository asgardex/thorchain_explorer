import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_utils/sub_nav_utils.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';

class NetworkConstantsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final List<SubNavigationItem> subNavListItems =
        buildNetworkSubNavList(activeArea: ActiveNetworkArea.Constants);

    return TCScaffold(
      currentArea: PageOptions.Network,
      child: Column(
        children: [
          SubNavigationItemList(subNavListItems),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Network Constants",
                    style: Theme.of(context).textTheme.headline6),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          ConstantsTable()
        ],
      ),
    );
  }
}

class ConstantItem extends StatelessWidget {
  final colWidth = 250.0;
  final String label;
  final String value;

  const ConstantItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: colWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              label,
              style:
                  TextStyle(color: Theme.of(context).hintColor, fontSize: 12),
            ),
            SelectableText(value)
          ],
        ));
  }
}

class ConstantsTable extends HookWidget {
  const ConstantsTable();

  @override
  Widget build(BuildContext context) {
    final constantsMimir = useProvider(constantsMimirProvider);
    final ThemeMode mode = useProvider(userThemeProvider);
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );

    return constantsMimir.when(
        loading: () => Container(),
        error: (err, stack) {
          return ErrorDisplay(
            header: "Sorry, we're unable to find Network Constants",
            subHeader: 'Please try again later',
            instructions: [
              SelectableText(
                  'If error persists, please file an issue at https://github.com/asgardex/thorchain_explorer/issues.')
            ],
          );
        },
        data: (data) {
          Map<String, String> keyLabel = new Map();

          data.constants.int64Values.toJson().forEach((key, _value) {
            keyLabel[key.toUpperCase()] =
                key.split(new RegExp(r"(?<=[a-z])(?=[A-Z])")).join(" ");
          });

          data.constants.boolValues.toJson().forEach((key, _value) {
            keyLabel[key.toUpperCase()] =
                key.split(new RegExp(r"(?<=[a-z])(?=[A-Z])")).join(" ");
          });

          data.constants.stringValues.toJson().forEach((key, _value) {
            keyLabel[key.toUpperCase()] =
                key.split(new RegExp(r"(?<=[a-z])(?=[A-Z])")).join(" ");
          });

          final constants = data.constants;

          return Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(4.0),
              child: Container(
                decoration: containerBoxDecoration(context, mode),
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                    children: [
                      SelectableText(
                        "Int Constants",
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(runSpacing: 16, children: [
                      ConstantItem(
                          label: "Asgard Size",
                          value: constants.int64Values.asgardSize.toString()),
                      ConstantItem(
                          label: "Bad Validator Rate",
                          value:
                              f.format(constants.int64Values.badValidatorRate)),
                      ConstantItem(
                          label: "Bad Validator Redline",
                          value: constants.int64Values.badValidatorRedline
                              .toString()),
                      ConstantItem(
                          label: "Blocks Per Year",
                          value: f.format(constants.int64Values.blocksPerYear)),
                      ConstantItem(
                          label: "Churn Interval",
                          value: f.format(constants.int64Values.churnInterval)),
                      ConstantItem(
                          label: "Desired Validator Set",
                          value: constants.int64Values.desiredValidatorSet
                              .toString()),
                      ConstantItem(
                          label: "Double Sign Max Age",
                          value:
                              f.format(constants.int64Values.doubleSignMaxAge)),
                      ConstantItem(
                          label: "Emission Curve",
                          value: f.format(constants.int64Values.emissionCurve)),
                      ConstantItem(
                          label: "Fail Keygen Slash Points",
                          value: f.format(
                              constants.int64Values.failKeygenSlashPoints)),
                      ConstantItem(
                          label: "Fail Keysign Slash Points",
                          value: f.format(
                              constants.int64Values.failKeysignSlashPoints)),
                      ConstantItem(
                          label: "Full Imp Loss Protection Blocks",
                          value: f.format(constants
                              .int64Values.fullImpLossProtectionBlocks)),
                      ConstantItem(
                          label: "Fund Migration Interval",
                          value: f.format(
                              constants.int64Values.fundMigrationInterval)),
                      ConstantItem(
                          label: "Incentive Curve",
                          value:
                              f.format(constants.int64Values.incentiveCurve)),
                      ConstantItem(
                          label: "Jail Time Keygen",
                          value:
                              f.format(constants.int64Values.jailTimeKeygen)),
                      ConstantItem(
                          label: "Jail Time Keysign",
                          value:
                              f.format(constants.int64Values.jailTimeKeysign)),
                      ConstantItem(
                          label: "Lack Of Observation Penalty",
                          value: f.format(
                              constants.int64Values.lackOfObservationPenalty)),
                      ConstantItem(
                          label: "Liquidity Lock Up Blocks",
                          value: f.format(
                              constants.int64Values.liquidityLockUpBlocks)),
                      ConstantItem(
                          label: "Max Available Pools",
                          value: f
                              .format(constants.int64Values.maxAvailablePools)),
                      ConstantItem(
                          label: "Max Swaps Per Block",
                          value:
                              f.format(constants.int64Values.maxSwapsPerBlock)),
                      ConstantItem(
                          label: "Max Synth Per Asset Depth",
                          value: f.format(
                              constants.int64Values.maxSynthPerAssetDepth)),
                      ConstantItem(
                          label: "Min Rune Pool Depth",
                          value: f.format(
                              constants.int64Values.minRunePoolDepth /
                                  pow(10, 8))),
                      ConstantItem(
                          label: "Min Slash Points For Bad Validator",
                          value: f.format(constants
                              .int64Values.minSlashPointsForBadValidator)),
                      ConstantItem(
                          label: "Min Swaps Per Block",
                          value:
                              f.format(constants.int64Values.minSwapsPerBlock)),
                      ConstantItem(
                          label: "Minimum Bond In Rune",
                          value: f.format(
                              constants.int64Values.minimumBondInRune /
                                  pow(10, 8))),
                      ConstantItem(
                          label: "Minimum Nodes For BFT",
                          value: f.format(
                              constants.int64Values.minimumNodesForBFT)),
                      ConstantItem(
                          label: "Minimum Nodes For Yggdrasil",
                          value: f.format(
                              constants.int64Values.minimumNodesForYggdrasil)),
                      ConstantItem(
                          label: "Native Transaction Fee",
                          value: f.format(
                              constants.int64Values.nativeTransactionFee /
                                  pow(10, 8))),
                      ConstantItem(
                          label: "Observation Delay Flexibility",
                          value: f.format(constants
                              .int64Values.observationDelayFlexibility)),
                      ConstantItem(
                          label: "Observe Slash Points",
                          value: f.format(
                              constants.int64Values.observeSlashPoints)),
                      ConstantItem(
                          label: "Old Validator Rate",
                          value:
                              f.format(constants.int64Values.oldValidatorRate)),
                      ConstantItem(
                          label: "Outbound Transaction Fee",
                          value: f.format(
                              constants.int64Values.outboundTransactionFee /
                                  pow(10, 8))),
                      ConstantItem(
                          label: "Pool Cycle",
                          value: f.format(constants.int64Values.poolCycle)),
                      ConstantItem(
                          label: "Signing Transaction Period",
                          value: f.format(
                              constants.int64Values.signingTransactionPeriod)),
                      ConstantItem(
                          label: "Staged Pool Cost",
                          value:
                              f.format(constants.int64Values.stagedPoolCost)),
                      ConstantItem(
                          label: "Virtual Mult Synths",
                          value: f
                              .format(constants.int64Values.virtualMultSynths)),
                      ConstantItem(
                          label: "Ygg Fund Limit",
                          value: f.format(constants.int64Values.yggFundLimit)),
                      ConstantItem(
                          label: "Ygg Fund Retry",
                          value: f.format(constants.int64Values.yggFundRetry)),
                    ]),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SelectableText(
                        "Boolean Constants",
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      ConstantItem(
                          label: "Strict Bond Liquidity Ratio",
                          value: constants.boolValues.strictBondLiquidityRatio
                              .toString()),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SelectableText(
                        "String Constants",
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      ConstantItem(
                          label: "Default Pool Status",
                          value: constants.stringValues.defaultPoolStatus),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SelectableText(
                        "MIMIR Overrides (Unformatted Values)",
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        runSpacing: 16,
                        children: data.mimir.entries
                            .map((e) => ConstantItem(
                                label: keyLabel[e.key
                                        .toString()
                                        .replaceFirst("mimir//", "")] ??
                                    e.key
                                        .toString()
                                        .replaceFirst("mimir//", ""),
                                value: e.value.toString()))
                            .toList(),
                      )),
                ]),
              ));
        });
  }
}
