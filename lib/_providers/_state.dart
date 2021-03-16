import 'package:hooks_riverpod/all.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_services/thornode_service.dart';
import 'package:thorchain_explorer/main_mainnet.dart';

final providerAutodisposeFamily = FutureProvider.autoDispose.family;
final providerAutodispose = FutureProvider.autoDispose;

final actions = providerAutodisposeFamily<TcActionResponse, FetchActionParams>(
    (ref, params) async {
  final network = ref.watch(networkProvider);
  final midgardService = new MidgardService(network);
  return midgardService.fetchActions(params);
});

final nodes = providerAutodispose<List<TCNode>>((ref) async {
  final network = ref.watch(networkProvider);
  final thornodeService = new ThornodeService(network);
  return thornodeService.fetchNodes();
});

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
