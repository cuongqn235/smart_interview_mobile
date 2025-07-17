import 'package:smart_interview/domain/entities/user_login_entity.dart';

abstract class AuthRepository {
  Future<UserLoginEntity> login();
  Future<void> logout();
  Future<void> register(String email, String password, String fullName);
}
