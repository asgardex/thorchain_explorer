import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/dashboard/dashboard_page.dart';
import 'package:thorchain_explorer/network/network_page.dart';
import 'package:thorchain_explorer/src/theme.dart';

final themeProvider = StateNotifierProvider<ThemeProvider>(
    (ref) => ThemeProvider(ThemeState(ExplorerThemeMode.DARK)));

void main() {
  runApp(ProviderScope(child: ThorchainExplorer()));
}

class ThorchainExplorer extends HookWidget {
  const ThorchainExplorer();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final theme = useProvider(themeProvider.state);

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
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            /* dark theme settings */
          ),
          themeMode: ThemeMode.system,
          onGenerateRoute: (settings) {
            // // Handle '/'
            // if (settings.name == '/') {
            //   return MaterialPageRoute(builder: (context) => DashboardPage());
            // }

            // // Handle '/details/:id'
            // var uri = Uri.parse(settings.name);
            // if (uri.pathSegments.length == 1 &&
            //     uri.pathSegments.first == 'network') {
            //   // var id = uri.pathSegments[1];
            //   return MaterialPageRoute(builder: (context) => NetworkPage());
            // }
            print('settings switch called');

            switch (settings.name) {

              case '/':
                return MaterialPageRoute(
                    builder: (context) => DashboardPage(), settings: settings);

              case '/network':
                return PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        NetworkPage(),
                    settings: settings);

              default:
                return MaterialPageRoute(
                    builder: (context) => DashboardPage(), settings: settings);
            }

            // return MaterialPageRoute(builder: (context) => DashboardPage());
          },
          // home: MyHomePage(title: "THORChain Explorer"),
        ));
  }
}
