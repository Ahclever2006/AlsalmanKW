import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../../../../core/data/models/home_section_product_model.dart';

abstract class BrandProductsRemoteDataSource {
  Future<HomeSectionProductModel> loadBrandProductsData({
    required int brandId,
    int pageNumber = 1,
    int pageSize = 9,
  });
}

class BrandProductsRemoteDataSourceImpl
    implements BrandProductsRemoteDataSource {
  final NetworkService _networkService;

  BrandProductsRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomeSectionProductModel> loadBrandProductsData({
    required int brandId,
    int pageNumber = 1,
    int pageSize = 9,
  }) {
    const url = ApiEndPoint.getProducts;

    final data = {
      //"SubCategories": true,
      "ManufacturerIds": [brandId],
      "PageNumber": pageNumber,
      "IncludeGiftCard": true,
      "PageSize": pageSize,
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
