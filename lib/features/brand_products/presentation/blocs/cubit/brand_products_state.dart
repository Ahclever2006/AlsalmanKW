part of 'brand_products_cubit.dart';

enum BrandProductsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension BrandProductsStateX on BrandProductsState {
  bool get isInitial => status == BrandProductsStateStatus.initial;
  bool get isLoading => status == BrandProductsStateStatus.loading;
  bool get isLoaded => status == BrandProductsStateStatus.loaded;
  bool get isLoadingMore => status == BrandProductsStateStatus.loadingMore;
  bool get isError => status == BrandProductsStateStatus.error;
}

@immutable
class BrandProductsState {
  final HomeSectionProductModel? categoryProductsData;
  final HomeBannerModel? categoryBanners;
  final List<FilterAttribute>? filterData;
  final List<IdNameModel>? tagsData;
  final List<CategoryBrandModel>? brandsData;
  final BrandProductsStateStatus status;
  final int? categoryBannerIndex;
  final String? errorMessage;

  const BrandProductsState({
    this.categoryProductsData,
    this.categoryBanners,
    this.filterData,
    this.tagsData,
    this.brandsData,
    this.categoryBannerIndex = 0,
    this.status = BrandProductsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as BrandProductsState).categoryProductsData ==
            categoryProductsData &&
        other.categoryBannerIndex == categoryBannerIndex &&
        listEquals(other.filterData, filterData) &&
        listEquals(other.brandsData, brandsData) &&
        listEquals(other.tagsData, tagsData) &&
        other.categoryBanners == categoryBanners &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      categoryProductsData.hashCode ^
      categoryBannerIndex.hashCode ^
      filterData.hashCode ^
      brandsData.hashCode ^
      tagsData.hashCode ^
      categoryBanners.hashCode ^
      status.hashCode ^
      errorMessage.hashCode;

  BrandProductsState copyWith({
    HomeSectionProductModel? categoryProductsData,
    HomeBannerModel? categoryBanners,
    List<FilterAttribute>? filterData,
    List<IdNameModel>? tagsData,
    List<CategoryBrandModel>? brandsData,
    BrandProductsStateStatus? status,
    int? categoryBannerIndex,
    String? errorMessage,
  }) {
    return BrandProductsState(
      categoryProductsData: categoryProductsData ?? this.categoryProductsData,
      categoryBanners: categoryBanners ?? this.categoryBanners,
      filterData: filterData ?? this.filterData,
      tagsData: tagsData ?? this.tagsData,
      brandsData: brandsData ?? this.brandsData,
      categoryBannerIndex: categoryBannerIndex ?? this.categoryBannerIndex,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
