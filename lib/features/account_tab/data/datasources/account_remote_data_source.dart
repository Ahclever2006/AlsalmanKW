import '/core/service/network_service.dart';

abstract class AccountRemoteDataSource {}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final NetworkService _networkService;

  AccountRemoteDataSourceImpl(this._networkService);

  // @override
  // Future<HomePageCategoriesModel> getHomeCategories() {
  //   const url = ApiEndPoint.getHomeBanner;
  //   return _networkService
  //       .get(url, queryParameters: {"tag": "HomePageSlider2"}).then((response) {
  //     if (response.statusCode != 200) throw RequestException(response.data);
  //     final result = response.data;
  //     final resultStatus = result['IsSuccess'];
  //     if (resultStatus != null && !resultStatus)
  //       throw RequestException(result['Message']);
  //     return HomePageCategoriesModel.fromMap(result);
  //   });
  // }
}
