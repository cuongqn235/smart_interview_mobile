import 'package:freezed_annotation/freezed_annotation.dart';

const entity = Freezed(
  copyWith: true,
  when: FreezedWhenOptions.all,
  genericArgumentFactories: false,
  makeCollectionsUnmodifiable: false,
  toJson: false,
  fromJson: false,
  toStringOverride: true,
  equal: true,
);

const request = JsonSerializable(explicitToJson: true, createFactory: false);

const response = JsonSerializable(createToJson: false, explicitToJson: true);

const state = Freezed(
  copyWith: true,
  when: FreezedWhenOptions.all,
  toStringOverride: true,
  equal: true,
);
