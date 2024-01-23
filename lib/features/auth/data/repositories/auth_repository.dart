import 'dart:io';

import '../../../../core/data/datasources/device_type_data_source.dart';
import '../../../../core/data/datasources/external_login_data_source.dart';
import '../../../../core/data/datasources/notification_data_source.dart';
import '../../../../core/data/models/topic_model.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user.dart';
import '../models/user_info.dart';

abstract class AuthRepository {
  Future<bool?> isLoggedIn();
  Future<bool?> isUserHaveToken();
  Future<bool?> isNotificationEnabled();
  Future<bool?> isAdTrackingNotificationEnabled();
  Future<String?> getTokenExpirationDate();
  Future<void> login(String email, String password);
  Future<User> loginAsGuest();
  Future<User> refreshToken();
  Future<void> logout();
  Future<UserInfoModel?> getUserData();
  Future<void> editAccountData(UserInfoData newUser);
  Future<String?> getAvatar();
  Future<void> uploadAvatar(File file);
  Future<void> deleteAvatar();
  Future<Topic?> getTopicsData(int id);
  Future<void> deleteAccount();
  Future<void> changeUserLanguage();
  Future<void> setUserFCMToken();
  Future<void> deleteUserFCMToken();

  Future<void> activateNotification();
  Future<void> deActivateNotification();

  Future<void> activateAdTrackingNotification();
  Future<void> deActivateAdTrackingNotification();

  Future<void> changeNotificationStatus(bool isEnabled);
  Future<void> changeAdTrackingNotificationStatus(bool isEnabled);

  Future<User> signUp(User user);
  Future<void> loginWithGoogle(Future<String?> Function() onEmailRequiredError);
  Future<void> loginWithApple(Future<String?> Function() onEmailRequiredError);
  Future<void> forgetPassword(String email);
  Future<void> changePassword(String oldPassword, String newPassword);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final ExternalLoginDataSource _googleExternalDataSource;
  final ExternalLoginDataSource _appleExternalDataSource;
  final NotificationDataSource _notificationDataSource;
  final DeviceTypeDataSource _deviceTypeDataSource;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._appleExternalDataSource,
    this._googleExternalDataSource,
    this._deviceTypeDataSource,
    this._notificationDataSource,
  );
  @override
  Future<bool?> isLoggedIn() => _localDataSource.isLoggedIn();

  @override
  Future<bool?> isUserHaveToken() async {
    final token = await _localDataSource.isTokenCreated();

    return token != null;
  }

  @override
  Future<String?> getTokenExpirationDate() =>
      _localDataSource.getTokenExpirationDate();

  @override
  Future<void> login(String email, String password) async {
    final resultUser = await _remoteDataSource.login(email, password);
    await _localDataSource.saveUserData(resultUser.copyWith(provider: 1));
    await _localDataSource.saveIsLoggedIn(true);
    await _localDataSource.saveUserToken(resultUser.token!);
    await _localDataSource.saveUserRefreshToken(resultUser.refreshToken!);
    await _localDataSource
        .saveUserTokenExpirationDate(resultUser.expireDate!.toIso8601String());

    // final notificationToken =
    //     await _notificationDataSource.getNotificationMobileAppId();
    // final deviceType = _deviceTypeDataSource.getDeviceType();
    // _remoteDataSource.setUserFCMToken(notificationToken!, deviceType);
  }

  @override
  Future<User> loginAsGuest() async {
    final resultUser = await _remoteDataSource.loginAsGuest();

    await _localDataSource.saveUserData(resultUser);

    await _localDataSource.saveUserToken(resultUser.token!);
    await _localDataSource.saveIsLoggedIn(false);
    await _localDataSource.saveUserRefreshToken(resultUser.refreshToken!);
    await _localDataSource
        .saveUserTokenExpirationDate(resultUser.expireDate!.toIso8601String());

    return resultUser;
  }

  @override
  Future<User> refreshToken() async {
    late final User resultUser;

    final isLoggedIn = await _localDataSource.isLoggedIn();
    if (isLoggedIn != true) {
      resultUser = await _remoteDataSource.loginAsGuest();
    } else {
      final refreshToken = await _localDataSource.getRefreshToken();

      resultUser = await _remoteDataSource.refreshToken(refreshToken!);
    }

    await _localDataSource.saveUserData(resultUser);

    await _localDataSource.saveUserToken(resultUser.token!);
    await _localDataSource.saveUserRefreshToken(resultUser.refreshToken!);
    await _localDataSource
        .saveUserTokenExpirationDate(resultUser.expireDate!.toIso8601String());

    return resultUser;
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      _localDataSource.clearUserData(),
      _notificationDataSource.cancelNotification(),
    ]);
  }

  @override
  Future<UserInfoModel?> getUserData() => _remoteDataSource.getUserData();

  @override
  Future<void> editAccountData(UserInfoData newUser) =>
      _remoteDataSource.editAccountData(newUser);

  @override
  Future<Topic?> getTopicsData(int id) => _remoteDataSource.getTopicData(id);

  @override
  Future<void> deleteAccount() => Future.wait([
        _remoteDataSource.deleteAccount(),
        _localDataSource.clearUserData(),
        _notificationDataSource.cancelNotification(),
      ]).then(
        (value) => loginAsGuest(),
      );

  @override
  Future<void> changeUserLanguage() async {
    final languageCode = await _localDataSource.getLanguageCode();
    return _remoteDataSource.changeUserLanguage(languageCode == 'ar' ? 2 : 1);
  }

  @override
  Future<void> deleteUserFCMToken() async {
    await _localDataSource.setNotificationStatus(false);
    return _remoteDataSource.deleteUserFCMToken();
  }

  @override
  Future<void> setUserFCMToken() async {
    final deviceType = _deviceTypeDataSource.getDeviceType();
    final mobileAppId =
        await _notificationDataSource.getNotificationMobileAppId();
    await _localDataSource.setNotificationStatus(true);
    return _remoteDataSource.setUserFCMToken(mobileAppId ?? '', deviceType);
  }

  @override
  Future<bool?> isNotificationEnabled() =>
      _localDataSource.isNotificationEnabled();

  @override
  Future<void> changeNotificationStatus(bool isEnabled) async {
    if (isEnabled)
      await activateNotification();
    else
      await deActivateNotification();
  }

  @override
  Future<void> activateNotification() async {
    await _localDataSource.setNotificationStatus(true);
    return _remoteDataSource.activateNotification();
  }

  @override
  Future<void> deActivateNotification() async {
    await _localDataSource.setNotificationStatus(false);
    return _remoteDataSource.deActivateNotification();
  }

  @override
  Future<bool?> isAdTrackingNotificationEnabled() =>
      _localDataSource.isAdTrackingNotificationEnabled();

  @override
  Future<void> changeAdTrackingNotificationStatus(bool isEnabled) async {
    if (isEnabled)
      await activateAdTrackingNotification();
    else
      await deActivateAdTrackingNotification();
  }

  @override
  Future<void> activateAdTrackingNotification() async {
    await _localDataSource.setAdTrackingNotification(true);
    return _remoteDataSource.activateAdTrackingNotification();
  }

  @override
  Future<void> deActivateAdTrackingNotification() async {
    await _localDataSource.setAdTrackingNotification(false);
    return _remoteDataSource.deActivateAdTrackingNotification();
  }

  @override
  Future<void> loginWithApple(
      Future<String?> Function() onEmailRequiredError) async {
    late User newAppleUser;
    try {
      final appleUser = await _appleExternalDataSource.login();
      final savedAppleUserData = await _localDataSource.getAppleUserData();

      newAppleUser = savedAppleUserData == null
          ? appleUser
          : User.fromJson(savedAppleUserData).copyWith(token: appleUser.token);
      await _localDataSource.saveAppleUserData(newAppleUser);
      await _externalAppleLogin(newAppleUser);
    } on RequestException catch (e) {
      if (e.message.contains('Email Required')) {
        final email = await onEmailRequiredError();
        if (email == null) rethrow;
        await _externalAppleLogin(newAppleUser.copyWith(email: email));
      } else
        rethrow;
    }
  }

  @override
  Future<void> loginWithGoogle(
      Future<String?> Function() onEmailRequiredError) async {
    late User externalUser;
    try {
      externalUser = await _googleExternalDataSource.login();
      await _externalGoogleLogin(externalUser);
    } on RequestException catch (e) {
      if (e.message.contains('Email Required')) {
        final email = await onEmailRequiredError();
        if (email == null) rethrow;
        await _externalGoogleLogin(externalUser.copyWith(email: email));
      } else
        rethrow;
    }
  }

  Future<User> _externalGoogleLogin(User externalUser) async {
    final resultUser =
        await _remoteDataSource.externalGoogleLogin(externalUser);
    await _localDataSource.saveUserData(resultUser.copyWith(provider: 2));
    await _localDataSource.saveIsLoggedIn(true);
    await _localDataSource.saveUserToken(resultUser.token!);
    await _localDataSource.saveUserRefreshToken(resultUser.refreshToken!);
    await _localDataSource
        .saveUserTokenExpirationDate(resultUser.expireDate!.toIso8601String());

    return resultUser;
  }

  Future<User> _externalAppleLogin(User externalUser) async {
    final resultUser = await _remoteDataSource.externalAppleLogin(externalUser);
    await _localDataSource.saveUserData(resultUser.copyWith(provider: 3));
    await _localDataSource.saveIsLoggedIn(true);
    await _localDataSource.saveUserToken(resultUser.token!);
    await _localDataSource.saveUserRefreshToken(resultUser.refreshToken!);
    await _localDataSource
        .saveUserTokenExpirationDate(resultUser.expireDate!.toIso8601String());

    return resultUser;
  }

  @override
  Future<void> forgetPassword(String email) =>
      _remoteDataSource.forgetPassword(email);

  @override
  Future<void> changePassword(String oldPassword, String newPassword) =>
      _remoteDataSource.changePassword(oldPassword, newPassword);

  @override
  Future<User> signUp(User user) async {
    final resultUser = await _remoteDataSource.signUp(user);
    await _localDataSource.saveUserData(resultUser.copyWith(provider: 1));
    await _localDataSource.saveIsLoggedIn(true);
    await _localDataSource.saveUserToken(resultUser.token!);
    await _localDataSource.saveUserRefreshToken(resultUser.refreshToken!);
    await _localDataSource
        .saveUserTokenExpirationDate(resultUser.expireDate!.toIso8601String());

    return resultUser;
  }

  @override
  Future<String?> getAvatar() => _remoteDataSource.getAvatar();

  @override
  Future<void> deleteAvatar() => _remoteDataSource.deleteAvatar();

  @override
  Future<void> uploadAvatar(File file) => _remoteDataSource.uploadAvatar(file);
}
