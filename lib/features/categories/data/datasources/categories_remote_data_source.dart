import '../../../../core/data/models/home_categ_model.dart';

import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';

abstract class CategoriesRemoteDataSource {
  Future<HomePageCategoriesModel> loadCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final NetworkService _networkService;

  CategoriesRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomePageCategoriesModel> loadCategories() {
    const url = ApiEndPoint.getMainCategory;
    final params = {"subCategoriesLevel": 1};
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomePageCategoriesModel.fromMap(result);
    });
  }
}
