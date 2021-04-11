import 'package:thorchain_explorer/_classes/asset.dart';
import 'package:thorchain_explorer/_const/chains.dart';
import 'package:web3dart/web3dart.dart';

Asset assetFromString(String s) {
  List<String> data = s.split('.');
  if (data.length < 1 || data[1]?.length < 1) {
    return null;
  }

  String chain = data[0];
  if (!isChain(chain)) {
    return null;
  }

  final symbol = data[1];
  final ticker = symbol.split('-')[0];

  return Asset(chain: chain, symbol: symbol, ticker: ticker);
}

EthereumAddress ethAddressFromAsset(Asset a) {
  if (a.chain != 'ETH') {
    return null;
  }

  final data = a.symbol.split('-');
  if (data.length < 2 || data[1]?.length < 1) {
    return null;
  }

  final address = EthereumAddress.fromHex(strip0x(data[1]));

  return address;
}

String strip0x(String hex) {
  if (hex.toUpperCase().startsWith('0X')) {
    return hex.substring(2);
  } else {
    return hex;
  }
}
