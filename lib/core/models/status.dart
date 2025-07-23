import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';

@freezed
sealed class Status with _$Status {
  const factory Status.error({
    required dynamic error,
  }) = Error;
  const factory Status.idle() = Idle;
  const factory Status.loading() = Loading;
  const factory Status.success() = Success;
}
