part of 'category_products_cubit.dart';

enum CategoryProductsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  updateNotifyStatus,
  error,
  // loadingFilterData,
  // filterDataLoaded
}

extension CategoryProductsStateX on CategoryProductsState {
  bool get isInitial => status == CategoryProductsStateStatus.initial;
  bool get isLoading => status == CategoryProductsStateStatus.loading;
  bool get isLoaded => status == CategoryProductsStateStatus.loaded;
  bool get isLoadingMore => status == CategoryProductsStateStatus.loadingMore;
  bool get isUpdateNotifyStatus =>
      status == CategoryProductsStateStatus.updateNotifyStatus;
  bool get isError => status == CategoryProductsStateStatus.error;
  // bool get isLoadingFilterData =>
  //     status == CategoryProductsStateStatus.loadingFilterData;
  // bool get isFilterDataLoaded =>
  //     status == CategoryProductsStateStatus.filterDataLoaded;
}

@immutable
class CategoryProductsState {
  final HomeSectionProductModel? categoryProductsData;
  final HomeBannerModel? categoryBanners;
  final List<FilterAttribute>? filterData;
  final HomePageCategoriesModel? subCategories;
  final List<IdNameModel>? tagsData;
  final PriceRangeModel? priceRange;
  final PriceRangeModel? selectedPriceRange;
  final List<CategoryBrandModel>? brandsData;
  final CategoryProductsStateStatus status;
  final int? categoryBannerIndex;
  final int? notifyProductIndex;
  final int? selectedBrandId;
  final int? selectedSubCategoryId;
  final String? errorMessage;
  final int? sortBy;
  final List<int>? tagsList;
  final List<Map>? filterList;
  final bool hasFilteredData;

  const CategoryProductsState(
      {this.categoryProductsData,
      this.categoryBanners,
      this.filterData,
      this.subCategories,
      this.tagsData,
      this.brandsData,
      this.priceRange,
      this.selectedPriceRange,
      this.categoryBannerIndex = 0,
      this.notifyProductIndex,
      this.selectedBrandId,
      this.selectedSubCategoryId,
      this.status = CategoryProductsStateStatus.initial,
      this.errorMessage,
      this.sortBy = 0,
      this.filterList,
      this.tagsList,
      this.hasFilteredData = false});

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
        other.priceRange == priceRange &&
        other.selectedPriceRange == selectedPriceRange &&
        other.categoryBanners == categoryBanners &&
        other.selectedBrandId == selectedBrandId &&
        other.selectedSubCategoryId == selectedSubCategoryId &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.sortBy == sortBy &&
        other.hasFilteredData == hasFilteredData &&
        listEquals(other.tagsList, tagsList) &&
        listEquals(other.filterList, filterList);
  }

  @override
  int get hashCode =>
      categoryProductsData.hashCode ^
      categoryBannerIndex.hashCode ^
      notifyProductIndex.hashCode ^
      filterData.hashCode ^
      subCategories.hashCode ^
      tagsData.hashCode ^
      priceRange.hashCode ^
      selectedPriceRange.hashCode ^
      brandsData.hashCode ^
      selectedBrandId.hashCode ^
      selectedSubCategoryId.hashCode ^
      categoryBanners.hashCode ^
      status.hashCode ^
      errorMessage.hashCode ^
      sortBy.hashCode ^
      tagsList.hashCode ^
      filterList.hashCode ^
      hasFilteredData.hashCode;

  CategoryProductsState copyWith(
      {HomeSectionProductModel? categoryProductsData,
      HomeBannerModel? categoryBanners,
      List<FilterAttribute>? filterData,
      List<IdNameModel>? tagsData,
      List<CategoryBrandModel>? brandsData,
      HomePageCategoriesModel? subCategories,
      CategoryProductsStateStatus? status,
      PriceRangeModel? priceRange,
      int? categoryBannerIndex,
      int? notifyProductIndex,
      int? selectedBrandId,
      int? selectedSubCategoryId,
      String? errorMessage,
      int? sortBy,
      List<int>? tagsList,
      List<Map>? filterList,
      PriceRangeModel? selectedPriceRange,
      bool? hasFilteredData}) {
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
        priceRange: priceRange ?? this.priceRange,
        selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
        selectedSubCategoryId:
            selectedSubCategoryId ?? this.selectedSubCategoryId,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        sortBy: sortBy ?? this.sortBy,
        tagsList: tagsList ?? this.tagsList,
        hasFilteredData: hasFilteredData ?? this.hasFilteredData,
        filterList: filterList ?? this.filterList);
  }
}
