import '../../../../core/data/models/banner_model.dart';
import '../../../../core/data/models/home_carousal_collection_model.dart';
import '../../../../core/data/models/home_categ_model.dart';
import '../datasources/home_remote_data_source.dart';

abstract class HomeRepository {
  Future<HomeBannerModel> getHomeBanners();
  Future<HomeBannerModel> getCarouselFirstBanners();
  Future<HomeBannerModel> getCarouselSecondBanners();
  Future<HomeBannerModel> getCarouselThirdBanners();
  Future<HomePageCategoriesModel> getHomeCategories();
  Future<JCarouselsModel> getHomeCarousalSection();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<HomeBannerModel> getHomeBanners() =>
      _homeRemoteDataSource.getHomeBanners();
  @override
  Future<HomeBannerModel> getCarouselFirstBanners() =>
      _homeRemoteDataSource.getCarouselFirstBanners();
  @override
  Future<HomeBannerModel> getCarouselSecondBanners() =>
      _homeRemoteDataSource.getCarouselSecondBanners();
  @override
  Future<HomeBannerModel> getCarouselThirdBanners() =>
      _homeRemoteDataSource.getCarouselThirdBanners();


  @override
  Future<HomePageCategoriesModel> getHomeCategories() =>
      _homeRemoteDataSource.getHomeCategories();

  @override
  Future<JCarouselsModel> getHomeCarousalSection() =>
      _homeRemoteDataSource.getHomeCarousalSection();
}
