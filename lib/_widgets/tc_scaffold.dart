import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/external_sidebar_links.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';
import 'package:thorchain_explorer/_widgets/navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/search_bar.dart';
import 'package:thorchain_explorer/_widgets/sidebar.dart';
import 'package:thorchain_explorer/_widgets/sidebar_box_decoration.dart';

class TCScaffold extends HookWidget {
  final Widget child;
  final PageOptions currentArea;

  TCScaffold({this.child, this.currentArea});

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = useProvider(userThemeProvider.state);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          endDrawer: (constraints.maxWidth > 900)
              ? null
              : Drawer(
                  child: Container(
                    decoration: sidebarBoxDecoration(context),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavigationItemList(
                          currentArea: currentArea,
                        ),
                        ExternalSidebarLinks()
                      ],
                    ),
                  ),
                ),
          appBar: (constraints.maxWidth > 900)
              ? null
              : AppBar(
                  iconTheme: mode == ThemeMode.dark
                      ? IconThemeData(color: Colors.white)
                      : IconThemeData(color: Colors.grey[900]),
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
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
                  ),
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
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ExplorerSearchBar(),
                                FluidContainer(
                                  child: child,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )));
    });
  }
}
