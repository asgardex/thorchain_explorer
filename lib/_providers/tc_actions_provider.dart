import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_services/midgard_service.dart';


class FetchActionParams {

  int offset;
  int limit;
  String txId;
  String address;

  FetchActionParams({this.offset, this.limit, String txId, String address}) {
    if (txId != null) {
      this.txId = txId;
    }
    if (address != null) {
      this.address = address;
    }
  }

}

class TcActionsProviderState {

  final List<TcAction> actions;

  TcActionsProviderState(this.actions);
}

class TcActionsProvider extends StateNotifier<TcActionsProviderState> {

  TcActionsProvider() : super(TcActionsProviderState([])) {
    // fetchActions();
  }

  Future<void> fetchActions(FetchActionParams params) async {

    final _midgardService = MidgardService();

    try {
      TcActionResponse actions = await _midgardService.fetchActions(params);
      // state.actions = actions;
      // state = TcActionsProviderState(actions);
    } catch(error) {
      print('an error occurred! $error');
    }

  }

}
