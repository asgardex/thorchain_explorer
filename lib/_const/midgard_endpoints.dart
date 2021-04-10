import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';

final List<MidgardEndpoint> testnetMidgardEndpoints = [
  MidgardEndpoint(
      path: '/health', name: 'Health Info', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/pools',
      name: 'Pools List',
      pathParams: [],
      queryParams: [
        MidgardParam(
            name: 'Status',
            key: 'status',
            value: '',
            valueOptions: ['available', 'staged', 'suspended'])
      ]),
  MidgardEndpoint(path: '/pool/{asset}', name: 'Pool Details', pathParams: [
    MidgardParam(name: 'Asset', key: 'asset', value: 'BTC.BTC')
  ]),
  MidgardEndpoint(path: '/pool/{asset}/stats', name: 'Pool Stats', pathParams: [
    MidgardParam(name: 'Asset', key: 'asset', value: 'BTC.BTC')
  ], queryParams: [
    MidgardParam(
        name: 'Period',
        key: 'period',
        value: '30d',
        valueOptions: ['1h', '24h', '7d', '30d', '90d', '365d', 'all'])
  ]),
  MidgardEndpoint(
      path: '/pool/{asset}/stats/legacy',
      name: 'Pool Stats (Legacy V1)',
      pathParams: [MidgardParam(name: 'Asset', key: 'asset', value: 'BTC.BTC')],
      queryParams: []),
  MidgardEndpoint(
      path: '/history/depths/{pool}',
      name: 'Depth and Price History',
      pathParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: 'BTC.BTC')
      ],
      queryParams: [
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/history/earnings',
      name: 'Earnings History',
      pathParams: [],
      queryParams: [
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/history/swaps',
      name: 'Swaps History',
      pathParams: [],
      queryParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/history/liquidity_changes',
      name: 'Liquidity Changes',
      pathParams: [],
      queryParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/nodes', name: 'Nodes List', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/network', name: 'Network Data', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/actions',
      name: 'Actions List',
      pathParams: [],
      queryParams: [
        MidgardParam(
            name: 'Limit',
            key: 'limit',
            value: '10',
            valueOptions: ['Between 0 - 50'],
            required: true),
        MidgardParam(
            name: 'Offset',
            key: 'offset',
            value: '0',
            valueOptions: [],
            required: true),
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
        MidgardParam(
            name: 'Address', key: 'address', value: '', valueOptions: []),
        MidgardParam(
            name: 'Transaction ID', key: 'txid', value: '', valueOptions: []),
        MidgardParam(
            name: 'Asset', key: 'asset', value: 'BTC.BTC', valueOptions: []),
        MidgardParam(name: 'Type', key: 'type', value: '', valueOptions: [
          'swap',
          'addLiquidity',
          'withdraw',
          'donate',
          'refund'
        ]),
      ]),
  MidgardEndpoint(
      path: '/members',
      name: 'Members',
      pathParams: [],
      queryParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
      ]),
  MidgardEndpoint(
      path: '/member/{address}',
      name: 'Member Details',
      pathParams: [
        MidgardParam(
            name: 'Address',
            key: 'address',
            value: 'tthor1h0rgwl3y6kp2krvs2w4hph6zxjrk7yuuw7742k')
      ],
      queryParams: []),
  MidgardEndpoint(
      path: '/stats', name: 'Stats', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/inbound_addresses',
      name: 'Proxied THORChain Inbound Addresses',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/constants',
      name: 'Proxied THORChain Constants',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/lastblock',
      name: 'Proxied THORChain Last Block',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/queue',
      name: 'Proxied THORChain Queue',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/nodes',
      name: 'Proxied THORChain Nodes',
      pathParams: [],
      queryParams: []),
];

final List<MidgardEndpoint> mainnetMidgardEndpoints = [
  MidgardEndpoint(
      path: '/health', name: 'Health Info', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/pools',
      name: 'Pools List',
      pathParams: [],
      queryParams: [
        MidgardParam(
            name: 'Status',
            key: 'status',
            value: '',
            valueOptions: ['available', 'staged', 'suspended'])
      ]),
  MidgardEndpoint(path: '/pool/{asset}', name: 'Pool Details', pathParams: [
    MidgardParam(name: 'Asset', key: 'asset', value: 'BTC.BTC')
  ]),
  MidgardEndpoint(path: '/pool/{asset}/stats', name: 'Pool Stats', pathParams: [
    MidgardParam(name: 'Asset', key: 'asset', value: 'BTC.BTC')
  ], queryParams: [
    MidgardParam(
        name: 'Period',
        key: 'period',
        value: '30d',
        valueOptions: ['1h', '24h', '7d', '30d', '90d', '365d', 'all'])
  ]),
  MidgardEndpoint(
      path: '/pool/{asset}/stats/legacy',
      name: 'Pool Stats (Legacy V1)',
      pathParams: [MidgardParam(name: 'Asset', key: 'asset', value: 'BTC.BTC')],
      queryParams: []),
  MidgardEndpoint(
      path: '/history/depths/{pool}',
      name: 'Depth and Price History',
      pathParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: 'BTC.BTC')
      ],
      queryParams: [
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/history/earnings',
      name: 'Earnings History',
      pathParams: [],
      queryParams: [
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/history/swaps',
      name: 'Swaps History',
      pathParams: [],
      queryParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/history/liquidity_changes',
      name: 'Liquidity Changes',
      pathParams: [],
      queryParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
        MidgardParam(
            name: 'Interval',
            key: 'interval',
            value: 'week',
            valueOptions: [
              "5min",
              "hour",
              "day",
              "week",
              "month",
              "quarter",
              "year"
            ]),
        MidgardParam(
            name: 'Count',
            key: 'count',
            value: '30',
            valueOptions: ["Number between 1 - 400"]),
        MidgardParam(
            name: 'To (unix timestamp)',
            key: 'to',
            value: '',
            valueOptions: []),
        MidgardParam(
            name: 'From (unix timestamp)',
            key: 'from',
            value: '',
            valueOptions: [])
      ]),
  MidgardEndpoint(
      path: '/nodes', name: 'Nodes List', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/network', name: 'Network Data', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/actions',
      name: 'Actions List',
      pathParams: [],
      queryParams: [
        MidgardParam(
            name: 'Limit',
            key: 'limit',
            value: '10',
            valueOptions: ['Between 0 - 50'],
            required: true),
        MidgardParam(
            name: 'Offset',
            key: 'offset',
            value: '0',
            valueOptions: [],
            required: true),
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
        MidgardParam(
            name: 'Address', key: 'address', value: '', valueOptions: []),
        MidgardParam(
            name: 'Transaction ID', key: 'txid', value: '', valueOptions: []),
        MidgardParam(
            name: 'Asset', key: 'asset', value: 'BTC.BTC', valueOptions: []),
        MidgardParam(name: 'Type', key: 'type', value: '', valueOptions: [
          'swap',
          'addLiquidity',
          'withdraw',
          'donate',
          'refund'
        ]),
      ]),
  MidgardEndpoint(
      path: '/members',
      name: 'Members',
      pathParams: [],
      queryParams: [
        MidgardParam(name: 'Pool', key: 'pool', value: '', valueOptions: []),
      ]),
  MidgardEndpoint(
      path: '/member/{address}',
      name: 'Member Details',
      pathParams: [
        MidgardParam(
            name: 'Address',
            key: 'address',
            value: 'thor1q6mhk70ecvnmw3ekawm5pr8wty509hcqug65gt')
      ],
      queryParams: []),
  MidgardEndpoint(
      path: '/stats', name: 'Stats', pathParams: [], queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/inbound_addresses',
      name: 'Proxied THORChain Inbound Addresses',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/constants',
      name: 'Proxied THORChain Constants',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/lastblock',
      name: 'Proxied THORChain Last Block',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/queue',
      name: 'Proxied THORChain Queue',
      pathParams: [],
      queryParams: []),
  MidgardEndpoint(
      path: '/thorchain/nodes',
      name: 'Proxied THORChain Nodes',
      pathParams: [],
      queryParams: []),
];

// https://testnet.midgard.thorchain.info/#operation/GetPoolStatsLegacy/v2/history/depths/{pool}
