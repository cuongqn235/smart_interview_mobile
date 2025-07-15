import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: '/auth')
@injectable
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio, {String? baseUrl}) =
      _AuthRemoteDataSource;

  @POST('/login')
  Future<HttpResponse> login(@Body() Map<String, dynamic> body);

  @POST('/register')
  Future<HttpResponse> register(@Body() Map<String, dynamic> body);
}
