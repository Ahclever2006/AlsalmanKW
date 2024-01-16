part of 'home_cubit.dart';

enum HomeStateStatus {
  initial,
  loading,
  loaded,
  success,
  notifiedSuccess,
  error
}

extension HomeStateX on HomeState {
  bool get isInitial => status == HomeStateStatus.initial;
  bool get isLoading => status == HomeStateStatus.loading;
  bool get isLoaded => status == HomeStateStatus.loaded;
  bool get isSuccess => status == HomeStateStatus.success;
  bool get isNotifiedSuccess => status == HomeStateStatus.notifiedSuccess;
  bool get isError => status == HomeStateStatus.error;
}

@immutable
class HomeState {
  final HomeStateStatus status;
  final HomeBannerModel? banners;
  final HomeBannerModel? carouselFirstBanners;
  final HomeBannerModel? carouselSecondBanners;
  final HomeBannerModel? carouselThirdBanners;
  final HomeBannerModel? categoriesBanners;
  final HomePageCategoriesModel? categories;
  final JCarouselsModel? carousalSections;
  final int? homeBannerIndex;
  final String? errorMessage;
  const HomeState({
    this.status = HomeStateStatus.initial,
    this.banners,
    this.carouselFirstBanners,
    this.carouselSecondBanners,
    this.carouselThirdBanners,
    this.categoriesBanners,
    this.categories,
    this.carousalSections,
    this.homeBannerIndex = 0,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as HomeState).status == status &&
        other.banners == banners &&
        other.carouselFirstBanners == carouselFirstBanners &&
        other.carouselSecondBanners == carouselSecondBanners &&
        other.carouselThirdBanners == carouselThirdBanners &&
        other.categoriesBanners == categoriesBanners &&
        other.categories == categories &&
        other.carousalSections == carousalSections &&
        other.homeBannerIndex == homeBannerIndex &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      banners.hashCode ^
      carouselFirstBanners.hashCode ^
      carouselSecondBanners.hashCode ^
      carouselThirdBanners.hashCode ^
      categoriesBanners.hashCode ^
      categories.hashCode ^
      carousalSections.hashCode ^
      homeBannerIndex.hashCode ^
      errorMessage.hashCode;

  HomeState copyWith({
    HomeStateStatus? status,
    HomeBannerModel? banners,
    HomeBannerModel? carouselFirstBanners,
    HomeBannerModel? carouselSecondBanners,
    HomeBannerModel? carouselThirdBanners,
    HomeBannerModel? categoriesBanners,
    HomePageCategoriesModel? categories,
    JCarouselsModel? carousalSections,
    int? homeBannerIndex,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      carouselFirstBanners: carouselFirstBanners ?? this.carouselFirstBanners,
      carouselSecondBanners:
          carouselSecondBanners ?? this.carouselSecondBanners,
      carouselThirdBanners: carouselThirdBanners ?? this.carouselThirdBanners,
      categoriesBanners: categoriesBanners ?? this.categoriesBanners,
      categories: categories ?? this.categories,
      carousalSections: carousalSections ?? this.carousalSections,
      homeBannerIndex: homeBannerIndex ?? this.homeBannerIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
