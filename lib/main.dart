import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/address/address_page.dart';
import 'package:thorchain_explorer/dashboard/dashboard_page.dart';
import 'package:thorchain_explorer/network/network_page.dart';
import 'package:thorchain_explorer/nodes_list/nodes_list_page.dart';
import 'package:thorchain_explorer/pools/pools_page.dart';
import 'package:thorchain_explorer/transaction/transaction_page.dart';

// final themeProvider = StateNotifierProvider<ThemeProvider>(
//     (ref) => ThemeProvider(ThemeState(ExplorerThemeMode.DARK)));

// final navigationHistoryProvider = StateNotifierProvider<NavigationHistoryHandler>(
//     (ref) => NavigationHistoryHandler([])
// );

void main() {
  runApp(ProviderScope(child: ThorchainExplorer()));
}

class ThorchainExplorer extends HookWidget {
  const ThorchainExplorer();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://testnet.midgard.thorchain.info/v2',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'THORChain Explorer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            /* dark theme settings */
          ),
          themeMode: ThemeMode.system,
          initialRoute: '/',
          // routes: {
          //   '/': (context) => DashboardPage(),
          //   '/network': (context) => NetworkPage()
          // },
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
            } else if (settings.name == '/nodes') {
              // NodeList Page
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      NodesListPage(),
                  transitionDuration: Duration(seconds: 0),
                  settings: settings);
            } else if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'tx') {
              // Transaction Page
              var id = uri.pathSegments[1];

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
