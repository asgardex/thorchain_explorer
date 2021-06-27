import 'package:json_annotation/json_annotation.dart';

part 'constants.g.dart';

@JsonSerializable()
class ConstantInts {
  @JsonKey(name: 'AsgardSize')
  int asgardSize = 0;

  @JsonKey(name: 'BadValidatorRate')
  int badValidatorRate = 0;

  @JsonKey(name: 'BadValidatorRedline')
  int badValidatorRedline = 0;

  @JsonKey(name: 'BlocksPerYear')
  int blocksPerYear = 0;

  @JsonKey(name: 'ChurnInterval')
  int churnInterval = 0;

  @JsonKey(name: 'ChurnRetryInterval')
  int churnRetryInterval = 0;

  @JsonKey(name: 'DesiredValidatorSet')
  int desiredValidatorSet = 0;

  @JsonKey(name: 'DoubleSignMaxAge')
  int doubleSignMaxAge = 0;

  @JsonKey(name: 'EmissionCurve')
  int emissionCurve = 0;

  @JsonKey(name: 'FailKeygenSlashPoints')
  int failKeygenSlashPoints = 0;

  @JsonKey(name: 'FailKeysignSlashPoints')
  int failKeysignSlashPoints = 0;

  @JsonKey(name: 'FullImpLossProtectionBlocks')
  int fullImpLossProtectionBlocks = 0;

  @JsonKey(name: 'FundMigrationInterval')
  int fundMigrationInterval = 0;

  @JsonKey(name: 'IncentiveCurve')
  int incentiveCurve = 0;

  @JsonKey(name: 'JailTimeKeygen')
  int jailTimeKeygen = 0;

  @JsonKey(name: 'JailTimeKeysign')
  int jailTimeKeysign = 0;

  @JsonKey(name: 'LackOfObservationPenalty')
  int lackOfObservationPenalty = 0;

  @JsonKey(name: 'LiquidityLockUpBlocks')
  int liquidityLockUpBlocks = 0;

  @JsonKey(name: 'MaxAvailablePools')
  int maxAvailablePools = 0;

  @JsonKey(name: 'MaxSwapsPerBlock')
  int maxSwapsPerBlock = 0;

  @JsonKey(name: 'MaxSynthPerAssetDepth')
  int maxSynthPerAssetDepth = 0;

  @JsonKey(name: 'MinRunePoolDepth')
  int minRunePoolDepth = 0;

  @JsonKey(name: 'MinSlashPointsForBadValidator')
  int minSlashPointsForBadValidator = 0;

  @JsonKey(name: 'MinSwapsPerBlock')
  int minSwapsPerBlock = 0;

  @JsonKey(name: 'MinimumBondInRune')
  int minimumBondInRune = 0;

  @JsonKey(name: 'MinimumNodesForBFT')
  int minimumNodesForBFT = 0;

  @JsonKey(name: 'MinimumNodesForYggdrasil')
  int minimumNodesForYggdrasil = 0;

  @JsonKey(name: 'NativeTransactionFee')
  int nativeTransactionFee = 0;

  @JsonKey(name: 'ObservationDelayFlexibility')
  int observationDelayFlexibility = 0;

  @JsonKey(name: 'ObserveSlashPoints')
  int observeSlashPoints = 0;

  @JsonKey(name: 'OldValidatorRate')
  int oldValidatorRate = 0;

  @JsonKey(name: 'OutboundTransactionFee')
  int outboundTransactionFee = 0;

  @JsonKey(name: 'PoolCycle')
  int poolCycle = 0;

  @JsonKey(name: 'SigningTransactionPeriod')
  int signingTransactionPeriod = 0;

  @JsonKey(name: 'StagedPoolCost')
  int stagedPoolCost = 0;

  @JsonKey(name: 'VirtualMultSynths')
  int virtualMultSynths = 0;

  @JsonKey(name: 'YggFundLimit')
  int yggFundLimit = 0;

  @JsonKey(name: 'YggFundRetry')
  int yggFundRetry = 0;

  ConstantInts();

  factory ConstantInts.fromJson(Map<String, int> json) =>
      _$ConstantIntsFromJson(json);
}

@JsonSerializable()
class ConstantBools {
  @JsonKey(name: 'StrictBondLiquidityRatio')
  bool strictBondLiquidityRatio = true;

  ConstantBools();

  factory ConstantBools.fromJson(Map<String, bool> json) =>
      _$ConstantBoolsFromJson(json);
}

@JsonSerializable()
class ConstantStrings {
  @JsonKey(name: 'DefaultPoolStatus')
  String defaultPoolStatus = '';

  ConstantStrings();

  factory ConstantStrings.fromJson(Map<String, String> json) =>
      _$ConstantStringsFromJson(json);
}

/// This is very similar to PoolLiquidityProvider
/// Midgard can query by specific address but not fetch members by pool
/// THORNode can query by specific pool, but not fetch specific address
@JsonSerializable()
class Constants {
  @JsonKey(name: 'int_64_values')
  ConstantInts int64Values;

  @JsonKey(name: 'bool_values')
  ConstantBools boolValues;

  @JsonKey(name: 'string_values')
  ConstantBools stringValues;

  Constants(
      {required this.int64Values,
      required this.boolValues,
      required this.stringValues});

  factory Constants.fromJson(Map<String, dynamic> json) =>
      _$ConstantsFromJson(json);
}
