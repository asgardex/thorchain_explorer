import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:thorchain_explorer/address/address_page.dart';
import 'package:thorchain_explorer/dashboard/dashboard_page.dart';
import 'package:thorchain_explorer/network/network_page.dart';
import 'package:thorchain_explorer/node/node_page.dart';
import 'package:thorchain_explorer/nodes_list/nodes_list_page.dart';
import 'package:thorchain_explorer/pool/pool_page.dart';
import 'package:thorchain_explorer/pools_list/pools_page.dart';
import 'package:thorchain_explorer/transaction/transaction_page.dart';
import 'package:thorchain_explorer/transactions_list/transactions_list_page.dart';

class ThorchainExplorerApp extends StatelessWidget {
  final HttpLink graphQlLink;

  ThorchainExplorerApp(this.graphQlLink);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: graphQlLink,
      ),
    );

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'THORChain Explorer',
          theme: ThemeData(
              // primarySwatch: Colors.blue,
              cardColor: Colors.white),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              cardColor: Color.fromRGBO(25, 28, 30, 1),
              dividerColor: Colors.blueGrey[900]
              /* dark theme settings */
              ),
          themeMode: ThemeMode.system,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            var uri = Uri.parse(settings.name);

            if (settings.name == '/') {
              // Home
              return PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      DashboardPage(),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (settings.name == '/network') {
              // Network Page
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      NetworkPage(),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (settings.name == '/pools') {
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      PoolsPage(),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'pools') {
              // Single Pool Page
              String id = uri.pathSegments[1];

              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      PoolPage(id),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (settings.name == '/nodes') {
              // NodeList Page
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      NodesListPage(),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'nodes') {
              // Transaction Page
              String address = uri.pathSegments[1];

              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      NodePage(address),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (settings.name == '/txs') {
              // NodeList Page
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      TransactionsListPage(),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'txs') {
              // Transaction Page
              String id = uri.pathSegments[1];

              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      TransactionPage(id),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'address') {
              // Address Page
              var id = uri.pathSegments[1];
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      AddressPage(id),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else {
              return MaterialPageRoute(
                  builder: (context) => DashboardPage(), settings: settings);
            }
          },
        ));
  }
}
