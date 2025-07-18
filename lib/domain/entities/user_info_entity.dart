import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_entity.freezed.dart';

@freezed
sealed class UserInfoEntity with _$UserInfoEntity {
  const factory UserInfoEntity({
    required int id,
    required String email,
    required String name,
    String? avatar,
    required String platform,
    required String subscription,
    required DateTime createdAt,
  }) = _UserInfoEntity;
}
