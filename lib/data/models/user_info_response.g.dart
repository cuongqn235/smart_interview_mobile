// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      platform: json['platform'] as String,
      subscription: json['subscription'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
