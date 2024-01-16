import '../models/brand_model/brand_model.dart';

import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';

abstract class BrandsRemoteDataSource {
  Future<List<BrandModel>> loadBrands({
    int pageNumber = 1,
    int pageSize = 9,
  });
}

class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  final NetworkService _networkService;

  BrandsRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<BrandModel>> loadBrands({
    int pageNumber = 1,
    int pageSize = 9,
  }) {
    const url = ApiEndPoint.getAllBrandsData;

    // final data = {
    //   "PageNumber": pageNumber,
    //   "PageSize": pageSize,
    // };

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final tags = result['Data'] as List;
      return tags.map((e) => BrandModel.fromMap(e)).toList();
    });
  }
}
