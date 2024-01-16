part of 'category_products_cubit.dart';

enum CategoryProductsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  updateNotifyStatus,
  error,
}

extension CategoryProductsStateX on CategoryProductsState {
  bool get isInitial => status == CategoryProductsStateStatus.initial;
  bool get isLoading => status == CategoryProductsStateStatus.loading;
  bool get isLoaded => status == CategoryProductsStateStatus.loaded;
  bool get isLoadingMore => status == CategoryProductsStateStatus.loadingMore;
  bool get isUpdateNotifyStatus =>
      status == CategoryProductsStateStatus.updateNotifyStatus;
  bool get isError => status == CategoryProductsStateStatus.error;
}

@immutable
class CategoryProductsState {
  final HomeSectionProductModel? categoryProductsData;
  final HomeBannerModel? categoryBanners;
  final List<FilterAttribute>? filterData;
  final HomePageCategoriesModel? subCategories;
  final List<IdNameModel>? tagsData;
  final List<CategoryBrandModel>? brandsData;
  final CategoryProductsStateStatus status;
  final int? categoryBannerIndex;
  final int? notifyProductIndex;
  final int? selectedBrandId;
  final int? selectedSubCategoryId;
  final String? errorMessage;

  const CategoryProductsState({
    this.categoryProductsData,
    this.categoryBanners,
    this.filterData,
    this.subCategories,
    this.tagsData,
    this.brandsData,
    this.categoryBannerIndex = 0,
    this.notifyProductIndex,
    this.selectedBrandId,
    this.selectedSubCategoryId,
    this.status = CategoryProductsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as CategoryProductsState).categoryProductsData ==
            categoryProductsData &&
        other.categoryBannerIndex == categoryBannerIndex &&
        other.notifyProductIndex == notifyProductIndex &&
        listEquals(other.filterData, filterData) &&
        listEquals(other.tagsData, tagsData) &&
        listEquals(other.brandsData, brandsData) &&
        other.subCategories == subCategories &&
        other.categoryBanners == categoryBanners &&
        other.selectedBrandId == selectedBrandId &&
        other.selectedSubCategoryId == selectedSubCategoryId &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      categoryProductsData.hashCode ^
      categoryBannerIndex.hashCode ^
      notifyProductIndex.hashCode ^
      filterData.hashCode ^
      subCategories.hashCode ^
      tagsData.hashCode ^
      brandsData.hashCode ^
      selectedBrandId.hashCode ^
      selectedSubCategoryId.hashCode ^
      categoryBanners.hashCode ^
      status.hashCode ^
      errorMessage.hashCode;

  CategoryProductsState copyWith({
    HomeSectionProductModel? categoryProductsData,
    HomeBannerModel? categoryBanners,
    List<FilterAttribute>? filterData,
    List<IdNameModel>? tagsData,
    List<CategoryBrandModel>? brandsData,
    HomePageCategoriesModel? subCategories,
    CategoryProductsStateStatus? status,
    int? categoryBannerIndex,
    int? notifyProductIndex,
    int? selectedBrandId,
    int? selectedSubCategoryId,
    String? errorMessage,
  }) {
    return CategoryProductsState(
      categoryProductsData: categoryProductsData ?? this.categoryProductsData,
      categoryBanners: categoryBanners ?? this.categoryBanners,
      subCategories: subCategories ?? this.subCategories,
      filterData: filterData ?? this.filterData,
      tagsData: tagsData ?? this.tagsData,
      brandsData: brandsData ?? this.brandsData,
      categoryBannerIndex: categoryBannerIndex ?? this.categoryBannerIndex,
      notifyProductIndex: notifyProductIndex ?? this.notifyProductIndex,
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      selectedSubCategoryId:
          selectedSubCategoryId ?? this.selectedSubCategoryId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
