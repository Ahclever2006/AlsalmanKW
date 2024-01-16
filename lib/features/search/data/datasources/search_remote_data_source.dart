import '../../../../api_end_point.dart';
import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';

abstract class SearchRemoteDataSource {
  Future<HomeSectionProductModel> loadSearchProductsData({
    int sort = 0,
    int pageNumber = 1,
    int pageSize = 9,
    required String searchText,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final NetworkService _networkService;
  SearchRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomeSectionProductModel> loadSearchProductsData({
    int sort = 0,
    int pageNumber = 1,
    int pageSize = 9,
    required String searchText,
  }) {
    const url = ApiEndPoint.getProducts;

    final data = {
      "SubCategories": true,
      "OrderBy": sort,
      "PageNumber": pageNumber,
      "PageSize": pageSize,
      "IncludeGiftCard": true,
      'KeyWord': searchText
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeSectionProductModel.fromMap(result);
    });
  }
}
