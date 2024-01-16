import '../../../../core/service/cache_service.dart';

abstract class IntroLocalDataSource {
  Future<void> setIsFirstLunch();
}

class IntroLocalDataSourceImpl implements IntroLocalDataSource {
  final CacheService _cacheService;

  IntroLocalDataSourceImpl(this._cacheService);

  @override
  Future<void> setIsFirstLunch() => _cacheService.saveIsFirstLunch(false);
}
