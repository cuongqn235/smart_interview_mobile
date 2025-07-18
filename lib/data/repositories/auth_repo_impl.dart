import 'package:injectable/injectable.dart';
import 'package:smart_interview/data/datasources/auth_remote_data_source.dart';
import 'package:smart_interview/data/datasources/google_remote_data_source.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/domain/entities/user_info_entity.dart';
import 'package:smart_interview/domain/entities/user_login_entity.dart';
import 'package:smart_interview/domain/repositories/app_repo.dart';
import 'package:smart_interview/domain/repositories/auth_repo.dart';

@Singleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final GoogleAuthRemoteDataSource _googleAuthRemoteDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final AppRepo _appRepo;
  AuthRepoImpl(this._googleAuthRemoteDataSource, this._authRemoteDataSource,
      this._appRepo);

  @override
  Future<UserInfoEntity> login() async {
    final googleUser = await _googleAuthRemoteDataSource.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in failed');
    }
    final tokenId = googleUser.authentication.idToken;
    final response = await _authRemoteDataSource.login({
      'platform': 'google',
      'idToken': tokenId,
    });
    final value = response.onResult(
      (data) => UserLoginEntity(
        accessToken: data.accessToken,
        user: UserInfoEntity(
          id: data.user.id,
          email: data.user.email,
          name: data.user.name,
          avatar: data.user.avatar,
          platform: data.user.platform,
          subscription: data.user.subscription,
          createdAt: data.user.createdAt,
        ),
      ),
    );
    await _appRepo.setAccessToken(value.accessToken);
    return value.user;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
