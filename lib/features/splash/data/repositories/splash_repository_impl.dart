import '../datasources/splash_local_data_source.dart';

abstract class SplashRepository {
  Future<void> setInitLanguageIfNotSet(String languageCode);
  Future<bool?> getIsFirstLunch();
}

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource _splashLocalDataSource;

  SplashRepositoryImpl(this._splashLocalDataSource);

  @override
  @override
  Future<void> setInitLanguageIfNotSet(String languageCode) async {
    final languageCodeFromCache =
        await _splashLocalDataSource.getLanguageCode();
    if (languageCodeFromCache == null)
      await _splashLocalDataSource.setLanguageCode(languageCode);
  }

  @override
  Future<bool?> getIsFirstLunch() async {
    final isFirstLunch = await _splashLocalDataSource.getIsFirstLunch();

    return isFirstLunch;
  }
}
