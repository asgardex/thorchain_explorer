import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';

class ExplorerSearchBar extends HookWidget {
  // final search = useTextEditingController.fromValue(TextEditingValue.empty);

  @override
  Widget build(BuildContext context) {
    final controller =
        useTextEditingController.fromValue(TextEditingValue.empty);
    // final searchListenable = useValueListenable(controller);

    // useEffect(() {
    //   controller.text = update;
    //   return null; // we don't need to have a special dispose logic
    // }, [search]);

    return FluidContainer(
      child: Container(
        padding: MediaQuery.of(context).size.width < 900
            ? EdgeInsets.fromLTRB(16, 16, 16, 48)
            : EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
                child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 48,
                child: TextField(
                  onSubmitted: (val) {
                    navigate(context, controller.value.text);
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: "Enter Transaction ID or Address",
                    border: InputBorder.none,
                  ),
                  controller: controller,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context, String query) {
    final queryCaps = query.toUpperCase();

    if ( // ADDRESS QUERY
        queryCaps.contains('THOR', 0) ||
            queryCaps.contains('TTHOR', 0) // THORCHAIN
            ||
            queryCaps.contains('BNB', 0) ||
            queryCaps.contains('TBNB', 0) // BINANCE CHAIN
            ||
            queryCaps.contains('BC1', 0) ||
            queryCaps.contains('TB1', 0) // BITCOIN
            ||
            queryCaps.contains('LTC', 0) ||
            queryCaps.contains('TLTC', 0) // LITECOIN
        ) {
      Navigator.pushNamed(context, '/address/$query');
    } else {
      // TX QUERY
      Navigator.pushNamed(context, '/txs/$query');
    }
  }
}
