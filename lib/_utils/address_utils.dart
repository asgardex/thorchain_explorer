import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';

enum ActiveAddressArea { Txs, Pools }

String compactAddress(String address) {
  return address.length >= 8
      ? '${address.substring(0, 8)}...${address.substring((address.length) - 4)}'
      : '';
}

List<SubNavigationItem> buildAddressSubNavList(
    {required String address, required ActiveAddressArea activeArea}) {
  return [
    SubNavigationItem(
        path: '/address/$address/txs',
        label: 'Txs',
        active: activeArea == ActiveAddressArea.Txs),
    SubNavigationItem(
        path: '/address/$address/pools',
        label: 'Pools',
        active: activeArea == ActiveAddressArea.Pools),
  ];
}
