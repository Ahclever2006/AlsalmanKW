import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../../../../core/data/models/home_carousal_collection_model.dart';

abstract class JCarousalProductsRemoteDataSource {
  Future<JCarouselsModel> loadProductsData(
    int carousalId, {
    int pageNumber = 1,
    int pageSize = 9,
  });
}

class JCarousalProductsRemoteDataSourceImpl
    implements JCarousalProductsRemoteDataSource {
  final NetworkService _networkService;

  JCarousalProductsRemoteDataSourceImpl(this._networkService);

  @override
  Future<JCarouselsModel> loadProductsData(
    int carousalId, {
    int pageNumber = 1,
    int pageSize = 9,
  }) {
    const url = ApiEndPoint.getCarousels;

    final data = {
      "Ids": [carousalId],
      "IncludeProducts": true,
      "NumberOfItems": 1000,
      "PageNumber": pageNumber,
      "PageSize": pageSize,
    };

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return JCarouselsModel.fromMap(result);
    });
  }
}
