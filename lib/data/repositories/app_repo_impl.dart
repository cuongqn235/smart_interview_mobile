import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_interview/domain/repositories/app_repo.dart';

@Singleton(as: AppRepo)
class AppRepoImpl implements AppRepo {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _flutterSecureStorage;
  AppRepoImpl(this._sharedPreferences, this._flutterSecureStorage);

  @override
  Future<String?> getAccessToken() async {
    return await _flutterSecureStorage.read(key: 'access_token');
  }

  @override
  Future<bool> isFirstLaunch() async {
    return _sharedPreferences.getBool('isFirstLaunch') ?? true;
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    await _flutterSecureStorage.write(key: 'access_token', value: accessToken);
  }

  @override
  Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await _sharedPreferences.setBool('isFirstLaunch', isFirstLaunch);
  }
}
