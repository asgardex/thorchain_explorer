import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/sidebar_box_decoration.dart';
import 'package:thorchain_explorer/midgard_explorer/endpoint_details.dart';
import 'package:thorchain_explorer/midgard_explorer/midgard_explorer_sidebar.dart';

class MidgardExplorerScaffold extends HookWidget {
  final MidgardEndpoint endpoint;
  MidgardExplorerScaffold({this.endpoint});

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = useProvider(userThemeProvider);

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        endDrawer: (constraints.maxWidth > 900)
            ? null
            : Drawer(
                child: Container(
                  decoration: sidebarBoxDecoration(context),
                  child: MidgardExplorerSidebar(),
                ),
              ),
        appBar: (constraints.maxWidth > 900)
            ? null
            : AppBar(
                title: Container(
                  child: Row(
                    children: [
                      Icon(Icons.explore),
                      SizedBox(
                        width: 8,
                      ),
                      SelectableText(
                        "Midgard Explorer",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                iconTheme: mode == ThemeMode.dark
                    ? IconThemeData(color: Colors.white)
                    : IconThemeData(color: Colors.grey[900]),
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).cardColor,
              ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.1, 0.9],
                    colors: mode == ThemeMode.dark
                        ? [
                            Colors.blueGrey[900],
                            Colors.blueGrey[900],
                            Colors.grey[900],
                          ]
                        : [
                            Colors.blueGrey[200],
                            Colors.blueGrey[200],
                            Colors.white,
                          ])),
            child: (constraints.maxWidth > 900)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MidgardExplorerSidebar(),
                      Expanded(
                          child: EndpointDetails(
                        endpoint: endpoint,
                      ))
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: EndpointDetails(
                          endpoint: endpoint,
                        ),
                      ))
                    ],
                  )),
      ),
    );
  }
}
