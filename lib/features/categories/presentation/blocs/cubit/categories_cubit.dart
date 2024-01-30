import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/banner_model.dart';
import '../../../../../core/data/models/home_categ_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/categories_repository_impl.dart';

part 'categories_state.dart';

class CategoriesCubit extends BaseCubit<CategoriesState> {
  CategoriesCubit({
    required CategoriesRepository categoriesRepository,
  })  : _categoriesRepository = categoriesRepository,
        super(const CategoriesState());

  final CategoriesRepository _categoriesRepository;

  void selectCategoryId(int categoryId) {
    emit(state.copyWith(
        status: CategoriesStateStatus.loaded, selectedCategoryId: categoryId));
  }

  Future<void> getCategoriesData(
      {int pageSize = 9, bool refresh = false}) async {
    try {
      if (!refresh) emit(state.copyWith(status: CategoriesStateStatus.loading));

      final categories = await _categoriesRepository.loadCategories();

      // final categoriesBanners =
      //     await _categoriesRepository.getCategoriesBanners();

      emit(state.copyWith(
          categories: categories,
          // categoriesBanners: categoriesBanners,
          status: CategoriesStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CategoriesStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => getCategoriesData(refresh: true);
}
