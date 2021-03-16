import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_widgets/navigation_item_list.dart';

class Sidebar extends HookWidget {
  final PageOptions currentArea;
  Sidebar({this.currentArea});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height,
      width: 220,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
            0.0,
            0.6,
            0.9
          ],
              colors: [
            Colors.blueGrey[900],
            Colors.grey[900],
            Colors.grey[900],
          ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        'https://raw.githubusercontent.com/Pusher-Labs/thorchain_explorer/main/assets/images/thorchain.png',
                        width: 32,
                        height: 32,
                      )),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              // Text("THORChain")
            ],
          ),
        ),
        SizedBox(
          height: 36,
        ),
        NavigationItemList(
          currentArea: currentArea,
        )
      ]),
    );
  }
}
