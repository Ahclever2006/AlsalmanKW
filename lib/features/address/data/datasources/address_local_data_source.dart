import '../../../../core/service/cache_service.dart';

abstract class AddressLocalDataSource {
  Future<String?> getLanguageCode();
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  final CacheService _cacheService;

  AddressLocalDataSourceImpl(this._cacheService);

  @override
  Future<String?> getLanguageCode() => _cacheService.getLanguageCode();
}
