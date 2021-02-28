import 'package:flutter/material.dart';

class FluidContainer extends StatelessWidget {
  final Widget child;

  FluidContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: MediaQuery.of(context).size.width < 900
          ? EdgeInsets.zero
          : EdgeInsets.all(30.0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 1440,
        ),
        child: child,
      ),
    );
  }
}
