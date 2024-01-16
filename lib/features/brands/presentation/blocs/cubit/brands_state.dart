part of 'brands_cubit.dart';

enum BrandsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension BrandsStateX on BrandsState {
  bool get isInitial => status == BrandsStateStatus.initial;
  bool get isLoading => status == BrandsStateStatus.loading;
  bool get isLoaded => status == BrandsStateStatus.loaded;
  bool get isLoadingMore => status == BrandsStateStatus.loadingMore;
  bool get isError => status == BrandsStateStatus.error;
}

@immutable
class BrandsState {
  final List<BrandModel>? brands;
  final BrandsStateStatus status;
  final String? errorMessage;

  const BrandsState({
    this.brands,
    this.status = BrandsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as BrandsState).status == status &&
        listEquals(other.brands, brands) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => brands.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  BrandsState copyWith({
    List<BrandModel>? brands,
    BrandsStateStatus? status,
    String? errorMessage,
  }) {
    return BrandsState(
      brands: brands ?? this.brands,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
