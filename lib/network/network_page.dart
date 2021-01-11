import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NetworkPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Network'),
        ),
        body: Center(
          child: Text("Network Page"),
        ));
  }
}
