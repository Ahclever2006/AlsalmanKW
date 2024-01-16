import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/favorite_product_model.dart';
import '../../../data/repositories/favorites_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends BaseCubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository)
      : super(const FavoritesState(status: FavoritesStateStatus.initial));

  final FavoritesRepository _favoritesRepository;

  Future<void> loadFavorites({int pageSize = 9, bool refresh = false}) async {
    try {
      if (!refresh) emit(state.copyWith(status: FavoritesStateStatus.loading));
      final favorites =
          await _favoritesRepository.getFavorites(pageSize: pageSize);

      emit(state.copyWith(
          status: FavoritesStateStatus.loaded, favoritesList: favorites));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FavoritesStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => loadFavorites(refresh: true);

  Future<void> getMoreFavoritesProductsData({
    int sort = 0,
    int pageSize = 9,
  }) async {
    var oldFavList = state.favoritesList;
    int pageNumber = ((oldFavList!.length / 9).floor() + 1);
    if (oldFavList.length % 9 != 0) return;
    try {
      emit(state.copyWith(status: FavoritesStateStatus.loadingMore));

      final newFavList = await _favoritesRepository.getFavorites(
        pageSize: pageSize,
        pageNumber: ++pageNumber,
      );

      emit(
        state.copyWith(
            status: FavoritesStateStatus.loaded,
            favoritesList: [...oldFavList, ...newFavList]),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: FavoritesStateStatus.error, errorMessage: e.toString()));
    }
  }
}
