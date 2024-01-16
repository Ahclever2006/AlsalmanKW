import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  Future<bool> saveUserData(String userData);
  Future<String?> getUserData();

  Future<bool> saveUserIsLoggedIn(bool isLoggedIn);
  Future<bool?> getUserIsLoggedIn();

  Future<bool> saveUserToken(String userToken);
  Future<String?> getUserToken();

  Future<bool> saveUserRefreshToken(String userRefreshToken);
  Future<String?> getUserRefreshToken();

  Future<bool> saveUserTokenExpirationDate(String userTokenExpireDate);
  Future<String?> getUserTokenExpirationDate();

  Future<String?> getLanguageCode();
  Future<void> setLanguageCode(String languageCode);

  Future<void> clearUserData();

  Future<bool?> isNotificationEnabled();
  Future<bool?> isAdTrackingNotificationEnabled();

  Future<bool> setNotificationStatus(bool isEnabled);
  Future<bool> setAdTrackingNotification(bool isEnabled);

  Future<bool> saveAppleUserData(String userData);
  Future<String?> getAppleUserData();
}

class CacheServiceImpl implements CacheService {
  static const _USERDATA = "USER_DATA";
  static const _LOCALE = 'locale';
  static const _TOKEN = "TOKEN";
  static const _REFRESH_TOKEN = "REFRESH_TOKEN";
  static const _TOKEN_EXPIRE_DATE = "TOKEN_EXPIRE_DATE";
  static const _IS_LOGGED_IN = "IS_LOGGED_IN";
  static const _IS_NOTIFICATION_ENABLED = "IS_NOTIFICATION_ENABLED";
  static const _IS_AD_TRACKING_NOTIFICATION_ENABLED =
      "IS_AD_TRACKING_NOTIFICATION_ENABLED";
  static const _APPLE_USER_DATA = "APPLE_USER_DATA";

  @override
  Future<bool> saveUserData(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_USERDATA, userData);
  }

  @override
  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_USERDATA);
  }

  @override
  Future<bool> saveUserIsLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_IS_LOGGED_IN, isLoggedIn);
  }

  @override
  Future<bool?> getUserIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_IS_LOGGED_IN);
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_LOCALE, languageCode);
  }

  @override
  Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LOCALE);
  }

  @override
  Future<bool> saveUserRefreshToken(String userRefreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_REFRESH_TOKEN, userRefreshToken);
  }

  @override
  Future<String?> getUserRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_REFRESH_TOKEN);
  }

  @override
  Future<bool> saveUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_TOKEN, userToken);
  }

  @override
  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TOKEN);
  }

  @override
  Future<bool> saveUserTokenExpirationDate(String userTokenExpireDate) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_TOKEN_EXPIRE_DATE, userTokenExpireDate);
  }

  @override
  Future<String?> getUserTokenExpirationDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TOKEN_EXPIRE_DATE);
  }

  @override
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<bool?> isNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_IS_NOTIFICATION_ENABLED);
  }

  @override
  Future<bool> setNotificationStatus(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_IS_NOTIFICATION_ENABLED, isEnabled);
  }

  @override
  Future<bool?> isAdTrackingNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_IS_AD_TRACKING_NOTIFICATION_ENABLED);
  }

  @override
  Future<bool> setAdTrackingNotification(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_IS_AD_TRACKING_NOTIFICATION_ENABLED, isEnabled);
  }

  @override
  Future<bool> saveAppleUserData(String appleUserData) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_APPLE_USER_DATA, appleUserData);
  }

  @override
  Future<String?> getAppleUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_APPLE_USER_DATA);
  }
}

class CacheServiceImplV2 implements CacheService {
  static const _USERDATA = "USER_DATA";
  static const _LOCALE = 'locale';
  // static const _IS_FIRST_LAUNCH = "IS_FIRST_LAUNCH";
  static const _HAS_RUN_BEFORE = "HAS_RUN_BEFORE";
  final _completer = Completer<FlutterSecureStorage>();

  CacheServiceImplV2() {
    SharedPreferences.getInstance().then((prefs) async {
      if (prefs.getBool(_HAS_RUN_BEFORE) != true) {
        const storage = FlutterSecureStorage();
        await storage.deleteAll();
        await prefs.setBool(_HAS_RUN_BEFORE, true);
        _completer.complete(storage);
      } else
        _completer.complete(const FlutterSecureStorage());
    });
  }

  @override
  Future<bool> saveUserData(String userData) async {
    final storage = await _completer.future;
    await storage.write(key: _USERDATA, value: userData);
    return true;
  }

  @override
  Future<String?> getUserData() async {
    final storage = await _completer.future;

    return await storage.read(key: _USERDATA);
  }

  @override
  Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LOCALE);
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_LOCALE, languageCode);
  }

  // @override
  // Future<bool> getIsFirstLaunch() async {
  //   final storage = await _completer.future;

  //   final isFirstLaunch = await storage.read(key: _IS_FIRST_LAUNCH);
  //   return isFirstLaunch == null ? true : false;
  // }

  // @override
  // Future<void> setIsFirstLaunch(bool isFirstLaunch) async {
  //   final storage = await _completer.future;

  //   await storage.write(key: _IS_FIRST_LAUNCH, value: isFirstLaunch.toString());
  // }

  @override
  Future<bool?> clearUserData() async {
    final storage = await _completer.future;

    await storage.delete(key: _USERDATA);
    return true;
  }

  @override
  Future<String?> getUserRefreshToken() {
    // TODO: implement getUserRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getUserToken() {
    // TODO: implement getUserToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getUserTokenExpirationDate() {
    // TODO: implement getUserTokenExpirationDate
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserRefreshToken(String userToken) {
    // TODO: implement saveUserRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserToken(String userToken) {
    // TODO: implement saveUserToken
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserTokenExpirationDate(String userToken) {
    // TODO: implement saveUserTokenExpirationDate
    throw UnimplementedError();
  }

  @override
  Future<bool?> getUserIsLoggedIn() {
    // TODO: implement getUserIsLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserIsLoggedIn(bool isLoggedIn) {
    // TODO: implement saveUserIsLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<bool?> isNotificationEnabled() {
    // TODO: implement isNotificationEnabled
    throw UnimplementedError();
  }

  @override
  Future<bool> setNotificationStatus(bool isEnabled) {
    // TODO: implement setNotificationStatus
    throw UnimplementedError();
  }

  @override
  Future<bool?> isAdTrackingNotificationEnabled() {
    // TODO: implement isAdTrackingNotificationEnabled
    throw UnimplementedError();
  }

  @override
  Future<bool> setAdTrackingNotification(bool isEnabled) {
    // TODO: implement setAdTrackingNotification
    throw UnimplementedError();
  }

  @override
  Future<String?> getAppleUserData() {
    // TODO: implement getAppleUserData
    throw UnimplementedError();
  }

  @override
  Future<bool> saveAppleUserData(String userData) {
    // TODO: implement saveAppleUserData
    throw UnimplementedError();
  }
}
