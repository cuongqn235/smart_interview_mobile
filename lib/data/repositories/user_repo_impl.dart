import 'package:injectable/injectable.dart';
import 'package:smart_interview/data/datasources/user_remote_data_source.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/domain/entities/user_info_entity.dart';
import 'package:smart_interview/domain/repositories/user_repo.dart';

@Singleton(as: UserRepo)
class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepoImpl(this._userRemoteDataSource);

  @override
  Future<UserInfoEntity> getUserInfo() async {
    final response = await _userRemoteDataSource.getUserInfo();
    return response.onResult((data) => UserInfoEntity(
          id: data.id,
          email: data.email,
          name: data.name,
          avatar: data.avatar,
          platform: data.platform,
          subscription: data.subscription,
          createdAt: data.createdAt,
        ));
  }
}
