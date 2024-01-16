part of 'search_bloc.dart';

enum SearchStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension SearchStateX on SearchState {
  bool get isInitial => status == SearchStateStatus.initial;
  bool get isLoading => status == SearchStateStatus.loading;
  bool get isLoadingMore => status == SearchStateStatus.loadingMore;
  bool get isLoaded => status == SearchStateStatus.loaded;
  bool get isError => status == SearchStateStatus.error;
}

@immutable
class SearchState {
  final HomeSectionProductModel? products;
  final SearchStateStatus status;
  final String? errorMessage;
  final String? searchText;

  const SearchState({
    this.products,
    this.status = SearchStateStatus.initial,
    this.errorMessage,
    this.searchText,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchState &&
        other.products == products &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.searchText == searchText;
  }

  @override
  int get hashCode =>
      products.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  SearchState copyWith({
    HomeSectionProductModel? products,
    SearchStateStatus? status,
    String? errorMessage,
    String? searchText,
  }) {
    return SearchState(
      products: products ?? this.products,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      searchText: searchText ?? this.searchText,
    );
  }
}
