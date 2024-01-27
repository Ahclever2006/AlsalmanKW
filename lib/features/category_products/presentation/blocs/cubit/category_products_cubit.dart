import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/banner_model.dart';
import '../../../../../core/data/models/brand_model.dart';
import '../../../../../core/data/models/filter_attribute.dart';
import '../../../../../core/data/models/home_categ_model.dart';
import '../../../../../core/data/models/home_section_product_model.dart';
import '../../../../../core/data/models/id_name_model.dart';
import '../../../../../core/data/models/price_range_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/category_products_repository_impl.dart';

part 'category_products_state.dart';

class CategoryProductsCubit extends BaseCubit<CategoryProductsState> {
  CategoryProductsCubit({
    required CategoryProductsRepository categoryProductsRepository,
  })  : _categoryProductsRepository = categoryProductsRepository,
        super(const CategoryProductsState());

  final CategoryProductsRepository _categoryProductsRepository;

  Future<void> getCategoryProductsData(
      {int sort = 0,
      int? categoryId,
      int? brandId,
      int? subCategoryId,
      List<int>? tags,
      List<Map>? filterOption,
      PriceRangeModel? priceRangeData,
      int pageSize = 9,
      bool? soldOut,
      bool refresh = false}) async {
    try {
      if (!refresh)
        emit(state.copyWith(status: CategoryProductsStateStatus.loading));
      List<FilterAttribute>? filterData;
      List<IdNameModel>? tagsData;
      List<CategoryBrandModel>? brandsData;
      HomePageCategoriesModel? subCategories;
      PriceRangeModel? priceRange;

      if (state.filterData == null && categoryId != null)
        filterData = await getFilterData(categoryId);

      if (state.priceRange == null && categoryId != null)
        priceRange = await getPriceRangeData(categoryId);

      if (state.tagsData == null && categoryId != null)
        tagsData = await getTagsData(categoryId);

      if (state.brandsData == null && categoryId != null)
        brandsData = await getBrandsData(categoryId);

      var categoryIdValue = (subCategoryId != null && subCategoryId != -1)
          ? subCategoryId
          : (state.selectedSubCategoryId != null &&
                  state.selectedSubCategoryId != -1 &&
                  subCategoryId != -1)
              ? state.selectedSubCategoryId
              : categoryId;

      if (state.subCategories == null && categoryId != null)
        subCategories = await getSubCategoriesData(categoryId);

      final categoryProductsData =
          await _categoryProductsRepository.loadCategoryProductsData(
        categoryId: categoryIdValue,
        brandId: brandId ?? state.selectedBrandId,
        sort: sort,
        priceRange: priceRangeData,
        filterOption: filterOption,
        tags: categoryId == null ? [10] : tags,
        soldOut: soldOut,
      );

      HomeBannerModel? categoryBanners;

      if (categoryId != null)
        categoryBanners = await _categoryProductsRepository
            .loadCategoryBannersData(categoryId);
      emit(state.copyWith(
          categoryProductsData: categoryProductsData,
          categoryBanners: categoryBanners,
          filterData: filterData,
          tagsData: tagsData,
          priceRange: priceRange,
          priceRangeData: priceRangeData,
          selectedBrandId: brandId,
          brandsData: brandsData,
          subCategories: subCategories,
          status: CategoryProductsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
    }
  }

  Future<void> refresh({
    int? categoryId,
    List<int>? tags,
    List<Map>? filterOption,
    PriceRangeModel? priceRangeData,
  }) =>
      getCategoryProductsData(
        categoryId: categoryId,
        refresh: true,
        tags: tags,
        priceRangeData: priceRangeData,
        filterOption: filterOption,
      );

  Future<void> getMoreCategoryProductsData({
    int? categoryId,
    int sort = 0,
    List<int>? tags,
    List<Map>? filterOption,
    PriceRangeModel? priceRangeData,
    bool? soldOut,
    int pageSize = 9,
  }) async {
    var homeSectionProductModel = state.categoryProductsData;
    var data = homeSectionProductModel?.data;
    int pageNumber = (homeSectionProductModel!.data!.pageIndex! + 1);
    if (data?.hasNextPage == false) return;
    try {
      emit(state.copyWith(status: CategoryProductsStateStatus.loadingMore));

      final categoryProductsData =
          await _categoryProductsRepository.loadCategoryProductsData(
        categoryId: categoryId,
        brandId: state.selectedBrandId,
        pageSize: pageSize,
        pageNumber: ++pageNumber,
        priceRange: priceRangeData,
        sort: sort,
        tags: categoryId == null ? [10] : tags,
        filterOption: filterOption,
        soldOut: soldOut,
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
          status: CategoryProductsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
    }
  }

  void autoChangedCarouselIndex(int index) {
    emit(state.copyWith(
        status: CategoryProductsStateStatus.loaded,
        categoryBannerIndex: index));
  }

  Future<List<FilterAttribute>?> getFilterData(int? categoryId) async {
    try {
      final filterData =
          await _categoryProductsRepository.loadFilterData(categoryId!);

      return filterData;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
      return null;
    }
  }

  Future<List<IdNameModel>?> getTagsData(int? categoryId) async {
    try {
      final tagsData = await _categoryProductsRepository.loadTags(categoryId!);

      return tagsData;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
      return null;
    }
  }

  Future<PriceRangeModel?> getPriceRangeData(int? categoryId) async {
    try {
      final priceRange =
          await _categoryProductsRepository.loadPriceRange(categoryId!);

      return priceRange;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
      return null;
    }
  }

  Future<List<CategoryBrandModel>?> getBrandsData(int? categoryId) async {
    try {
      final brands =
          await _categoryProductsRepository.loadCategoryBrands(categoryId!);

      return brands;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
      return null;
    }
  }

  Future<HomePageCategoriesModel?> getSubCategoriesData(int? categoryId) async {
    try {
      final subCategories =
          await _categoryProductsRepository.loadSubCategoriesData(categoryId!);

      return subCategories;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CategoryProductsStateStatus.error,
          errorMessage: e.toString()));
      return null;
    }
  }

  void notifyProductIndex(int index) {
    emit(state.copyWith(
        status: CategoryProductsStateStatus.loaded, notifyProductIndex: index));
  }

  void updateProductNotifyStatus() {
    emit(
        state.copyWith(status: CategoryProductsStateStatus.updateNotifyStatus));

    final copiedData = state.categoryProductsData!.data!.products!;

    final oldProduct = copiedData.removeAt(state.notifyProductIndex!);
    final newProduct = oldProduct.copyWith(isSubscribedToBackInStock: true);

    copiedData.insert(state.notifyProductIndex!, newProduct);

    emit(state.copyWith(
        status: CategoryProductsStateStatus.loaded,
        categoryProductsData: state.categoryProductsData!.copyWith(
            data: state.categoryProductsData!.data!
                .copyWith(products: copiedData))));
  }
}
