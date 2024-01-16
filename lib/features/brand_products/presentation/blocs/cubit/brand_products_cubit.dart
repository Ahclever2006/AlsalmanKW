import 'dart:developer';

import '../../../../../core/data/models/brand_model.dart';
import '../../../../../core/data/models/id_name_model.dart';

import '../../../../../core/data/models/banner_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/filter_attribute.dart';
import '../../../../../core/data/models/home_section_product_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/brand_products_repository_impl.dart';

part 'brand_products_state.dart';

class BrandProductsCubit extends BaseCubit<BrandProductsState> {
  BrandProductsCubit({
    required BrandProductsRepository brandProductsRepository,
  })  : _brandProductsRepository = brandProductsRepository,
        super(const BrandProductsState());

  final BrandProductsRepository _brandProductsRepository;

  Future<void> getBrandProductsData(
      {required int brandId, int pageSize = 9, bool refresh = false}) async {
    try {
      if (!refresh)
        emit(state.copyWith(status: BrandProductsStateStatus.loading));

      // List<CategoryBrandModel>? brandsData;

      final categoryProductsData = await _brandProductsRepository
          .loadBrandProductsData(brandId: brandId);

      // if (state.brandsData == null) brandsData = await getBrandsData(brandId);

      emit(state.copyWith(
          categoryProductsData: categoryProductsData,
          status: BrandProductsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BrandProductsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh({
    required int brandId,
    List<int>? tags,
    List<Map>? filterOption,
  }) =>
      getBrandProductsData(brandId: brandId, refresh: true);

  Future<void> getMoreCategoryProductsData({
    required int brandId,
    int pageSize = 9,
  }) async {
    var homeSectionProductModel = state.categoryProductsData;
    var data = homeSectionProductModel?.data;
    int pageNumber = (homeSectionProductModel!.data!.pageIndex! + 1);
    if (data?.hasNextPage == false) return;
    try {
      emit(state.copyWith(status: BrandProductsStateStatus.loadingMore));

      final categoryProductsData =
          await _brandProductsRepository.loadBrandProductsData(
        brandId: brandId,
        pageSize: pageSize,
        pageNumber: ++pageNumber,
      );

      emit(state.copyWith(
          categoryProductsData: homeSectionProductModel.copyWith(
              data: data!.copyWith(
            products: [
              ...?data.products,
              ...?categoryProductsData.data?.products
            ],
            hasNextPage: categoryProductsData.data?.hasNextPage,
            pageIndex: categoryProductsData.data?.pageIndex,
          )),
          status: BrandProductsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BrandProductsStateStatus.error, errorMessage: e.toString()));
    }
  }

  // Future<List<CategoryBrandModel>?> getBrandsData(int? brandId) async {
  //   try {
  //     final brands = await _brandProductsRepository.loadBrandBrands(brandId!);

  //     return brands;
  //   } on RedundantRequestException catch (e) {
  //     log(e.toString());
  //     return null;
  //   } catch (e) {
  //     emit(state.copyWith(
  //         status: BrandProductsStateStatus.error, errorMessage: e.toString()));
  //     return null;
  //   }
  // }
}
