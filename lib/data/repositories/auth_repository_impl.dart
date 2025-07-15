import 'package:injectable/injectable.dart';
import 'package:smart_interview/data/datasources/auth_remote_data_source.dart';
import 'package:smart_interview/domain/entities/user_entity.dart';
import 'package:smart_interview/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    // TODO: implement login
    // final userModel = await _remoteDataSource.login(email, password);
    // return userModel.toEntity();
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
