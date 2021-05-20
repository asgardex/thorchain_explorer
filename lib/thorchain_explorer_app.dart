import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/address/address_page.dart';
import 'package:thorchain_explorer/dashboard/dashboard_page.dart';
import 'package:thorchain_explorer/midgard_explorer/midgard_explorer.dart';
import 'package:thorchain_explorer/network/network_page.dart';
import 'package:thorchain_explorer/node/node_page.dart';
import 'package:thorchain_explorer/nodes_list/nodes_list_page.dart';
import 'package:thorchain_explorer/pool/pool_page.dart';
import 'package:thorchain_explorer/pools_list/pools_page.dart';
import 'package:thorchain_explorer/transaction/transaction_page.dart';
import 'package:thorchain_explorer/transactions_list/transactions_list_page.dart';

class ThorchainExplorerApp extends HookWidget {
  final HttpLink graphQlLink;

  ThorchainExplorerApp(this.graphQlLink);

  @override
  Widget build(BuildContext context) {
    final midgardEndpoints = useProvider(midgardEndpointsProvider);

    ThemeMode mode = useProvider(userThemeProvider);

    final client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: graphQlLink,
      ),
    );

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'THORChain Network Explorer',
          theme: ThemeData(
              // primarySwatch: Colors.blue,
              cardColor: Colors.white,
              textTheme: TextTheme(
                  headline1:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              cardColor: const Color.fromRGBO(25, 28, 30, 1),
              dividerColor: Colors.blueGrey[900],
              textTheme: TextTheme(
                  headline1: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          themeMode: mode,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            var uri = Uri.parse(settings.name ?? '');

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
            } else if (uri.pathSegments.first == 'midgard') {
              return _handleMidgardRouting(settings, midgardEndpoints);
            } else {
              return MaterialPageRoute(
                  builder: (context) => DashboardPage(), settings: settings);
            }
          },
        ));
  }
}

PageRouteBuilder _handleMidgardRouting(
    RouteSettings settings, List<MidgardEndpoint> endpoints) {
  for (var i = 0; i < endpoints.length; i++) {
    endpoints[i].active = false;
  }

  final MidgardEndpoint match = endpoints.firstWhere(
      (e) => matchMidgardRoute(e, settings),
      orElse: () => endpoints[0]);
  if (settings.name == '/') {
    // this should redirect to first endpoint
    return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            MidgardExplorerScaffold(
              endpoint: endpoints[0],
            ),
        transitionDuration: Duration(seconds: 0),
        settings: settings);
  } else if (match != null) {
    match.active = true;
    return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            MidgardExplorerScaffold(endpoint: match),
        transitionDuration: Duration(seconds: 0),
        settings: settings);
  } else {
    // add 404 here
    return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            MidgardExplorerScaffold(
              endpoint: endpoints[0],
            ),
        transitionDuration: Duration(seconds: 0),
        settings: settings);
  }
}

bool matchMidgardRoute(MidgardEndpoint e, RouteSettings settings) {
  final midgardPath =
      (settings.name != null) ? settings.name?.replaceAll('/midgard', '') : '';
  var settingsUri = Uri.parse(midgardPath ?? '');
  var endpointUri = Uri.parse(e.path);

  if (settingsUri.pathSegments.length != endpointUri.pathSegments.length) {
    return false;
  }

  if (e.queryParams != null) {
    for (var i = 0; i < e.queryParams.length; i++) {
      final endpointQP = e.queryParams[i];
      bool matchingUriQuery = false;

      for (var j = 0; j < settingsUri.queryParameters.length; j++) {
        if (settingsUri.queryParameters[endpointQP.key] != null) {
          e.queryParams[i].value =
              settingsUri.queryParameters[e.queryParams[i].key] ?? '';
          matchingUriQuery = true;
          break;
        }
      }

      if (!matchingUriQuery &&
          (e.queryParams[i].required == null ||
              e.queryParams[i].required == false)) {
        e.queryParams[i].value = '';
      }
    }
  }

  bool match = true;

  for (var i = 0; i < settingsUri.pathSegments.length; i++) {
    if (endpointUri.pathSegments[i].startsWith('{') &&
        endpointUri.pathSegments[i].endsWith('}')) {
      String key =
          endpointUri.pathSegments[i].replaceAll("{", "").replaceAll("}", "");

      final matchingParamInt = matchParam(key, e.pathParams);

      if (0 <= matchingParamInt) {
        if (e.pathParams[matchingParamInt].value !=
            settingsUri.pathSegments[i]) {
          e.pathParams[matchingParamInt].value = settingsUri.pathSegments[i];
        }
      }
    }

    if ((!endpointUri.pathSegments[i].startsWith('{') &&
            !endpointUri.pathSegments[i].endsWith('}')) &&
        endpointUri.pathSegments[i] != settingsUri.pathSegments[i]) {
      match = false;
      break;
    }
  }
  return match;
}
