import 'package:smart_interview/core/ultis/freezed_ultis.dart';
import 'package:smart_interview/data/models/user_info_response.dart';

part 'user_login_response.g.dart';

@response
class UserLoginResponse {
  final String accessToken;
  final UserInfoResponse user;
  UserLoginResponse({
    required this.accessToken,
    required this.user,
  });
  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);
}
