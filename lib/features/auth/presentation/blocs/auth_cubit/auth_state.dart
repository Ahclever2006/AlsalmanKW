part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  loggedIn,
  userInfoLoaded,
  userLanguageChanged,
  guest,
  error,
  forgetPasswordSent,
  changePasswordSuccess,
  authSuccess,
  authRegisterSuccess,
  newPasswordSet,
}

extension AuthStateX on AuthState {
  bool get isInitial => status == AuthStateStatus.initial;
  bool get isLoading => status == AuthStateStatus.loading;
  bool get isLoggedIn => status == AuthStateStatus.loggedIn;
  bool get isUserInfoLoaded => status == AuthStateStatus.userInfoLoaded;
  bool get isUserLanguageChanged =>
      status == AuthStateStatus.userLanguageChanged;
  bool get isGuest => status == AuthStateStatus.guest;
  bool get isError => status == AuthStateStatus.error;
  bool get isForgetPasswordSent => status == AuthStateStatus.forgetPasswordSent;
  bool get isChangePasswordSuccess =>
      status == AuthStateStatus.changePasswordSuccess;
  bool get isAuthSuccess => status == AuthStateStatus.authSuccess;
  bool get isAuthRegisterSuccess =>
      status == AuthStateStatus.authRegisterSuccess;
  bool get isNewPasswordSet => status == AuthStateStatus.newPasswordSet;
}

@immutable
class AuthState {
  final UserInfoModel? userInfo;
  final bool isUserLoggedIn;
  final bool isNotificationEnabled;
  final bool isAdTrackingNotificationEnabled;
  final bool isUserHaveToken;
  final String? tokenExpirationDate;
  final String? userAvatar;
  final AuthStateStatus status;
  final String? errorMessage;

  const AuthState({
    this.userInfo,
    this.isUserLoggedIn = false,
    this.isNotificationEnabled = false,
    this.isAdTrackingNotificationEnabled = false,
    this.isUserHaveToken = false,
    this.tokenExpirationDate,
    this.userAvatar,
    this.status = AuthStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AuthState).isUserLoggedIn == isUserLoggedIn &&
        other.userInfo == userInfo &&
        other.isNotificationEnabled == isNotificationEnabled &&
        other.isAdTrackingNotificationEnabled ==
            isAdTrackingNotificationEnabled &&
        other.isUserHaveToken == isUserHaveToken &&
        other.userAvatar == userAvatar &&
        other.tokenExpirationDate == tokenExpirationDate &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      userInfo.hashCode ^
      isUserLoggedIn.hashCode ^
      isNotificationEnabled.hashCode ^
      isAdTrackingNotificationEnabled.hashCode ^
      isUserHaveToken.hashCode ^
      userAvatar.hashCode ^
      tokenExpirationDate.hashCode ^
      status.hashCode ^
      errorMessage.hashCode;

  AuthState copyWith({
    UserInfoModel? userInfo,
    bool? isUserLoggedIn,
    bool? isUserHaveToken,
    bool? isNotificationEnabled,
    bool? isAdTrackingNotificationEnabled,
    AuthStateStatus? status,
    String? tokenExpirationDate,
    String? userAvatar,
    String? errorMessage,
  }) {
    return AuthState(
      userInfo: userInfo ?? this.userInfo,
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      isAdTrackingNotificationEnabled: isAdTrackingNotificationEnabled ??
          this.isAdTrackingNotificationEnabled,
      isUserHaveToken: isUserHaveToken ?? this.isUserHaveToken,
      status: status ?? this.status,
      tokenExpirationDate: tokenExpirationDate ?? this.tokenExpirationDate,
      userAvatar: userAvatar ?? this.userAvatar,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
