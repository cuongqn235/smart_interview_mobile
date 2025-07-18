import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@Freezed(
  genericArgumentFactories: true,
  fromJson: true,
  toJson: false,
  when: FreezedWhenOptions.all,
)
sealed class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    required bool status,
    required int code,
    required String message,
    T? data,
    dynamic meta,
    dynamic error,
  }) = _BaseResponse<T>;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

extension BaseResponseExtension<T> on BaseResponse<T> {
  R onResult<R>(
    R Function(T data) onSuccess, {
    Exception Function(dynamic error)? onError,
  }) {
    if (status) {
      return onSuccess(data as T);
    } else if (onError != null) {
      throw onError(error);
    } else {
      throw Exception(error);
    }
  }
}
