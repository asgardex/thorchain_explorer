import 'package:graphql_flutter/graphql_flutter.dart';

QueryOptions poolQueryOptions(String asset) {

  return QueryOptions(
      document: gql("""
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
      }
    }
    """
      )
  );
}

QueryOptions nodePageQueryOptions(String address) {
  return QueryOptions(
    document: gql("""
    query {
      node(
        address:$address,
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
    """
    )
  );
}

QueryOptions dashboardQueryOptions(DateTime startDate, DateTime currentDate) {
  return QueryOptions(
    document: gql("""
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
        totalPooledRune
      },
      volumeHistory(
        from:${(startDate.millisecondsSinceEpoch / 1000).round()},
        until:${(currentDate.millisecondsSinceEpoch / 1000).round()},
        interval:DAY,
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
      },
      stats{
        dailyActiveUsers,
        monthlyActiveUsers,
        totalUsers,
        dailyTx,
        monthlyTx,
        totalAssetBuys,
        totalAssetSells,
        totalDepth,
        totalStakeTx,
        totalStaked,
        totalTx,
        totalVolume,
        totalWithdrawTx,
      }
    }
    """
  ));
}
