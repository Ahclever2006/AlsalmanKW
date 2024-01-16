/* import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/current_user.dart';
import 'preferences.dart';

class LocalizationHelper {
  LocalizationHelper._internal(BuildContext context) : _context = context;

  factory LocalizationHelper.of(BuildContext context) =>
      LocalizationHelper._internal(context);

  final BuildContext _context;

  //Only used for resetting language on go back to home page!!
  static BuildContext? _homeContext;

  static Locale? _tempLocale;

  static init(BuildContext context) => _homeContext = context;

  Future<void> changeAppLocale(Locale locale) async {
    final languageCode = locale.languageCode;
    _saveLocalizationCode(languageCode);
    await _setLocale(_context, locale);
  }

  Future<void> changeLocaleTemporary(Locale locale) async {
    _tempLocale = _context.locale;
    await changeAppLocale(locale);
    await _makeSureTheTempLocaleIsSavedLocally(_tempLocale);
  }

  ///This method override the easyLocalization saved locale value
  Future<void> _makeSureTheTempLocaleIsSavedLocally(Locale? locale) async {
    if (locale != null) await Preferences.setLocale(locale.toString());
  }

  ///`true` means the resetting was needed
  Future<bool> resetLocaleIfNeeded() async {
    if (_tempLocale != null) {
      final languageCode = _tempLocale!.languageCode;
      _saveLocalizationCode(languageCode);
      await _setLocale(_homeContext!, _tempLocale!);
      _tempLocale = null;
      return true;
    }
    return false;
  }

  Future<void> _setLocale(BuildContext context, Locale temp) async {
    await context.setLocale(temp);
  }

  void _saveLocalizationCode(String languageCode) {
    CurrentUser().forceUpdateLanguageCode(languageCode);
  }
}
 */
