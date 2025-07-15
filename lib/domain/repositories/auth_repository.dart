import 'package:smart_interview/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<void> register(String email, String password, String fullName);
}
