import 'dart:developer';
import 'dart:io';

import '../../../../../core/exceptions/social_media_login_canceled_exception.dart';
import '../../../data/models/user_info.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';

import '../../../data/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState());

  final AuthRepository _authRepository;

  Future<void> init() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final isLoggedIn = await _authRepository.isLoggedIn();
      final isNotificationEnabled =
          await _authRepository.isNotificationEnabled();

      final isAdTrackingNotificationEnabled =
          await _authRepository.isAdTrackingNotificationEnabled();

      bool? isUserHaveToken;
      String? tokenExpirationDate;
      if (isLoggedIn == null || isLoggedIn == false) {
        isUserHaveToken = await _authRepository.isUserHaveToken();
        if (isUserHaveToken == true) {
          tokenExpirationDate = await _authRepository.getTokenExpirationDate();
        }
      } else {
        tokenExpirationDate = await _authRepository.getTokenExpirationDate();
      }

      emit(isLoggedIn == null
          ? state.copyWith(
              status: AuthStateStatus.guest,
              isNotificationEnabled: isNotificationEnabled,
              isAdTrackingNotificationEnabled: isAdTrackingNotificationEnabled,
              isUserHaveToken: isUserHaveToken,
              tokenExpirationDate: tokenExpirationDate,
              isUserLoggedIn: false)
          : state.copyWith(
              status:
                  isLoggedIn ? AuthStateStatus.loggedIn : AuthStateStatus.guest,
              isUserHaveToken: true,
              isNotificationEnabled: isNotificationEnabled,
              isAdTrackingNotificationEnabled: isAdTrackingNotificationEnabled,
              tokenExpirationDate: tokenExpirationDate,
              isUserLoggedIn: isLoggedIn));

      // if (user != null)
      //   FirebaseCrashlytics.instance
      //       .setUserIdentifier((user.id ?? '') + (user.fullName ?? ''));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.login(email, password);

      await _authRepository.changeUserLanguage();
      await _authRepository.setUserFCMToken();
      await _authRepository.activateAdTrackingNotification();
      await _authRepository.activateNotification();

      // FirebaseCrashlytics.instance.setUserIdentifier(
      //     (user.customerId.toString()) + (user.firstName ?? ''));

      emit(state.copyWith(
        status: AuthStateStatus.authSuccess,
        isNotificationEnabled: true,
        isAdTrackingNotificationEnabled: true,
        isUserLoggedIn: true,
        isUserHaveToken: true,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signUp(User user) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.signUp(user);

      await _authRepository.changeUserLanguage();
      await _authRepository.setUserFCMToken();
      await _authRepository.activateAdTrackingNotification();
      await _authRepository.activateNotification();

      emit(state.copyWith(
        status: AuthStateStatus.authRegisterSuccess,
        isNotificationEnabled: true,
        isAdTrackingNotificationEnabled: true,
        isUserLoggedIn: true,
        isUserHaveToken: true,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginWithGoogle(
      Future<String?> Function() onEmailRequiredError) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.loginWithGoogle(onEmailRequiredError);

      await _authRepository.changeUserLanguage();
      await _authRepository.setUserFCMToken();
      await _authRepository.activateAdTrackingNotification();
      await _authRepository.activateNotification();

      emit(state.copyWith(
        status: AuthStateStatus.authSuccess,
        //user: user,
        isNotificationEnabled: true,
        isAdTrackingNotificationEnabled: true,
        isUserLoggedIn: true,
        isUserHaveToken: true,
      ));
    } on SocialLoginCanceledException catch (e) {
      log(e.toString());
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginWithApple(
      Future<String?> Function() onEmailRequiredError) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.loginWithApple(onEmailRequiredError);

      await _authRepository.changeUserLanguage();
      await _authRepository.setUserFCMToken();
      await _authRepository.activateAdTrackingNotification();
      await _authRepository.activateNotification();
      emit(state.copyWith(
        status: AuthStateStatus.authSuccess,
        //user: user,
        isNotificationEnabled: true,
        isAdTrackingNotificationEnabled: true,
        isUserLoggedIn: true,
        isUserHaveToken: true,
      ));
    } on SocialLoginCanceledException catch (e) {
      log(e.toString());
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginAsGuest() async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.loginAsGuest();

      await _authRepository.setUserFCMToken();
      await _authRepository.changeUserLanguage();
      await _authRepository.activateAdTrackingNotification();
      await _authRepository.activateNotification();

      emit(state.copyWith(
        status: AuthStateStatus.guest,
        isNotificationEnabled: true,
        isUserHaveToken: true,
        isAdTrackingNotificationEnabled: false,
        isUserLoggedIn: false,
      ));
      // FirebaseCrashlytics.instance.setUserIdentifier(
      //     (user.customerId.toString()) + (user.firstName ?? ''));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshToken() async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.refreshToken();

      final isLoggedIn = await _authRepository.isLoggedIn();
      String? tokenExpirationDate =
          await _authRepository.getTokenExpirationDate();

      emit(state.copyWith(
        status: isLoggedIn == true
            ? AuthStateStatus.loggedIn
            : AuthStateStatus.guest,
        isUserLoggedIn: isLoggedIn,
        tokenExpirationDate: tokenExpirationDate,
      ));
      // FirebaseCrashlytics.instance.setUserIdentifier(
      //     (user.customerId.toString()) + (user.firstName ?? ''));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      loginAsGuest();
      // emit(state.copyWith(
      //     status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getUserData() async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final userInfo = await _authRepository.getUserData();

      emit(state.copyWith(
        status: AuthStateStatus.userInfoLoaded,
        userInfo: userInfo,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changeUserLanguage() async {
    try {
      await _authRepository.changeUserLanguage();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> editAccountData(UserInfoData editedUser,
      {bool ignoreCheckEquality = false}) async {
    var oldUser = state.userInfo?.data;
    final isEqual = _checkUserEquality(
        newUser: editedUser, oldUser: oldUser ?? UserInfoData());
    if (isEqual && !ignoreCheckEquality)
      return false;
    else
      try {
        await _authRepository
            .editAccountData(editedUser.copyWith(email: oldUser?.email));

        emit(state.copyWith(status: AuthStateStatus.loggedIn));
        return true;
      } on RedundantRequestException catch (e) {
        log(e.toString());
        return false;
      } catch (e) {
        emit(state.copyWith(
            status: AuthStateStatus.error, errorMessage: e.toString()));
        return false;
      }
  }

  Future<void> getAvatar() async {
    try {
      final userAvatar = await _authRepository.getAvatar();

      emit(state.copyWith(
          status: AuthStateStatus.loggedIn, userAvatar: userAvatar));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _deleteAvatar() async {
    try {
      await _authRepository.deleteAvatar();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> uploadAvatar(String filePath) async {
    try {
      await _deleteAvatar();
      await _authRepository.uploadAvatar(File(filePath));
      await getAvatar();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> logOut() async {
    //if (state.user == null) return;
    emit(
        state.copyWith(status: AuthStateStatus.loading, isUserLoggedIn: false));
    try {
      await _authRepository.deleteUserFCMToken();
      await _authRepository.logout();
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  bool _checkUserEquality(
      {required UserInfoData newUser, required UserInfoData oldUser}) {
    if (newUser.firstName == oldUser.firstName &&
        newUser.lastName == oldUser.lastName &&
        newUser.gender == oldUser.gender &&
        newUser.dateOfBirthDay == oldUser.dateOfBirthDay &&
        newUser.dateOfBirthYear == oldUser.dateOfBirthYear &&
        newUser.dateOfBirthMonth == oldUser.dateOfBirthMonth)
      return true;
    else
      return false;
  }

  Future<void> deleteAccount() async {
    emit(
        state.copyWith(status: AuthStateStatus.loading, isUserLoggedIn: false));
    try {
      await _authRepository.deleteAccount();
      emit(const AuthState(status: AuthStateStatus.guest));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changeNotificationStatus(bool isEnabled) async {
    try {
      await _authRepository.changeNotificationStatus(isEnabled);
      emit(state.copyWith(
          status: state.isLoggedIn == true
              ? AuthStateStatus.loggedIn
              : AuthStateStatus.guest,
          isNotificationEnabled: isEnabled));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changeAdTrackingNotificationStatus(bool isEnabled) async {
    try {
      await _authRepository.changeAdTrackingNotificationStatus(isEnabled);
      emit(state.copyWith(
          status: state.isLoggedIn == true
              ? AuthStateStatus.loggedIn
              : AuthStateStatus.guest,
          isAdTrackingNotificationEnabled: isEnabled));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.forgetPassword(email);
      emit(state.copyWith(status: AuthStateStatus.authSuccess));
    } on SocialLoginCanceledException catch (e) {
      log(e.toString());
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }

  // void reset() => emit(
  //     const AuthState(status: AuthStateStatus.guest, isUserLoggedIn: false));

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      await _authRepository.changePassword(oldPassword, newPassword);
      emit(state.copyWith(status: AuthStateStatus.changePasswordSuccess));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: AuthStateStatus.error, errorMessage: e.toString()));
    }
  }
}
