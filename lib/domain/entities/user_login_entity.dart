import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_info_entity.dart';

part 'user_login_entity.freezed.dart';

@freezed
sealed class UserLoginEntity with _$UserLoginEntity {
  const factory UserLoginEntity({
    required String accessToken,
    required UserInfoEntity user,
  }) = _UserLoginEntity;
}
