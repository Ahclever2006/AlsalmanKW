import 'package:easy_localization/easy_localization.dart';

class Validator {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty)
      return tr("empty_field_not_valid");
    else if (_isInvalidEmail(email))
      return tr("invalid_email_address");
    else
      return null;
  }

  bool _isInvalidEmail(String? email) {
    if (email == null) return true;
    final regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return !regExp.hasMatch(email);
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty)
      return tr("empty_field_not_valid");
    else if (password.length < 6)
      return tr("invalid_password_less_than_characters");
    else
      return null;
  }

  String? validateConfPassword(String? password, String? confPassword) {
    if (password == null || password.isEmpty || password != confPassword)
      return tr("does_not_match_with_password");
    else
      return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty)
      return tr("empty_field_not_valid");
    else if (!RegExp(r"(01)[0-9]{9,9}$").hasMatch(phoneNumber))
      return tr("invalid_phone_number");
    else
      return null;
  }

  String? validateLandLineNumber(String? landLineNumber) {
    if (landLineNumber == null || landLineNumber.isEmpty)
      return null;
    else if (!RegExp(r"[0-9]{7,13}$").hasMatch(landLineNumber))
      return tr("invalid_phone_number");
    else
      return null;
  }

  String? validateUserName(String? userName) {
    if (userName == null || userName.trim().isEmpty)
      return tr("empty_field_not_valid");
    else if (userName.length < 2)
      return tr('must_be_at_least_2');
    else
      return null;
  }

  String? validateBirthDate(String? birthdate) {
    if (birthdate == null || birthdate.isEmpty)
      return tr("empty_field_not_valid");
    else if (_isNotAllowedAge(birthdate))
      return tr("not_allowed_for_users_under_years_old");
    else
      return null;
  }

  bool _isNotAllowedAge(String? birthdate) {
    if (birthdate == null) return true;
    final userBirthDate = DateTime.parse(birthdate);
    final currentDate = DateTime.now();
    final userAge = (currentDate.difference(userBirthDate).inDays) ~/ 365;
    const allowedAge = 18;
    return userAge < allowedAge;
  }

  String? validateEmptyField(String? text) =>
      text == null || text.isEmpty ? tr("empty_field_not_valid") : null;

  String? validateEmptyValue(dynamic value) =>
      value == null ? tr("empty_field_not_valid") : null;
}
