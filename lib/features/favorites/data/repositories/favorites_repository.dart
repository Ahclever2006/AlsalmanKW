import '../datasources/favorites_remote_data_source.dart';
import '../models/favorite_product_model.dart';

abstract class FavoritesRepository {
  Future<List<FavoriteProductModel>> getFavorites({
    int pageNumber = 1,
    int pageSize = 9,
  });

  Future<void> addToFav(String id, Map<String, dynamic> data);
  Future<void> removeFromFav(String id);
  Future<void> removeAllFav();
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
  }) : _remoteDataSource = favoritesRemoteDataSource;

  @override
  Future<List<FavoriteProductModel>> getFavorites({
    int pageNumber = 1,
    int pageSize = 9,
  }) =>
      _remoteDataSource.getFavorites(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

  @override
  Future<void> addToFav(String id, Map<String, dynamic> data) =>
      _remoteDataSource.addToFav(id, data);

  @override
  Future<void> removeFromFav(String id) => _remoteDataSource.removeFromFav(id);
  
  @override
  Future<void> removeAllFav() => _remoteDataSource.removeAllFav();
}
