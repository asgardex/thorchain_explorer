
import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {

  final String asset;
  final double width;

  AssetIcon(this.asset, {this.width = 50});

  @override
  Widget build(BuildContext context) {

    String trustWalletMatch = CoinIconsFromTrustWallet[asset];
    String logoPath;

    if (trustWalletMatch != null) {
      logoPath = "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/binance/assets/$trustWalletMatch/logo.png";
    } else {
      switch (asset){
        case 'BNB.BNB':
          logoPath = 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/binance/info/logo.png';
          break;

        case 'ETH.ETH':
          logoPath = 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png';
          break;

        case 'BTC.BTC':
          logoPath = 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/binance/assets/BTCB-1DE/logo.png';
          break;

        case 'THOR.RUNE':
          logoPath = 'https://raw.githubusercontent.com/trustwallet/assets/cb8de815813e330b8db3d9ec01fa0ffc7d60f914/blockchains/binance/assets/RUNE-B1A/logo.png';
          break;

      }

    }

    return Container(
      width: width,
      child: logoPath != null ? Image.network(logoPath) : Icon(Icons.error_outline)
    );
  }
}

const Map<String, String> CoinIconsFromTrustWallet = {
  'ABCD': 'ABCD-5D8',
  'AERGO': 'AERGO-46B',
  'ALA': 'ALA-DCD',
  'ANKR': 'ANKR-E97',
  'ARN': 'ARN-71B',
  'ARPA': 'ARPA-575',
  'ART': 'ART-3C9',
  'ATP': 'ATP-38C',
  'AVA': 'AVA-645',
  'AWC': 'AWC-986',
  'AXPR': 'AXPR-777',
  'BAW': 'BAW-DFB',
  'BCH': 'BCH-1FD',
  'BCPT': 'BCPT-95A',
  'BEAR': 'BEAR-14C',
  'BET': 'BET-844',
  'BETX': 'BETX-A0C',
  'BGBP': 'BGBP-CF3',
  'BHC': 'BHC-3E8M',
  'BHFT': 'BHFT-BBE',
  'BIDR': 'BIDR-0E9',
  'BKBT': 'BKBT-3A6',
  'BKRW': 'BKRW-AB7',
  'BLINK': 'BLINK-9C6',
  'BOLT': 'BOLT-4C6',
  'BST2': 'BST2-2F2',
  'BTCB': 'BTCB-1DE',
  'BTTB': 'BTTB-D31',
  'BULL': 'BULL-BE4',
  'BUSD': 'BUSD-BD1',
  'BZNT': 'BZNT-464',
  'CAN': 'CAN-677',
  'CAS': 'CAS-167',
  'CBIX': 'CBIX-3C9',
  'CBM': 'CBM-4B2',
  'CHZ': 'CHZ-ECD',
  'CNNS': 'CNNS-E16',
  'COS': 'COS-2E4',
  'COTI': 'COTI-CBB',
  'COVA': 'COVA-218',
  'CRPT': 'CRPT-8C9',
  'CSM': 'CSM-734',
  'DARC': 'DARC-24B',
  'DEEP': 'DEEP-9D3',
  'DEFI': 'DEFI-FA5',
  'DOS': 'DOS-120',
  'DREP': 'DREP-7D2',
  'DUSK': 'DUSK-45E',
  'EBST': 'EBST-783',
  'ECO': 'ECO-083',
  'EET': 'EET-45C',
  'ENTRP': 'ENTRP-C8D',
  'EOS': 'EOS-CDD',
  'EOSBEAR': 'EOSBEAR-721',
  'EOSBULL': 'EOSBULL-F0D',
  'EQL': 'EQL-586',
  'ERD': 'ERD-D06',
  'ETH': 'ETH-1C9',
  'ETHBEAR': 'ETHBEAR-B2B',
  'ETHBULL': 'ETHBULL-D33',
  'EVT': 'EVT-49B',
  'FRM': 'FRM-DE7',
  'FSN': 'FSN-E14',
  'FTM': 'FTM-A64',
  'GIV': 'GIV-94E',
  'GMAT': 'GMAT-FC8',
  'GTEX': 'GTEX-71B',
  'GTO': 'GTO-908',
  'HNST': 'HNST-3C9',
  'HYN': 'HYN-F21',
  'IDRTB': 'IDRTB-178',
  'IRIS': 'IRIS-D88',
  'JDXU': 'JDXU-706',
  'KAT': 'KAT-7BB',
  'KAVA': 'KAVA-10C',
  'LBA': 'LBA-340',
  'LIT': 'LIT-099',
  'LOKI': 'LOKI-6A9',
  'LTC': 'LTC-F07',
  'LTO': 'LTO-BDF',
  'LYFE': 'LYFE-6AB',
  'MATIC': 'MATIC-84A',
  'MCASH': 'MCASH-869',
  'MDAB': 'MDAB-D42',
  'MEDB': 'MEDB-87E',
  'MEETONE': 'MEETONE-031',
  'MITH': 'MITH-C76',
  'MITX': 'MITX-CAA',
  'MTV': 'MTV-4C6',
  'MTXLT': 'MTXLT-286',
  'MVL': 'MVL-7B0',
  'MZK': 'MZK-2C7',
  'NEW': 'NEW-09E',
  'NEXO': 'NEXO-A84',
  'NODE': 'NODE-F3A',
  'NOIZB': 'NOIZB-878',
  'NOW': 'NOW-E68',
  'NPXB': 'NPXB-1E8',
  'NPXSXEM': 'NPXSXEM-89C',
  'ONE': 'ONE-5F9',
  'ONT': 'ONT-33D',
  'OWTX': 'OWTX-A6B',
  'PCAT': 'PCAT-4BB',
  'PHB': 'PHB-2DF',
  'PHV': 'PHV-4A1',
  'PIBNB': 'PIBNB-43C',
  'PLG': 'PLG-D8D',
  'PVT': 'PVT-554',
  'PYN': 'PYN-C37',
  'QBX': 'QBX-38C',
  'RAVEN': 'RAVEN-F66',
  'RNO': 'RNO-14E',
  'RUNE': 'RUNE-B1A',
  'SBC': 'SBC-5D4',
  'SHR': 'SHR-DB6',
  'SLV': 'SLV-986',
  'SPNDB': 'SPNDB-916',
  'STYL': 'STYL-65B',
  'SWINGBY': 'SWINGBY-888',
  'SWIPE': 'SWIPE.B-DC0',
  'SXP': 'SXP-CCC',
  'TAUDB': 'TAUDB-888',
  'TCADB': 'TCADB-888',
  'TGBPB': 'TGBPB-888',
  'THKDB': 'THKDB-888',
  'TM2': 'TM2-0C4',
  'TOMOB': 'TOMOB-4BC',
  'TOP': 'TOP-491',
  'TROY': 'TROY-9B8',
  'TRUE': 'TRUE-D84',
  'TRXB': 'TRXB-2E6',
  'TUSDB': 'TUSDB-888',
  'TWT': 'TWT-8C2',
  'UGAS': 'UGAS-B0C',
  'UND': 'UND-EBC',
  'UPX': 'UPX-F3E',
  'USDH': 'USDH-5B5',
  'USDSB': 'USDSB-1AC',
  'VDX': 'VDX-A17',
  'VIDT': 'VIDT-F53',
  'VNDC': 'VNDC-DB9',
  'VOTE': 'VOTE-FD4',
  'VRAB': 'VRAB-B56',
  'WICC': 'WICC-01D',
  'WINB': 'WINB-41F',
  'WISH': 'WISH-2D5',
  'WRX': 'WRX-ED1',
  'XBASE': 'XBASE-CD2',
  'XNS': 'XNS-760',
  'XRP': 'XRP-BF2',
  'XRPBEAR': 'XRPBEAR-00B',
  'XRPBULL': 'XRPBULL-E7C',
  'XTZ': 'XTZ-F7A',
  'ZEBI': 'ZEBI-84F',
};
