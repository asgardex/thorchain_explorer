import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_utils/asset_utils.dart';
import 'dart:html' as html;

enum ExplorerLinkType { Tx, Address }

class ExternalExplorerLink extends StatelessWidget {
  final ExplorerLinkType type;
  final String hash;
  final String asset;

  ExternalExplorerLink({this.type, this.hash, this.asset});

  @override
  Widget build(BuildContext context) {
    final chain = assetFromString(asset).chain;
    final prefixedHash = chain == 'ETH' ? '0x$hash' : hash;
    final path = explorerBase(chain, type) +
        explorerTypePath(chain, type) +
        prefixedHash;

    return (hash.length > 0)
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => html.window.open(path, 'External Explorer'),
                child: Icon(
                  Icons.open_in_new,
                  size: 16,
                )))
        : Container();
  }
}

String explorerBase(String chain, ExplorerLinkType type) {
  switch (chain) {
    case 'BNB':
      return (net == "TESTNET")
          ? 'https://testnet-explorer.binance.org/'
          : 'https://explorer.binance.org/';

    case 'BTC':
      return (net == "TESTNET")
          ? 'https://blockstream.info/testnet/'
          : 'https://blockstream.info/';

    case 'ETH':
      return (net == "TESTNET")
          ? 'https://ropsten.etherscan.io/'
          : 'https://etherscan.io/';

    case 'LTC':
      return (net == "TESTNET")
          ? 'https://tltc.bitaps.com/'
          : 'https://ltc.bitaps.com/';

    case 'BCH':
      return (net == "TESTNET")
          ? 'https://explorer.bitcoin.com/tbch/'
          : 'https://explorer.bitcoin.com/bch/';

    default:
      return '';
  }
}

String explorerTypePath(String chain, ExplorerLinkType type) {
  switch (chain) {
    case 'BNB':
    case 'BTC':
    case 'ETH':
    case 'BCH':
      switch (type) {
        case ExplorerLinkType.Address:
          return 'address/';
        case ExplorerLinkType.Tx:
          return 'tx/';
        default:
          return '';
      }
      break;

    // Litecoin explorer users no explorer type path in url
    default:
      return '';
  }
}
