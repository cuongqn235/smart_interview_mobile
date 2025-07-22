import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/user_info_response.dart';

part 'user_remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class UserRemoteDataSource {
  @factoryMethod
  factory UserRemoteDataSource(Dio dio, {String? baseUrl}) =
      _UserRemoteDataSource;

  @GET('/user/me')
  Future<BaseResponse<UserInfoResponse>> getUserInfo();
}
