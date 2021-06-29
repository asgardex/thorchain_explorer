import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';

enum ActivePoolArea {
  Overview,
  Txs,
  LPs,
}

List<SubNavigationItem> buildPoolSubNavList(
    {required String asset, required ActivePoolArea activeArea}) {
  return [
    SubNavigationItem(
        path: '/pools/$asset',
        label: 'Overview',
        active: activeArea == ActivePoolArea.Overview),
    SubNavigationItem(
        path: '/pools/$asset/txs',
        label: 'Pool Txs',
        active: activeArea == ActivePoolArea.Txs),
    SubNavigationItem(
        path: '/pools/$asset/liquidity-providers',
        label: 'Pool LPs',
        active: activeArea == ActivePoolArea.LPs),
  ];
}

enum ActiveNetworkArea {
  Overview,
  Constants,
}

List<SubNavigationItem> buildNetworkSubNavList(
    {required ActiveNetworkArea activeArea}) {
  return [
    SubNavigationItem(
        path: '/network',
        label: 'Network',
        active: activeArea == ActiveNetworkArea.Overview),
    SubNavigationItem(
        path: '/network/constants',
        label: 'Constants',
        active: activeArea == ActiveNetworkArea.Constants),
  ];
}
