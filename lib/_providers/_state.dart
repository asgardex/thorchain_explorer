import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_classes/constants.dart';
import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';
import 'package:thorchain_explorer/_classes/tc_bank_balances.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_classes/tc_node_version.dart';
import 'package:thorchain_explorer/_classes/pool_stats.dart';
import 'package:thorchain_explorer/_classes/stats.dart';
import 'package:thorchain_explorer/_classes/member_details.dart';
import 'package:thorchain_explorer/_classes/pool_liquidity_provider.dart';
import 'package:thorchain_explorer/_const/midgard_endpoints.dart';
import 'package:thorchain_explorer/_enums/networks.dart';
import 'package:thorchain_explorer/_providers/coingecko_provider.dart';
import 'package:thorchain_explorer/_providers/node_locations_provider.dart';
import 'package:thorchain_explorer/_providers/user_theme_notifier.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_services/thornode_service.dart';

const String net = String.fromEnvironment("NETWORK");

final providerAutodisposeFamily = FutureProvider.autoDispose.family;
final providerAutodispose = FutureProvider.autoDispose;

final netEnvProvider = Provider((ref) => net);

final actions = providerAutodisposeFamily<TcActionResponse, FetchActionParams>(
    (ref, params) async {
  final netEnv = ref.watch(netEnvProvider);

  final midgardService = new MidgardService(selectNetwork(netEnv));
  return midgardService.fetchActions(params);
});

final nodes = providerAutodispose<List<TCNode>>((ref) async {
  final netEnv = ref.watch(netEnvProvider);
  final midgardService = new MidgardService(selectNetwork(netEnv));
  return midgardService.fetchNodes();
});

final coinGeckoProvider =
    StateNotifierProvider<CoinGeckoProvider, CoinGeckoProviderState>(
        (ref) => CoinGeckoProvider());

final midgardEndpointsProvider =
    Provider.autoDispose<List<MidgardEndpoint>>((ref) {
  final netEnv = ref.watch(netEnvProvider);
  return (selectNetwork(netEnv) == Networks.Testnet)
      ? testnetMidgardEndpoints
      : mainnetMidgardEndpoints;
});

final bankBalancesProvider =
    providerAutodisposeFamily<BankBalances?, String>((ref, address) async {
  if (!address.toUpperCase().contains('TTHOR', 0) &&
      !address.toUpperCase().contains('THOR', 0)) {
    return null;
  }

  final netEnv = ref.watch(netEnvProvider);
  final thornodeService = new ThornodeService(selectNetwork(netEnv));
  return thornodeService.fetchBalances(address);
});

final nodeVersionProvider = providerAutodispose<TCNodeVersion>((ref) {
  final netEnv = ref.watch(netEnvProvider);
  final thornodeService = new ThornodeService(selectNetwork(netEnv));
  return thornodeService.fetchNodeVersion();
});

final userThemeProvider = StateNotifierProvider<UserThemeNotifier, ThemeMode>(
    (ref) => UserThemeNotifier());

final nodeLocationsProvider =
    StateNotifierProvider<NodeLocationsProvider, NodeLocationsProviderState>(
        (ref) {
  final netEnv = ref.watch(netEnvProvider);
  return NodeLocationsProvider(selectNetwork(netEnv));
});

Networks selectNetwork(String net) {
  switch (net) {
    case "TESTNET":
    case "Testnet":
    case "testnet":
      return Networks.Testnet;

    default:
      return Networks.Mainnet;
  }
}

final poolStatsProvider =
    providerAutodisposeFamily<PoolStats, String>((ref, asset) async {
  final netEnv = ref.watch(netEnvProvider);
  final midgardService = new MidgardService(selectNetwork(netEnv));
  return midgardService.fetchPoolStats(asset);
});

final memberDetailsProvider =
    providerAutodisposeFamily<MemberDetails, String>((ref, address) async {
  final netEnv = ref.watch(netEnvProvider);
  final midgardService = new MidgardService(selectNetwork(netEnv));
  return midgardService.fetchMemberDetails(address);
});

final poolLpsProvider =
    providerAutodisposeFamily<List<PoolLiquidityProvider>, String>(
        (ref, pool) async {
  final netEnv = ref.watch(netEnvProvider);
  final thornodeService = new ThornodeService(selectNetwork(netEnv));
  return thornodeService.fetchPoolLps(pool);
});

final statsProvider = providerAutodispose<Stats>((ref) {
  final netEnv = ref.watch(netEnvProvider);
  final midgardService = new MidgardService(selectNetwork(netEnv));
  return midgardService.fetchStats();
});

final constantsProvider = providerAutodispose<Constants>((ref) {
  final netEnv = ref.watch(netEnvProvider);
  final midgardService = new MidgardService(selectNetwork(netEnv));
  return midgardService.fetchConstants();
});

final mimirProvider = providerAutodispose<Map>((ref) {
  final netEnv = ref.watch(netEnvProvider);
  final midgardService = new ThornodeService(selectNetwork(netEnv));
  return midgardService.fetchMimir();
});

class ConstantsMimir {
  Constants constants;
  Map mimir;

  ConstantsMimir({required this.constants, required this.mimir});
}

final constantsMimirProvider = providerAutodispose<ConstantsMimir>((ref) async {
  final constants = await ref.watch(constantsProvider.future);
  final mimir = await ref.watch(mimirProvider.future);

  return ConstantsMimir(
    constants: constants,
    mimir: mimir,
  );
});
