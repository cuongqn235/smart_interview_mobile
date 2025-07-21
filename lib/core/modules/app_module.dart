import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_interview/core/interceptors/auth_interceptors.dart';

@module
abstract class AppModule {
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  Future<GoogleSignIn> get googleSignIn => Future.value(GoogleSignIn.instance);
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @singleton
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      )
        ..interceptors.add(AuthInterceptors(flutterSecureStorage))
        ..interceptors.add(
          LogInterceptor(
            request: true,
            responseBody: true,
            requestBody: true,
            requestHeader: true,
            responseHeader: false,
          ),
        );
}
