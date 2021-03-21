import 'package:flutter/rendering.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class _ExternalSidebarLink {
  String url;
  String name;

  _ExternalSidebarLink({this.url, this.name});
}

class ExternalSidebarLinks extends StatelessWidget {
  final List<_ExternalSidebarLink> links = [
    _ExternalSidebarLink(
        url: 'https://twitter.com/thorchain_org', name: 'Twitter'),
    _ExternalSidebarLink(url: 'https://t.me/thorchain_org', name: 'Telegram'),
    _ExternalSidebarLink(url: 'https://medium.com/thorchain', name: 'Medium'),
    _ExternalSidebarLink(url: 'https://gitlab.com/thorchain', name: 'Gitlab'),
    _ExternalSidebarLink(
        url: 'https://singlechain.thorchain.net', name: 'Singlechain Explorer'),
    (net == "TESTNET")
        ? _ExternalSidebarLink(
            url: 'https://thorchain.net', name: 'Mainnet Explorer')
        : _ExternalSidebarLink(
            url: 'https://testnet.thorchain.net', name: 'Testnet Explorer')
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: links
                .map(
                  (e) => Column(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () => _launchURL(e.url),
                            child: Text(
                              e.name,
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            )),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )
                .toList()),
      ],
    );
  }
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
