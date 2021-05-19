import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/paginator.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

class TransactionsListPage extends HookWidget {
  final int limit = 10;

  TransactionsListPage();

  @override
  Widget build(BuildContext context) {
    final offset = useState<int>(0);

    final params = FetchActionParams(offset: offset.value, limit: limit);
    final ThemeMode mode = useProvider(userThemeProvider);

    return TCScaffold(
        currentArea: PageOptions.Transactions,
        child: HookBuilder(builder: (context) {
          final response = useProvider(actions(params));

          return response.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (actionsResponse) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SelectableText("Transactions",
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(4.0),
                        child: Container(
                          child: TxList(actionsResponse.actions),
                          decoration: containerBoxDecoration(context, mode),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Paginator(
                          offset: offset.value,
                          limit: limit,
                          totalCount: (int.parse(actionsResponse.count)),
                          updateOffset: (i) => offset.value = i)
                    ]);
              });
        }));
  }
}
