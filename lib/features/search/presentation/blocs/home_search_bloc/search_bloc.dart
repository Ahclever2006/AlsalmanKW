import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/data/models/home_section_product_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/search_repository.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchRepository) : super(const SearchState()) {
    on<SearchEvent>(
      (event, emit) async {
        if (event.isSearch)
          await _loadProducts(
            emit,
            searchText: event.searchText,
          );
        if (event.isLoadMore)
          await _loadMoreEvents(
            emit,
            event.searchText,
          );
      },
      transformer: (events, mapper) => events
          .where((event) =>
              event.searchText?.isNotEmpty != true ||
              event.searchText!.length >= 2)
          .debounceTime(const Duration(milliseconds: 500))
          .distinct(
              (previous, next) => !next.isSearch ? false : previous == next)
          .switchMap(mapper),
    );
  }

  final SearchRepository _searchRepository;

  Future<void> _loadProducts(
    Emitter<SearchState> emit, {
    String? searchText,
  }) async {
    try {
      if (searchText?.trim().isNotEmpty != true)
        return emit(const SearchState(status: SearchStateStatus.loaded));

      emit(state.copyWith(status: SearchStateStatus.loading));
      final products = await _searchRepository.loadSearchProductsData(
          searchText: searchText!.trim());
      emit(state.copyWith(
        status: SearchStateStatus.loaded,
        products: products,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: SearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _loadMoreEvents(
    Emitter<SearchState> emit,
    String? searchText,
  ) async {
    if (state.isLoadingMore || state.products?.data?.hasNextPage == false)
      return;

    final oldProducts = state.products?.data?.products;

    try {
      emit(state.copyWith(
        status: SearchStateStatus.loadingMore,
        searchText: searchText,
      ));
      var pageNumber = state.products!.data!.pageIndex! + 2;
      final newProducts = await _searchRepository.loadSearchProductsData(
          searchText: searchText!.trim(), pageNumber: pageNumber);
      emit(
        state.copyWith(
            status: SearchStateStatus.loaded,
            products: newProducts.copyWith(
                data: state.products!.data!.copyWith(
              pageIndex: newProducts.data?.pageIndex,
              products: [
                ...?oldProducts,
                ...?newProducts.data!.products,
              ],
            ))),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: SearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
