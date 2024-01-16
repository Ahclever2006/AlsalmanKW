import '../../../../core/data/models/banner_model.dart';

import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';

abstract class IntroRemoteDataSource {
  Future<HomeBannerModel> getIntroBanners();
}

class IntroRemoteDataSourceImpl implements IntroRemoteDataSource {
  final NetworkService _networkService;

  IntroRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomeBannerModel> getIntroBanners() {
    const url = ApiEndPoint.getLandingBanner;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }
}
