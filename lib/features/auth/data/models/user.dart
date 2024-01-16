import 'dart:convert';

class User {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? password;
  final String? dateOfBirthDay;
  final String? dateOfBirthMonth;
  final String? dateOfBirthYear;
  final String? phone;
  final String? token;
  final String? refreshToken;
  final DateTime? expireDate;
  final int? customerId;
  final int? provider;
  final int? deviceType;
  final String? mobileAppId;
  final bool? mobileNotConfirmed;
  User({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.dateOfBirthDay,
    this.dateOfBirthMonth,
    this.dateOfBirthYear,
    this.phone,
    this.token,
    this.refreshToken,
    this.expireDate,
    this.customerId,
    this.provider,
    this.deviceType,
    this.mobileAppId,
    this.mobileNotConfirmed,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? dateOfBirthDay,
    String? dateOfBirthMonth,
    String? dateOfBirthYear,
    String? phone,
    String? token,
    String? refreshToken,
    DateTime? expireDate,
    int? customerId,
    int? provider,
    int? deviceType,
    String? mobileAppId,
    bool? mobileNotConfirmed,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirthDay: dateOfBirthDay ?? this.dateOfBirthDay,
      dateOfBirthMonth: dateOfBirthMonth ?? this.dateOfBirthMonth,
      dateOfBirthYear: dateOfBirthYear ?? this.dateOfBirthYear,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expireDate: expireDate ?? this.expireDate,
      customerId: customerId ?? this.customerId,
      provider: provider ?? this.provider,
      deviceType: deviceType ?? this.deviceType,
      mobileAppId: mobileAppId ?? this.mobileAppId,
      mobileNotConfirmed: mobileNotConfirmed ?? this.mobileNotConfirmed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password,
      'date_of_birth_day': dateOfBirthDay,
      'date_of_birth_month': dateOfBirthMonth,
      'date_of_birth_year': dateOfBirthYear,
      'phone': phone,
      'token': token,
      'refresh_token': refreshToken,
      'expire_date': expireDate?.millisecondsSinceEpoch,
      'customer_id': customerId,
      'provider': provider,
      'deviceType': deviceType,
      'mobileAppId': mobileAppId,
      'mobileNotConfirmed': mobileNotConfirmed,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['first_name'],
      lastName: map['last_name'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      dateOfBirthDay: map['date_of_birth_day'],
      dateOfBirthMonth: map['date_of_birth_month'],
      dateOfBirthYear: map['date_of_birth_year'],
      phone: map['phone'],
      token: map['token'],
      refreshToken: map['refresh_token'],
      expireDate: map['expire_date'] != null
          ? DateTime.parse(map['expire_date'].replaceAll('/', '-'))
          : null,
      customerId: map['customer_id']?.toInt(),
      provider: map['provider']?.toInt(),
      deviceType: map['deviceType']?.toInt(),
      mobileAppId: map['mobileAppId'],
      mobileNotConfirmed: map['mobileNotConfirmed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(first_name: $firstName, last_name: $lastName, username: $username, email: $email, password: $password, date_of_birth_day: $dateOfBirthDay, date_of_birth_month: $dateOfBirthMonth, date_of_birth_year: $dateOfBirthYear, phone: $phone, token: $token, refresh_token: $refreshToken, expire_date: $expireDate, customer_id: $customerId, provider: $provider, deviceType: $deviceType, mobileAppId: $mobileAppId, mobileNotConfirmed: $mobileNotConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.dateOfBirthDay == dateOfBirthDay &&
        other.dateOfBirthMonth == dateOfBirthMonth &&
        other.dateOfBirthYear == dateOfBirthYear &&
        other.phone == phone &&
        other.token == token &&
        other.refreshToken == refreshToken &&
        other.expireDate == expireDate &&
        other.customerId == customerId &&
        other.provider == provider &&
        other.deviceType == deviceType &&
        other.mobileAppId == mobileAppId &&
        other.mobileNotConfirmed == mobileNotConfirmed;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        dateOfBirthDay.hashCode ^
        dateOfBirthMonth.hashCode ^
        dateOfBirthYear.hashCode ^
        phone.hashCode ^
        token.hashCode ^
        refreshToken.hashCode ^
        expireDate.hashCode ^
        customerId.hashCode ^
        provider.hashCode ^
        deviceType.hashCode ^
        mobileAppId.hashCode ^
        mobileNotConfirmed.hashCode;
  }
}
