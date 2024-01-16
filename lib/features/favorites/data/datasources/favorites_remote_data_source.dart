import '../../../../api_end_point.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';
import '../models/favorite_product_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<FavoriteProductModel>> getFavorites({
    int pageNumber = 1,
    int pageSize = 9,
  });

  Future<void> addToFav(String id, Map<String, dynamic> data);
  Future<void> removeFromFav(String id);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final NetworkService _networkService;
  FavoritesRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<FavoriteProductModel>> getFavorites({
    int pageNumber = 1,
    int pageSize = 9,
  }) {
    const url = ApiEndPoint.getFavorites;

    final params = {'PageNumber': pageNumber, 'PageSize': pageSize};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (![200, 201].contains(response.statusCode))
        throw RequestException(response.data);
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final data = result['Data'] as List;
      return data.map((e) => FavoriteProductModel.fromMap(e)).toList();
    });
  }

  @override
  Future<void> addToFav(String id, Map<String, dynamic> data) {
    const url = ApiEndPoint.ADD_TO_WISHLIST;
    final params = {'id': id};
    return _networkService
        .post(url, data: data, queryParameters: params
            // {'shoppingCartType': 'Wishlist'},
            )
        .then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }

  @override
  Future<void> removeFromFav(String id) {
    const url = ApiEndPoint.REMOVE_FROM_WISHLIST;
    final params = {'id': id};
    return _networkService
        .delete(url, queryParameters: params)
        .then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }
}
