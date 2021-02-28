import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/tc_actions_provider.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

class TransactionsListPage extends HookWidget {
  final int limit = 10;

  TransactionsListPage();

  @override
  Widget build(BuildContext context) {
    final offset = useState<int>(0);

    final params = FetchActionParams(offset: offset.value, limit: limit);

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
                          decoration: containerBoxDecoration(context),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (offset.value != 0)
                                  ? () {
                                      offset.value = 0;
                                    }
                                  : null,
                              child: Icon(Icons.first_page),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: (offset.value - limit >= 0)
                                    ? () {
                                        offset.value = offset.value - limit;
                                      }
                                    : null,
                                child: Icon(Icons.navigate_before)),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                              "Page ${(offset.value / limit) + 1} of ${(int.parse(actionsResponse.count) / limit).ceil()}"),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: (offset.value + limit <=
                                        (int.parse(actionsResponse.count))
                                            .ceil())
                                    ? () {
                                        offset.value = offset.value + limit;
                                      }
                                    : null,
                                child: Icon(Icons.navigate_next)),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (offset.value !=
                                      limit *
                                          ((int.parse(actionsResponse.count) /
                                                      limit)
                                                  .ceil() -
                                              1))
                                  ? () {
                                      offset.value = limit *
                                          ((int.parse(actionsResponse.count) /
                                                      limit)
                                                  .ceil() -
                                              1);
                                    }
                                  : null,
                              child: Icon(Icons.last_page),
                            ),
                          ),
                        ],
                      )
                    ]);
              });
        }));
  }
}
