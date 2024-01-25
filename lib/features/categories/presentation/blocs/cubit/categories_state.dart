part of 'categories_cubit.dart';

enum CategoriesStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension CategoriesStateX on CategoriesState {
  bool get isInitial => status == CategoriesStateStatus.initial;
  bool get isLoading => status == CategoriesStateStatus.loading;
  bool get isLoaded => status == CategoriesStateStatus.loaded;
  bool get isLoadingMore => status == CategoriesStateStatus.loadingMore;
  bool get isError => status == CategoriesStateStatus.error;
}

@immutable
class CategoriesState {
  final HomePageCategoriesModel? categories;
  final CategoriesStateStatus status;
  final HomeBannerModel? categoriesBanners;
  final int? selectedCategoryId;

  final String? errorMessage;

  const CategoriesState(
      {this.categories,
      this.status = CategoriesStateStatus.initial,
      this.categoriesBanners,
      this.errorMessage,
      this.selectedCategoryId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as CategoriesState).status == status &&
        other.categories == categories &&
        other.categoriesBanners == categoriesBanners &&
        other.selectedCategoryId == selectedCategoryId &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      categories.hashCode ^
      status.hashCode ^
      categoriesBanners.hashCode ^
      errorMessage.hashCode ^
      selectedCategoryId.hashCode;

  CategoriesState copyWith({
    HomePageCategoriesModel? categories,
    CategoriesStateStatus? status,
    HomeBannerModel? categoriesBanners,
    String? errorMessage,
    int? selectedCategoryId,
  }) {
    return CategoriesState(
        categories: categories ?? this.categories,
        status: status ?? this.status,
        categoriesBanners: categoriesBanners ?? this.categoriesBanners,
        errorMessage: errorMessage ?? this.errorMessage,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId);
  }
}
