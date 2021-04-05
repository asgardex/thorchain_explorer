import 'package:hooks_riverpod/all.dart';
import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_const/midgard_endpoints.dart';
import 'package:thorchain_explorer/_enums/networks.dart';
import 'package:thorchain_explorer/_providers/coingecko_provider.dart';
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
  final thornodeService = new ThornodeService(selectNetwork(netEnv));
  return thornodeService.fetchNodes();
});

final coinGeckoProvider =
    StateNotifierProvider<CoinGeckoProvider>((ref) => CoinGeckoProvider());

final midgardEndpointsProvider =
    Provider.autoDispose<List<MidgardEndpoint>>((ref) {
  final netEnv = ref.watch(netEnvProvider);
  return (selectNetwork(netEnv) == Networks.Testnet)
      ? testnetMidgardEndpoints
      : mainnetMidgardEndpoints;
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

// final actions = FutureProvider.autoDispose
//     .family<TcActionResponse, FetchActionParams>((ref, params) async {
//     final midgardService = new MidgardService();
//     return midgardService.fetchActions(params);
// });

// final paginatedQuestionsProvider = FutureProvider.autoDispose
//     .family<List<TcAction>, FetchActionParams>((ref, pageIndex) async {
//
//       final fetchedPages = ref.read(_fetchedPages).state;
//       fetchedPages.add(pageIndex);
//       ref.onDispose(() => fetchedPages.remove(pageIndex));
//
//       final cancelToken = CancelToken();
//       ref.onDispose(cancelToken.cancel);
//
//       final uri = Uri(
//         scheme: 'https',
//         host: 'api.stackexchange.com',
//         path: '/2.2/questions',
//         queryParameters: <String, Object>{
//           'order': 'desc',
//           'sort': 'creation',
//           'site': 'stackoverflow',
//           'filter': '!17vW1m9jnXcpKOO(p4a5Jj.QeqRQmvxcbquXIXJ1fJcKq4',
//           'tagged': 'flutter',
//           'pagesize': '50',
//           'page': '${pageIndex + 1}',
//         },
//       );
//
//       final response = await ref
//           .watch(client)
//           .getUri<Map<String, Object>>(uri, cancelToken: cancelToken);
//
//       final parsed = QuestionsResponse.fromJson(response.data);
//       final page = parsed.copyWith(
//         items: parsed.items.map((e) {
//           final document = parse(e.body);
//           return e.copyWith(body: document.body.text.replaceAll('\n', ' '));
//         }).toList(),
//       );
//
//       ref.maintainState = true;
//
//       return page;
//
// });
