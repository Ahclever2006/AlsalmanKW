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
  final int? selectedCategoryId;

  final String? errorMessage;

  const CategoriesState(
      {this.categories,
      this.status = CategoriesStateStatus.initial,
      this.errorMessage,
      this.selectedCategoryId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as CategoriesState).status == status &&
        other.categories == categories &&
        other.selectedCategoryId == selectedCategoryId &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      categories.hashCode ^
      status.hashCode ^
      errorMessage.hashCode ^
      selectedCategoryId.hashCode;

  CategoriesState copyWith({
    HomePageCategoriesModel? categories,
    CategoriesStateStatus? status,
    String? errorMessage,
    int? selectedCategoryId,
  }) {
    return CategoriesState(
        categories: categories ?? this.categories,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId);
  }
}
