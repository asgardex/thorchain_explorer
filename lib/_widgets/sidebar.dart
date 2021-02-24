import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thorchain_explorer/_providers/_state.dart';

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
          // padding: EdgeInsets.all(16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        'https://raw.githubusercontent.com/Pusher-Labs/thorchain_explorer_build/main/assets/assets/images/thorchain.png?token=ACVKHTSMOXAG5VXHNM6RSM3ADCR3A',
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
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    color: currentArea == PageOptions.Dashboard
                        ? Colors.white
                        : Colors.grey,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Overview",
                    style: TextStyle(
                        color: currentArea == PageOptions.Dashboard
                            ? Colors.white
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/nodes'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Icon(Icons.my_location,
                      color: currentArea == PageOptions.Nodes
                          ? Colors.white
                          : Colors.grey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Nodes",
                    style: TextStyle(
                        color: currentArea == PageOptions.Nodes
                            ? Colors.white
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/network'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Icon(Icons.connect_without_contact,
                      color: currentArea == PageOptions.Network
                          ? Colors.white
                          : Colors.grey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Network",
                    style: TextStyle(
                        color: currentArea == PageOptions.Network
                            ? Colors.white
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/txs'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Icon(Icons.transform_sharp,
                      color: currentArea == PageOptions.Transactions
                          ? Colors.white
                          : Colors.grey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Transactions",
                    style: TextStyle(
                        color: currentArea == PageOptions.Transactions
                            ? Colors.white
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/pools'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Icon(Icons.pool,
                      color: currentArea == PageOptions.Pools
                          ? Colors.white
                          : Colors.grey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Pools",
                    style: TextStyle(
                        color: currentArea == PageOptions.Pools
                            ? Colors.white
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
