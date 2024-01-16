import '../../../../core/service/cache_service.dart';
import '../models/user.dart';

abstract class AuthLocalDataSource {
  Future<bool?> saveIsLoggedIn(bool isLoggedIn);
  Future<bool?> isLoggedIn();
  Future<String?> getLanguageCode();
  Future<String?> isTokenCreated();
  Future<String?> getTokenExpirationDate();
  Future<String?> getRefreshToken();
  Future<bool> saveUserData(User userData);
  Future<bool> saveUserToken(String token);
  Future<bool> saveUserRefreshToken(String refreshToken);
  Future<bool> saveUserTokenExpirationDate(String tokenExpirationDate);
  Future<void> clearUserData();
  Future<bool> updateUserData(User user);

  Future<bool?> setNotificationStatus(bool isEnabled);
  Future<bool?> isNotificationEnabled();

  Future<bool?> setAdTrackingNotification(bool isEnabled);
  Future<bool?> isAdTrackingNotificationEnabled();

  Future<bool> saveAppleUserData(User appleUserData);
  Future<String?> getAppleUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final CacheService _cacheService;

  AuthLocalDataSourceImpl(this._cacheService);

  @override
  Future<bool> saveUserData(User userData) =>
      _cacheService.saveUserData(userData.toJson());

  @override
  Future<bool> updateUserData(User user) async {
    //TODO: check functionality for update user info
    return Future.value(true);
  }

  @override
  Future<void> clearUserData() => _cacheService.clearUserData();

  @override
  Future<bool?> isLoggedIn() => _cacheService.getUserIsLoggedIn();

  @override
  Future<bool?> saveIsLoggedIn(bool isLoggedIn) =>
      _cacheService.saveUserIsLoggedIn(isLoggedIn);

  @override
  Future<String?> isTokenCreated() => _cacheService.getUserToken();

  @override
  Future<bool> saveUserRefreshToken(String refreshToken) =>
      _cacheService.saveUserRefreshToken(refreshToken);

  @override
  Future<bool> saveUserToken(String token) =>
      _cacheService.saveUserToken(token);

  @override
  Future<bool> saveUserTokenExpirationDate(String tokenExpirationDate) =>
      _cacheService.saveUserTokenExpirationDate(tokenExpirationDate);

  @override
  Future<String?> getTokenExpirationDate() =>
      _cacheService.getUserTokenExpirationDate();

  @override
  Future<String?> getRefreshToken() => _cacheService.getUserRefreshToken();

  @override
  Future<String?> getLanguageCode() => _cacheService.getLanguageCode();

  @override
  Future<bool?> isNotificationEnabled() =>
      _cacheService.isNotificationEnabled();

  @override
  Future<bool?> setNotificationStatus(bool isEnabled) =>
      _cacheService.setNotificationStatus(isEnabled);

  @override
  Future<bool?> isAdTrackingNotificationEnabled() =>
      _cacheService.isAdTrackingNotificationEnabled();

  @override
  Future<bool?> setAdTrackingNotification(bool isEnabled) =>
      _cacheService.setAdTrackingNotification(isEnabled);

  @override
  Future<bool> saveAppleUserData(User appleUserData) {
    return _cacheService.saveAppleUserData(appleUserData.toJson());
  }

  @override
  Future<String?> getAppleUserData() {
    return _cacheService.getAppleUserData();
  }
}
