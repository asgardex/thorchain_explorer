import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExplorerAppBar extends PreferredSize {
  // final double height;

  ExplorerAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: LayoutBuilder(builder: (context, constraints) {
        return AnimatedContainer(
            color: Colors.black.withOpacity(0.3),
            height: preferredSize.height,
            duration: Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                    child: Container(
                  height: preferredSize.height,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  constraints: BoxConstraints(
                    maxWidth: 1024,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text("Home"),

                            FlatButton(
                              child: Text(
                                'Home',
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/'),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            FlatButton(
                              child: Text(
                                'Network',
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/network'),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            FlatButton(
                              child: Text(
                                'Nodes',
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/nodes'),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            FlatButton(
                              child: Text(
                                'TXs',
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/txs'),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            FlatButton(
                              child: Text('Pools'),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/pools'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ));
      }),
    );
  }
}
