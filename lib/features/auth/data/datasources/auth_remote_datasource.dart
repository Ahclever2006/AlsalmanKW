import 'dart:io';

import '../../../../api_end_point.dart';
import '../../../../core/data/models/topic_model.dart';
import '../../../../core/enums/otp_for.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';
import '../models/user.dart';
import '../models/user_info.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
  Future<String> changeMobileNumber(String mobile);
  Future<User> loginAsGuest();
  Future<User> refreshToken(String refreshTokenDate);
  Future<UserInfoModel?> getUserData();
  Future<void> editAccountData(UserInfoData newUser);
  Future<String?> getAvatar();
  Future<void> uploadAvatar(File file);
  Future<void> deleteAvatar();
  Future<Topic?> getTopicData(int id);
  Future<void> deleteAccount();
  Future<void> changeUserLanguage(int languageId);

  Future<void> setUserFCMToken(String token, String deviceType);
  Future<void> deleteUserFCMToken();

  Future<void> activateNotification();
  Future<void> deActivateNotification();

  Future<void> activateAdTrackingNotification();
  Future<void> deActivateAdTrackingNotification();

  Future<User> signUp(User user);
  Future<User> externalGoogleLogin(User user);
  Future<User> externalAppleLogin(User user);
  Future<void> forgetPassword(String email);
  Future<void> changePassword(String oldPassword, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<User> login(String email, String password) {
    const url = ApiEndPoint.login;
    final data = {'email': email, 'password': password};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['Message']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return User.fromMap(result['Data']);
    });
  }

  @override
  Future<String> changeMobileNumber(String mobile) {
    const url = ApiEndPoint.login;
    final data = {
      'PhoneNumber': mobile,
      'OtpType': OTPFor.ChangePhoneNumber.index
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['errors']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return result['data']['otp'];
    });
  }

  @override
  Future<UserInfoModel?> getUserData() async {
    const url = ApiEndPoint.userDetails;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return UserInfoModel.fromMap(result);
    });
  }

  @override
  Future<void> editAccountData(UserInfoData newUser) async {
    const url = ApiEndPoint.userDetails;

    final data = {
      "model": {
        "email": newUser.email,
        "first_name": newUser.firstName,
        "last_name": newUser.lastName,
        "gender": newUser.gender,
        "phone": newUser.phone,
        "date_of_birth_day": newUser.dateOfBirthDay,
        "date_of_birth_month": newUser.dateOfBirthMonth,
        "date_of_birth_year": newUser.dateOfBirthYear,
      },
      "form": {
        // "additionalProp1": "string",
        // "additionalProp2": "string",
        // "additionalProp3": "string"
      }
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<Topic?> getTopicData(int id) async {
    final url = '${ApiEndPoint.getTopicData}$id';

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return Topic.fromMap(result['Data']);
    });
  }

  @override
  Future<void> deleteAccount() {
    const url = ApiEndPoint.deleteAccount;

    return _networkService.delete(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<User> loginAsGuest() {
    const url = ApiEndPoint.loginAsGuest;
    final data = {'is_guest': true};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return User.fromMap(result['Data']);
    });
  }

  @override
  Future<User> refreshToken(String refreshTokenDate) {
    const url = ApiEndPoint.loginAsGuest;
    final data = {"refresh_token": refreshTokenDate};

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return User.fromMap(result['Data']);
    });
  }

  @override
  Future<void> changeUserLanguage(int languageId) {
    final url = '${ApiEndPoint.changeUserLanguage}$languageId?returnUrl=/elit';

    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      //return User.fromMap(result['Data']);
    });
  }

  @override
  Future<void> deleteUserFCMToken() {
    const url = ApiEndPoint.notificationToken;

    return _networkService.delete(url, data: {}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> setUserFCMToken(String token, String deviceType) {
    const url = ApiEndPoint.notificationToken;
    final data = {
      "Token": token,
      "Platform": deviceType,
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> activateNotification() {
    const url = ApiEndPoint.activateNotification;

    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> deActivateNotification() {
    const url = ApiEndPoint.deActivateNotification;

    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> activateAdTrackingNotification() {
    const url = ApiEndPoint.changeAdTrackingNotification;

    return _networkService
        .post(url, queryParameters: {"trackingEnabled": true}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> deActivateAdTrackingNotification() {
    const url = ApiEndPoint.changeAdTrackingNotification;

    return _networkService.post(url,
        queryParameters: {"trackingEnabled": false}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<User> externalGoogleLogin(User user) {
    const url = ApiEndPoint.google_login;
    //final data = user.toMap();
    String? device = Platform.isIOS ? "IOS" : "Android";

    return _networkService.post(url, data: {
      "id_token": user.token,
      "device": device,
      "user_info": {}
    }).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);

      return User.fromMap(result['Data']);
    });
  }

  @override
  Future<User> externalAppleLogin(User user) {
    const url = ApiEndPoint.apple_login;
    //final data = user.toMap();
    String? device = Platform.isIOS ? "IOS" : "Android";

    return _networkService.post(url, data: {
      "id_token": user.token,
      "device": device,
      "user_info": {
        "FirstName": user.firstName,
        "LastName": user.lastName,
      }
    }).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['Message']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);

      return User.fromMap(result['Data']);
    });
  }

  @override
  Future<void> forgetPassword(String email) {
    const url = ApiEndPoint.forget_password;
    final data = {'email': email};
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['result'];
      if (resultStatus == "Email not found.")
        throw RequestException(result['result']);
    });
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    const url = ApiEndPoint.change_password;
    final data = {
      "old_password": oldPassword,
      "new_password": newPassword,
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<User> signUp(User user) {
    const url = ApiEndPoint.sign_up;
    final data = {
      "model": user.toMap()..removeWhere((_, v) => v == null),
      "form": {}
    };

    return _networkService.post(url,
        data: data,
        queryParameters: {"returnUrl": "%2F"}).then((response) async {
      if (response.statusCode! > 399)
        throw RequestException(response.data['Message']);

      return await login(user.email!, user.password!);
    });
  }

  @override
  Future<String?> getAvatar() {
    const url = ApiEndPoint.getAvatar;

    return _networkService.get(url).then((response) async {
      if (response.statusCode! > 399)
        throw RequestException(response.data['Message']);

      final result = response.data;

      return result['Data']['avatar_url'];
    });
  }

  @override
  Future<void> deleteAvatar() {
    const url = ApiEndPoint.deleteAvatar;

    return _networkService.delete(url).then((response) async {
      if (response.statusCode! > 399)
        throw RequestException(response.data['Message']);

      // final result = response.data;

      // return result['Data']['avatar_url'];
    });
  }

  @override
  Future<void> uploadAvatar(File file) async {
    const url = ApiEndPoint.uploadAvatar;

    String? fileName = file.path.split('/').last;

    // final headers = await _networkService.getDefaultHeaders();

    // headers['Keep-Alive'] = 'true';
    // headers['content-type'] = 'application/json';

    final params = {'fileName': fileName, 'contentType': 'jpeg'};

    return _networkService
        .post(
      url,
      queryParameters: params,
      // headers: headers,
      data: file.readAsBytesSync().toList(),
    )
        .then((response) async {
      if (response.statusCode! > 399)
        throw RequestException(response.data['Message']);
    });
  }
}
