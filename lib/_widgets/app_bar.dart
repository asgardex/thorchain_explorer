import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thorchain_explorer/_widgets/search_bar.dart';

class ExplorerAppBar extends PreferredSize {

  final double height;

  ExplorerAppBar({this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: Material(
        elevation: 4,
        child: LayoutBuilder(builder: (context, constraints) {
          return AnimatedContainer(
            height: preferredSize.height,
            color: Theme.of(context).primaryColor,
            duration: Duration(milliseconds: 500),
            // padding: constraints.maxWidth < 500
            //     ? EdgeInsets.zero
            //     : EdgeInsets.symmetric(horizontal: 30),
            child: Center(
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
                          // child: Image.asset(
                          //   'images/thorchain.png',
                          //   width: 32,
                          //   height: 32,
                          // ),
                          child: Image.network(
                            'https://raw.githubusercontent.com/Pusher-Labs/thorchain_explorer_build/main/assets/assets/images/thorchain.png?token=ACVKHTSMOXAG5VXHNM6RSM3ADCR3A',
                            width: 32,
                            height: 32,
                          )
                        ),
                      ),
                    ),
                    ExplorerSearchBar()
                  ],
                ),
              )
            )
          );
        }),
      )
    );
  }
}
