import 'package:graphql_flutter/graphql_flutter.dart';

QueryOptions poolQueryOptions(
    {required String asset,
    required DateTime startDate,
    required DateTime currentDate}) {
  return QueryOptions(document: gql("""
      query {
        pool(asset:"$asset") {
          asset,
          status,
          price,
          units,
          volume24h,
          poolAPY,
          stakes {
            assetStaked
            runeStaked
            poolStaked
          }
          depth {
            assetDepth,
            runeDepth,
            poolDepth,
          }
        },
        volumeHistory(
          from:${(startDate.millisecondsSinceEpoch / 1000).round()},
          until:${(currentDate.millisecondsSinceEpoch / 1000).round()},
          interval:HOUR,
          pool:"$asset"
        ){
          meta{
            combined{
              count,
              volumeInRune,
              feesInRune
            },
            toRune{
              count,
              volumeInRune,
              feesInRune
            }
            toAsset{
              count,
              volumeInRune,
              feesInRune
            }
          },
          intervals{
            time,
            combined{
              count,
              volumeInRune,
              feesInRune
            },
            toRune{
              count,
              volumeInRune,
              feesInRune
            }
            toAsset{
              count,
              volumeInRune,
              feesInRune
            }
          }
        }
      }
    """));
}

QueryOptions nodesListPageQueryOptions() {
  return QueryOptions(document: gql("""
      query {
        nodes{
          address,
          status,
          bond,
          ipAddress,
          version,
          slashPoints,
          jail{
            releaseHeight,
            reason
          },
          currentAward
        },
        network{
          bondMetrics {
            active {
              averageBond,
              maximumBond,
              medianBond,
              minimumBond,
              totalBond
            },
            standby {
              averageBond,
              maximumBond,
              medianBond,
              minimumBond,
              totalBond
            }
          },
        }
      }
    """));
}

QueryOptions nodePageQueryOptions(String address) {
  return QueryOptions(document: gql("""
    query {
      node(
        address:"$address",
      ){
        publicKeys{
          secp256k1,
          ed25519
        },
        address,
        status,
        bond,
        requestedToLeave,
        forcedToLeave,
        leaveHeight,
        ipAddress,
        version,
        slashPoints,
        jail{
          releaseHeight,
          reason
        },
        currentAward
      }
    }
    """));
}

QueryOptions networkPageQueryOptions() {
  return QueryOptions(document: gql("""
    query {
      network{
        bondingAPY,
        activeBonds,
        activeNodeCount,
        liquidityAPY,
        nextChurnHeight,
        poolActivationCountdown,
        poolShareFactor,
        totalReserve,
        standbyBonds,
        standbyNodeCount,
        totalPooledRune,
        bondMetrics {
          active {
            averageBond,
            maximumBond,
            medianBond,
            minimumBond,
            totalBond
          },
          standby {
            averageBond,
            maximumBond,
            medianBond,
            minimumBond,
            totalBond
          }
        },
        blockRewards{
          blockReward,
          bondReward,
          poolReward
        }
      }
    }
  """));
}

QueryOptions dashboardQueryOptions(DateTime startDate, DateTime currentDate) {
  return QueryOptions(document: gql("""
    query {
      network{
        bondingAPY,
        activeBonds,
        activeNodeCount,
        liquidityAPY,
        nextChurnHeight,
        poolActivationCountdown,
        poolShareFactor,
        totalReserve,
        standbyBonds,
        standbyNodeCount,
        totalPooledRune,
        bondMetrics {
          active {
            totalBond
          },
          standby {
            totalBond
          }
        },
      },
      volumeHistory(
        from:${(startDate.millisecondsSinceEpoch / 1000).round()},
        until:${(currentDate.millisecondsSinceEpoch / 1000).round()},
        interval:HOUR,
      ){
        meta{
          combined{
            count,
            volumeInRune,
            feesInRune
          },
          toRune{
            count,
            volumeInRune,
            feesInRune
          }
          toAsset{
            count,
            volumeInRune,
            feesInRune
          }
        },
        intervals{
          time,
                combined{
            count,
            volumeInRune,
            feesInRune
          },
          toRune{
            count,
            volumeInRune,
            feesInRune
          }
          toAsset{
            count,
            volumeInRune,
            feesInRune
          }
        }
      }
    }
    """));
}
