abstract class AppRepo {
  Future<String?> getAccessToken();
  Future<bool> isFirstLaunch();
  Future<void> setAccessToken(String accessToken);
  Future<void> setFirstLaunch(bool isFirstLaunch);
}
