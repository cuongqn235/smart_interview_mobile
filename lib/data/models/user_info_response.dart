import 'package:smart_interview/core/ultis/freezed_ultis.dart';

part 'user_info_response.g.dart';

@response
class UserInfoResponse {
  final int id;
  final String email;
  final String name;
  final String avatar;
  final String platform;
  final String subscription;
  final DateTime createdAt;
  UserInfoResponse({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.platform,
    required this.subscription,
    required this.createdAt,
  });
  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
}
