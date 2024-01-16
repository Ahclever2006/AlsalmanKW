import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/data/models/home_carousal_collection_model.dart';
import '../../../../core/data/models/home_categ_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeBannerModel> getHomeBanners();
  Future<HomeBannerModel> getCarouselFirstBanners();
  Future<HomeBannerModel> getCarouselSecondBanners();
  Future<HomeBannerModel> getCarouselThirdBanners();
  Future<HomeBannerModel> getCategoriesBanners();
  Future<HomePageCategoriesModel> getHomeCategories();
  Future<JCarouselsModel> getHomeCarousalSection();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService _networkService;

  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomeBannerModel> getHomeBanners() {
    const url = ApiEndPoint.getHomeBanner;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }

  @override
  Future<HomeBannerModel> getCarouselFirstBanners() {
    const url = ApiEndPoint.getCarouselFirstBanner;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }

  @override
  Future<HomeBannerModel> getCarouselSecondBanners() {
    const url = ApiEndPoint.getCarouselSecondBanner;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }

  @override
  Future<HomeBannerModel> getCarouselThirdBanners() {
    const url = ApiEndPoint.getCarouselThirdBanner;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }

  @override
  Future<HomeBannerModel> getCategoriesBanners() {
    const url = ApiEndPoint.getCategoriesBanner;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }

  @override
  Future<HomePageCategoriesModel> getHomeCategories() {
    const url = ApiEndPoint.getHomeCategories;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomePageCategoriesModel.fromMap(result);
    });
  }

  @override
  Future<JCarouselsModel> getHomeCarousalSection() {
    const url = ApiEndPoint.getCarousels;
    final data = {
      // "Ids": [],
      // "Names": [],
      "IncludeProducts": true,
      "NumberOfItems": 10,
      // "CurrentProductId": 0,
      // "CurrentCategoryId": 240,
      // "CurrentManufacturerId": 0
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
