import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/home_carousal_collection_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/j_carousal_products_repository_impl.dart';

part 'j_carousal_products_state.dart';

class JCarousalProductsCubit extends BaseCubit<JCarousalProductsState> {
  JCarousalProductsCubit({
    required JCarousalProductsRepository jCarousalProductsRepository,
  })  : _jCarousalProductsRepository = jCarousalProductsRepository,
        super(const JCarousalProductsState());

  final JCarousalProductsRepository _jCarousalProductsRepository;

  Future<void> getProductsData(int carousalId,
      {int sort = 0, int pageSize = 10, bool refresh = false}) async {
    try {
      if (!refresh)
        emit(state.copyWith(status: JCarousalProductsStateStatus.loading));

      final productsData = await _jCarousalProductsRepository
          .loadProductsData(carousalId, pageSize: pageSize);

      emit(state.copyWith(
          carousalSection: productsData,
          status: JCarousalProductsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: JCarousalProductsStateStatus.error,
          errorMessage: e.toString()));
    }
  }

  Future<void> refresh(int carousalId) =>
      getProductsData(carousalId, refresh: true);

  Future<void> getMoreProductsData(
    int carousalId, {
    int pageSize = 10,
  }) async {
    var carouselProductModel = state.carousalSection;
    var oldProductsList = carouselProductModel?.data?.first.products;
    int pageNumber = ((oldProductsList!.length / 10).floor() + 1);
    if (oldProductsList.length % 10 != 0) return;
    try {
      emit(state.copyWith(status: JCarousalProductsStateStatus.loadingMore));

      final categoryProductsData =
          await _jCarousalProductsRepository.loadProductsData(
        carousalId,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      final oldData = carouselProductModel!.data!.removeAt(0);

      final newData = oldData.copyWith(products: [
        ...?oldData.products,
        ...?categoryProductsData.data?.first.products
      ]);

      carouselProductModel.data!.insert(0, newData);

      emit(state.copyWith(
          carousalSection:
              carouselProductModel.copyWith(data: carouselProductModel.data),
          status: JCarousalProductsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: JCarousalProductsStateStatus.error,
          errorMessage: e.toString()));
    }
  }
}
