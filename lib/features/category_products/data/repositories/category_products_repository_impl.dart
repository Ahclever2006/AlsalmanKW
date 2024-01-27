import '../../../../core/data/models/brand_model.dart';
import '../../../../core/data/models/home_categ_model.dart';
import '../../../../core/data/models/id_name_model.dart';

import '../../../../core/data/models/banner_model.dart';
import '../../../../core/data/models/filter_attribute.dart';
import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/data/models/price_range_model.dart';
import '../datasources/category_products_list_remote_data_source.dart';

abstract class CategoryProductsRepository {
  Future<HomeSectionProductModel> loadCategoryProductsData({
    int? categoryId,
    int? brandId,
    int sort = 0,
    List<int>? tags,
    List<Map>? filterOption,
    PriceRangeModel? priceRange,
    int pageNumber = 1,
    int pageSize = 9,
    bool? soldOut,
  });
  Future<HomeBannerModel> loadCategoryBannersData(int categoryId);
  Future<List<FilterAttribute>> loadFilterData(int categoryId);
  Future<List<IdNameModel>> loadTags(int categoryId);
  Future<PriceRangeModel> loadPriceRange(int categoryId);
  Future<List<CategoryBrandModel>> loadCategoryBrands(int categoryId);
  Future<HomePageCategoriesModel> loadSubCategoriesData(int categoryId);
}

class CategoryProductsRepositoryImpl implements CategoryProductsRepository {
  final CategoryProductsRemoteDataSource _categoryProductsRemoteDataSource;
  CategoryProductsRepositoryImpl(this._categoryProductsRemoteDataSource);

  @override
  Future<HomeSectionProductModel> loadCategoryProductsData({
    int? categoryId,
    int? brandId,
    int sort = 0,
    List<int>? tags,
    List<Map>? filterOption,
    PriceRangeModel? priceRange,
    int pageNumber = 1,
    int pageSize = 9,
    bool? soldOut,
  }) =>
      _categoryProductsRemoteDataSource.loadCategoryProductsData(
        categoryId: categoryId,
        brandId: brandId,
        pageNumber: pageNumber,
        pageSize: pageSize,
        priceRange: priceRange,
        sort: sort,
        filterOption: filterOption,
        tags: tags,
        soldOut: soldOut,
      );

  @override
  Future<HomeBannerModel> loadCategoryBannersData(int categoryId) =>
      _categoryProductsRemoteDataSource.loadCategoryBannersData(categoryId);

  @override
  Future<List<FilterAttribute>> loadFilterData(int categoryId) =>
      _categoryProductsRemoteDataSource.loadFilterData(categoryId);

  @override
  Future<List<IdNameModel>> loadTags(int categoryId) =>
      _categoryProductsRemoteDataSource.loadTags(categoryId);

  @override
  Future<List<CategoryBrandModel>> loadCategoryBrands(int categoryId) =>
      _categoryProductsRemoteDataSource.loadCategoryBrands(categoryId);

  @override
  Future<HomePageCategoriesModel> loadSubCategoriesData(int categoryId) =>
      _categoryProductsRemoteDataSource.loadSubCategoriesData(categoryId);

  @override
  Future<PriceRangeModel> loadPriceRange(int categoryId) =>
      _categoryProductsRemoteDataSource.loadPriceRange(categoryId);
}
