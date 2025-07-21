import 'package:smart_interview/domain/entities/user_info_entity.dart';

abstract class AuthRepo {
  Future<bool> init();
  Future<UserInfoEntity> login();
  Future<void> logout();
}
