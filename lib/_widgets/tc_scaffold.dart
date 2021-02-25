import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/app_bar.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';
import 'package:thorchain_explorer/_widgets/search_bar.dart';
import 'package:thorchain_explorer/_widgets/sidebar.dart';

class TCScaffold extends HookWidget {
  final Widget child;
  final PageOptions currentArea;

  TCScaffold({this.child, this.currentArea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.0,
                  0.1,
                  0.9
                ],
                    colors: [
                  Colors.blueGrey[900],
                  Colors.blueGrey[900],
                  Colors.grey[900],
                ])),
            child: (constraints.maxWidth > 900)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Sidebar(
                        currentArea: currentArea,
                      ),
                      Expanded(
                        // flex: 5,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExplorerSearchBar(),
                                FluidContainer(
                                  child: child,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ExplorerAppBar(),
                        ExplorerSearchBar(),
                        FluidContainer(
                          child: child,
                        )
                      ],
                    ),
                  ));
      }),
    );
  }
}
