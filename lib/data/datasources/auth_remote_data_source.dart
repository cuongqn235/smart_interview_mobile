import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_interview/data/models/base_response.dart';
import 'package:smart_interview/data/models/user_login_response.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio, {String? baseUrl}) =
      _AuthRemoteDataSource;

  @POST('/auth/login')
  Future<BaseResponse<UserLoginResponse>> login(
      @Body() Map<String, dynamic> body);

  @POST('/auth/register')
  Future<BaseResponse<UserLoginResponse>> register(
      @Body() Map<String, dynamic> body);
}
