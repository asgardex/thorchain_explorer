import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExplorerSearchBar extends HookWidget {

  // final search = useTextEditingController.fromValue(TextEditingValue.empty);

  @override
  Widget build(BuildContext context) {

    final controller = useTextEditingController.fromValue(TextEditingValue.empty);
    // final searchListenable = useValueListenable(controller);

    // useEffect(() {
    //   controller.text = update;
    //   return null; // we don't need to have a special dispose logic
    // }, [search]);

    return Container(
      width: 400,
      // height: 20,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4),
              // color: Theme.of(context).backgroundColor,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).backgroundColor,
              ),
              child: TextField(
                onSubmitted: (val) {
                  navigate(context, controller.value.text);
                },
                // style: TextStyle(
                //   height: 2,
                //   backgroundColor: Theme.of(context).backgroundColor,
                // ),
                decoration: InputDecoration.collapsed(
                  hintText: "Enter Transaction ID or Address",
                  border: InputBorder.none,
                ),
                controller: controller,
              ),
            )
          ),
          SizedBox(width: 6,),
          MaterialButton(
            child: Text("Search"),
            onPressed: () {
              navigate(context, controller.value.text);
            },
          )
        ],
      ),
    );
  }

  void navigate(BuildContext context, String query) {

    final queryCaps = query.toUpperCase();

    if ( // ADDRESS QUERY
    queryCaps.contains('THOR', 0) || queryCaps.contains('TTHOR', 0)  // THORCHAIN
        || queryCaps.contains('BNB', 0) || queryCaps.contains('TBNB', 0) // BINANCE CHAIN
        || queryCaps.contains('bc1') || queryCaps.contains('TB1') // BITCOIN
    ) {
      Navigator.pushNamed(context, '/address/$query');
    } else { // TX QUERY
      Navigator.pushNamed(context, '/tx/$query');
    }
  }
}
