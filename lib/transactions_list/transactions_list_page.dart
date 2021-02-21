import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/tc_actions_provider.dart';
import 'package:thorchain_explorer/_widgets/app_bar.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';
import 'package:thorchain_explorer/_widgets/tx_list.dart';

class TransactionsListPage extends HookWidget {

  final int limit = 10;

  TransactionsListPage();

  @override
  Widget build(BuildContext context) {

    final offset = useState<int>(0);

    final params = FetchActionParams(offset: offset.value, limit: limit);

    return Scaffold(
        appBar: ExplorerAppBar(),
        body: HookBuilder(
          builder: (context) {

            final response = useProvider(actions(params));

            return response.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
                data: (actionsResponse) {
                  return SingleChildScrollView(
                    child: FluidContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SelectableText(
                              "Transactions",
                              style: Theme.of(context).textTheme.headline6
                          ),
                          SizedBox(height: 16,),
                          Material(
                            elevation: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TxList(actionsResponse.actions),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: (offset.value != 0) ? () {
                                      offset.value = 0;
                                    } : null,
                                    child: Icon(Icons.first_page),
                                ),
                              ),
                              SizedBox(width: 4,),
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: (offset.value - limit >= 0) ? () {
                                    offset.value = offset.value - limit;
                                  } : null,
                                  child: Icon(Icons.navigate_before)
                                ),
                              ),
                              SizedBox(width: 4,),
                              Text("Page ${(offset.value / limit) + 1} of ${ (int.parse(actionsResponse.count) / limit).ceil() }"),
                              SizedBox(width: 4,),
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: (offset.value + limit <= (int.parse(actionsResponse.count)).ceil()) ? () {
                                    offset.value = offset.value + limit;
                                  } : null,
                                  child: Icon(Icons.navigate_next)
                                ),
                              ),
                              SizedBox(width: 4,),
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: (offset.value != limit * ((int.parse(actionsResponse.count) / limit).ceil() - 1)) ? () {
                                    offset.value = limit * ((int.parse(actionsResponse.count) / limit).ceil() - 1);
                                  } : null,
                                  child: Icon(Icons.last_page),
                                ),
                              ),
                            ],
                          )
                        ]
                      )
                    )
                  );
                }
            );
          })
    );


  }

}
