import 'package:smart_interview/domain/entities/user_info_entity.dart';

abstract class AuthRepo {
  Future<UserInfoEntity> login();
  Future<void> logout();
}
