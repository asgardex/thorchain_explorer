// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstantInts _$ConstantIntsFromJson(Map<String, dynamic> json) {
  return ConstantInts()
    ..asgardSize = json['AsgardSize'] as int
    ..badValidatorRate = json['BadValidatorRate'] as int
    ..badValidatorRedline = json['BadValidatorRedline'] as int
    ..blocksPerYear = json['BlocksPerYear'] as int
    ..churnInterval = json['ChurnInterval'] as int
    ..churnRetryInterval = json['ChurnRetryInterval'] as int
    ..desiredValidatorSet = json['DesiredValidatorSet'] as int
    ..doubleSignMaxAge = json['DoubleSignMaxAge'] as int
    ..emissionCurve = json['EmissionCurve'] as int
    ..failKeygenSlashPoints = json['FailKeygenSlashPoints'] as int
    ..failKeysignSlashPoints = json['FailKeysignSlashPoints'] as int
    ..fullImpLossProtectionBlocks = json['FullImpLossProtectionBlocks'] as int
    ..fundMigrationInterval = json['FundMigrationInterval'] as int
    ..incentiveCurve = json['IncentiveCurve'] as int
    ..jailTimeKeygen = json['JailTimeKeygen'] as int
    ..jailTimeKeysign = json['JailTimeKeysign'] as int
    ..lackOfObservationPenalty = json['LackOfObservationPenalty'] as int
    ..liquidityLockUpBlocks = json['LiquidityLockUpBlocks'] as int
    ..maxAvailablePools = json['MaxAvailablePools'] as int
    ..maxSwapsPerBlock = json['MaxSwapsPerBlock'] as int
    ..maxSynthPerAssetDepth = json['MaxSynthPerAssetDepth'] as int
    ..minRunePoolDepth = json['MinRunePoolDepth'] as int
    ..minSlashPointsForBadValidator =
        json['MinSlashPointsForBadValidator'] as int
    ..minSwapsPerBlock = json['MinSwapsPerBlock'] as int
    ..minimumBondInRune = json['MinimumBondInRune'] as int
    ..minimumNodesForBFT = json['MinimumNodesForBFT'] as int
    ..minimumNodesForYggdrasil = json['MinimumNodesForYggdrasil'] as int
    ..nativeTransactionFee = json['NativeTransactionFee'] as int
    ..observationDelayFlexibility = json['ObservationDelayFlexibility'] as int
    ..observeSlashPoints = json['ObserveSlashPoints'] as int
    ..oldValidatorRate = json['OldValidatorRate'] as int
    ..outboundTransactionFee = json['OutboundTransactionFee'] as int
    ..poolCycle = json['PoolCycle'] as int
    ..signingTransactionPeriod = json['SigningTransactionPeriod'] as int
    ..stagedPoolCost = json['StagedPoolCost'] as int
    ..virtualMultSynths = json['VirtualMultSynths'] as int
    ..yggFundLimit = json['YggFundLimit'] as int
    ..yggFundRetry = json['YggFundRetry'] as int;
}

Map<String, dynamic> _$ConstantIntsToJson(ConstantInts instance) =>
    <String, dynamic>{
      'AsgardSize': instance.asgardSize,
      'BadValidatorRate': instance.badValidatorRate,
      'BadValidatorRedline': instance.badValidatorRedline,
      'BlocksPerYear': instance.blocksPerYear,
      'ChurnInterval': instance.churnInterval,
      'ChurnRetryInterval': instance.churnRetryInterval,
      'DesiredValidatorSet': instance.desiredValidatorSet,
      'DoubleSignMaxAge': instance.doubleSignMaxAge,
      'EmissionCurve': instance.emissionCurve,
      'FailKeygenSlashPoints': instance.failKeygenSlashPoints,
      'FailKeysignSlashPoints': instance.failKeysignSlashPoints,
      'FullImpLossProtectionBlocks': instance.fullImpLossProtectionBlocks,
      'FundMigrationInterval': instance.fundMigrationInterval,
      'IncentiveCurve': instance.incentiveCurve,
      'JailTimeKeygen': instance.jailTimeKeygen,
      'JailTimeKeysign': instance.jailTimeKeysign,
      'LackOfObservationPenalty': instance.lackOfObservationPenalty,
      'LiquidityLockUpBlocks': instance.liquidityLockUpBlocks,
      'MaxAvailablePools': instance.maxAvailablePools,
      'MaxSwapsPerBlock': instance.maxSwapsPerBlock,
      'MaxSynthPerAssetDepth': instance.maxSynthPerAssetDepth,
      'MinRunePoolDepth': instance.minRunePoolDepth,
      'MinSlashPointsForBadValidator': instance.minSlashPointsForBadValidator,
      'MinSwapsPerBlock': instance.minSwapsPerBlock,
      'MinimumBondInRune': instance.minimumBondInRune,
      'MinimumNodesForBFT': instance.minimumNodesForBFT,
      'MinimumNodesForYggdrasil': instance.minimumNodesForYggdrasil,
      'NativeTransactionFee': instance.nativeTransactionFee,
      'ObservationDelayFlexibility': instance.observationDelayFlexibility,
      'ObserveSlashPoints': instance.observeSlashPoints,
      'OldValidatorRate': instance.oldValidatorRate,
      'OutboundTransactionFee': instance.outboundTransactionFee,
      'PoolCycle': instance.poolCycle,
      'SigningTransactionPeriod': instance.signingTransactionPeriod,
      'StagedPoolCost': instance.stagedPoolCost,
      'VirtualMultSynths': instance.virtualMultSynths,
      'YggFundLimit': instance.yggFundLimit,
      'YggFundRetry': instance.yggFundRetry,
    };

ConstantBools _$ConstantBoolsFromJson(Map<String, dynamic> json) {
  return ConstantBools()
    ..strictBondLiquidityRatio = json['StrictBondLiquidityRatio'] as bool;
}

Map<String, dynamic> _$ConstantBoolsToJson(ConstantBools instance) =>
    <String, dynamic>{
      'StrictBondLiquidityRatio': instance.strictBondLiquidityRatio,
    };

ConstantStrings _$ConstantStringsFromJson(Map<String, dynamic> json) {
  return ConstantStrings()
    ..defaultPoolStatus = json['DefaultPoolStatus'] as String;
}

Map<String, dynamic> _$ConstantStringsToJson(ConstantStrings instance) =>
    <String, dynamic>{
      'DefaultPoolStatus': instance.defaultPoolStatus,
    };

Constants _$ConstantsFromJson(Map<String, dynamic> json) {
  return Constants(
    int64Values: ConstantInts.fromJson(
        Map<String, int>.from(json['int_64_values'] as Map)),
    boolValues: ConstantBools.fromJson(
        Map<String, bool>.from(json['bool_values'] as Map)),
    stringValues: ConstantStrings.fromJson(
        Map<String, String>.from(json['string_values'] as Map)),
  );
}

Map<String, dynamic> _$ConstantsToJson(Constants instance) => <String, dynamic>{
      'int_64_values': instance.int64Values,
      'bool_values': instance.boolValues,
      'string_values': instance.stringValues,
    };
