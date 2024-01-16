part of 'favorites_cubit.dart';

enum FavoritesStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension FavoritesStateX on FavoritesState {
  bool get isInitial => status == FavoritesStateStatus.initial;
  bool get isLoading => status == FavoritesStateStatus.loading;
  bool get isLoaded => status == FavoritesStateStatus.loaded;
  bool get isLoadingMore => status == FavoritesStateStatus.loadingMore;
  bool get isError => status == FavoritesStateStatus.error;
}

@immutable
class FavoritesState {
  final FavoritesStateStatus status;
  final String? errorMessage;
  final List<FavoriteProductModel>? favoritesList;

  const FavoritesState({
    required this.status,
    this.errorMessage,
    this.favoritesList,
  });

  FavoritesState copyWith({
    FavoritesStateStatus? status,
    String? errorMessage,
    List<FavoriteProductModel>? favoritesList,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      favoritesList: favoritesList ?? this.favoritesList,
    );
  }

  @override
  bool operator ==(covariant FavoritesState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.favoritesList, favoritesList);
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ favoritesList.hashCode;
}
