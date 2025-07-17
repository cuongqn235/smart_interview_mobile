import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  String get baseUrl => 'https://api.example.com';
  Future<GoogleSignIn> get googleSignIn => Future.value(GoogleSignIn.instance);
  @singleton
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
        ),
      );
}
