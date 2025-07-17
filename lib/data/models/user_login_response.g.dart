// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse(
      accessToken: json['accessToken'] as String,
      user: UserInfoResponse.fromJson(json['user'] as Map<String, dynamic>),
    );
