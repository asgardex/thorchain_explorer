import 'package:flutter/material.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_widgets/navigation_item.dart';

class NavigationItemList extends StatelessWidget {
  final PageOptions currentArea;

  NavigationItemList({this.currentArea});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationItem(
          title: "Overview",
          isActive: currentArea == PageOptions.Dashboard,
          navigationRoute: '/',
          iconData: Icons.dashboard,
        ),
        SizedBox(
          height: 16,
        ),
        NavigationItem(
          title: "Nodes",
          isActive: currentArea == PageOptions.Nodes,
          navigationRoute: '/nodes',
          iconData: Icons.my_location,
        ),
        SizedBox(
          height: 16,
        ),
        NavigationItem(
          title: "Network",
          isActive: currentArea == PageOptions.Network,
          navigationRoute: '/network',
          iconData: Icons.connect_without_contact,
        ),
        SizedBox(
          height: 16,
        ),
        NavigationItem(
          title: "Transactions",
          isActive: currentArea == PageOptions.Transactions,
          navigationRoute: '/txs',
          iconData: Icons.transform_sharp,
        ),
        SizedBox(
          height: 16,
        ),
        NavigationItem(
          title: "Pools",
          isActive: currentArea == PageOptions.Pools,
          navigationRoute: '/pools',
          iconData: Icons.pool,
        ),
        SizedBox(
          height: 16,
        ),
        NavigationItem(
          title: "Midgard Explorer",
          isActive: currentArea == PageOptions.MidgardExplorer,
          navigationRoute: '/midgard/health',
          iconData: Icons.explore,
        ),
      ],
    );
  }
}
