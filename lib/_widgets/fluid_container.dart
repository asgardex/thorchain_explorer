import 'package:flutter/material.dart';

class FluidContainer extends StatelessWidget {

  final Widget child;

  FluidContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: constraints.maxWidth < 500
            ? EdgeInsets.zero
            : EdgeInsets.all(30.0),
        child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: BoxConstraints(
                maxWidth: 1024,
              ),
              child: child,
            )
        ),
      );
    });
  }
}
