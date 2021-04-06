import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';
import 'package:thorchain_explorer/_enums/networks.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:thorchain_explorer/_widgets/sidebar_box_decoration.dart';

class MidgardExplorerSidebar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    List<MidgardEndpoint> midgardEndpoints =
        useProvider(midgardEndpointsProvider);

    return Container(
        height: MediaQuery.of(context).size.height,
        width: 320,
        decoration: sidebarBoxDecoration(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        children: [
                          Icon(Icons.explore, color: Colors.white),
                          SizedBox(
                            width: 8,
                          ),
                          SelectableText(
                            "Midgard Explorer",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 2,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ...midgardEndpoints
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                          onTap: () {
                                            String basePath =
                                                createNavigatorPath(e);
                                            String withQueryParams =
                                                appendQueryParams(basePath, e);

                                            Navigator.pushNamed(context,
                                                "/midgard$withQueryParams");
                                            return;
                                          },
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Text(
                                              e.name,
                                              style: TextStyle(
                                                color: e.active
                                                    ? Colors.white
                                                    : Colors.grey,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: GestureDetector(
                        onTap: () => html.window.open(
                            (selectNetwork(net) == Networks.Testnet)
                                ? 'https://testnet.midgard.thorchain.info/v2/graphql'
                                : 'https://midgard.thorchain.info/v2/graphql',
                            'Midgard GraphQL'),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Row(
                            children: [
                              Text("GraphQL",
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.open_in_new,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Divider(
                      height: 2,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, "/"),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Network Explorer",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ));
  }
}
