import '../../../../core/service/cache_service.dart';

abstract class SplashLocalDataSource {
  Future<String?> getLanguageCode();

  Future<void> setLanguageCode(String languageCode);
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final CacheService _cacheService;

  SplashLocalDataSourceImpl(this._cacheService);

  @override
  Future<String?> getLanguageCode() => _cacheService.getLanguageCode();

  @override
  Future<void> setLanguageCode(String languageCode) =>
      _cacheService.setLanguageCode(languageCode);
}
