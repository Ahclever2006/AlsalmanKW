import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/brand_model/brand_model.dart';
import '../../../data/repositories/brands_repository_impl.dart';

part 'brands_state.dart';

class BrandsCubit extends BaseCubit<BrandsState> {
  BrandsCubit({
    required BrandsRepository brandsRepository,
  })  : _brandsRepository = brandsRepository,
        super(const BrandsState());

  final BrandsRepository _brandsRepository;

  Future<void> getBrandsData({int pageSize = 9, bool refresh = false}) async {
    try {
      if (!refresh) emit(state.copyWith(status: BrandsStateStatus.loading));

      final brands = await _brandsRepository.loadBrands();

      emit(state.copyWith(brands: brands, status: BrandsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: BrandsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => getBrandsData(refresh: true);

  // Future<void> getMoreCategoryProductsData({
  //   required int brandId,
  //   int pageSize = 9,
  // }) async {
  //   var brands = state.brands;

  //   int pageNumber = (homeSectionProductModel!.data!.pageIndex! + 1);
  //   if (data?.hasNextPage == false) return;
  //   try {
  //     emit(state.copyWith(status: BrandsStateStatus.loadingMore));

  //     final categoryProductsData =
  //         await _brandsRepository.loadBrandProductsData(
  //       brandId: brandId,
  //       pageSize: pageSize,
  //       pageNumber: ++pageNumber,
  //     );

  //     emit(state.copyWith(
  //         categoryProductsData: homeSectionProductModel.copyWith(
  //             data: data!.copyWith(
  //           products: [
  //             ...?data.products,
  //             ...?categoryProductsData.data?.products
  //           ],
  //           hasNextPage: categoryProductsData.data?.hasNextPage,
  //           pageIndex: categoryProductsData.data?.pageIndex,
  //         )),
  //         status: BrandsStateStatus.loaded));
  //   } on RedundantRequestException catch (e) {
  //     log(e.toString());
  //   } catch (e) {
  //     emit(state.copyWith(
  //         status: BrandsStateStatus.error, errorMessage: e.toString()));
  //   }
  // }
}
