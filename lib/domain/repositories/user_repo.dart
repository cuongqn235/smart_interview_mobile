import 'package:smart_interview/domain/entities/user_info_entity.dart';

abstract class UserRepo {
  Future<UserInfoEntity> getUserInfo();
}
