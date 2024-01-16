import '../../../../core/data/models/home_categ_model.dart';

import '../datasources/categories_remote_data_source.dart';

abstract class CategoriesRepository {
  Future<HomePageCategoriesModel> loadCategories();
}

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;
  CategoriesRepositoryImpl(this._categoriesRemoteDataSource);

  @override
  Future<HomePageCategoriesModel> loadCategories() =>
      _categoriesRemoteDataSource.loadCategories();
}
