abstract class AppRepo {
  Future<void> clearAccessToken();
  Future<String?> getAccessToken();
  // Future<String?> getLanguageCode();
  Future<bool> isFirstLaunch();
  Future<void> setAccessToken(String accessToken);

  Future<void> setFirstLaunch(bool isFirstLaunch);
  // Future<void> setLanguageCode(String languageCode);
}
