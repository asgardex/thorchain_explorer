import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/thorchain_explorer_app.dart';

void main() {
  runApp(ProviderScope(child: ThorchainExplorer()));
}

class ThorchainExplorer extends HookWidget {
  ThorchainExplorer();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://midgard.thorchain.info/v2',
    );
    return ThorchainExplorerApp(httpLink);
  }
}
