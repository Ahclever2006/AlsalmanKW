import '../../../../core/data/models/price_range_model.dart';
import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/data/models/brand_model.dart';
import '../../../../core/data/models/filter_attribute.dart';
import '../../../../core/data/models/home_categ_model.dart';
import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/data/models/id_name_model.dart';

abstract class CategoryProductsRemoteDataSource {
  Future<HomeSectionProductModel> loadCategoryProductsData({
    int? categoryId,
    int? brandId,
    int sort = 0,
    int pageNumber = 1,
    int pageSize = 9,
    PriceRangeModel? priceRange,
    List<int>? tags,
    List<Map>? filterOption,
    bool? soldOut,
  });
  Future<HomeBannerModel> loadCategoryBannersData(int categoryId);
  Future<List<FilterAttribute>> loadFilterData(int categoryId);
  Future<List<IdNameModel>> loadTags(int categoryId);
  Future<PriceRangeModel> loadPriceRange(int categoryId);
  Future<List<CategoryBrandModel>> loadCategoryBrands(int categoryId);
  Future<HomePageCategoriesModel> loadSubCategoriesData(int categoryId);
}

class CategoryProductsRemoteDataSourceImpl
    implements CategoryProductsRemoteDataSource {
  final NetworkService _networkService;

  CategoryProductsRemoteDataSourceImpl(this._networkService);

  @override
  Future<HomeSectionProductModel> loadCategoryProductsData({
    int? categoryId,
    int? brandId,
    int sort = 0,
    List<Map>? filterOption,
    List<int>? tags,
    PriceRangeModel? priceRange,
    int pageNumber = 1,
    int pageSize = 9,
    bool? soldOut,
  }) {
    const url = ApiEndPoint.getProducts;

    final data = {
      "SubCategories": true,
      if (categoryId != null) "CategoriesIds": [categoryId],
      if (brandId != null && brandId != -1) "ManufacturerIds": [brandId],
      if (priceRange != null)
        "Price": {"From": priceRange.from, "To": priceRange.to},
      "OrderBy": sort,
      "FilteredSpecOptions": filterOption,
      "ProductTagIds": tags,
      "PageNumber": pageNumber,
      "PageSize": pageSize,
      "IncludeGiftCard": true,
      "showManufacturers": true,
      if (soldOut != null) "SoldOut": soldOut,
    }..removeWhere((_, v) => v == null);

    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeSectionProductModel.fromMap(result);
    });
  }

  @override
  Future<HomeBannerModel> loadCategoryBannersData(int categoryId) {
    const url = ApiEndPoint.getCategoryBanner;
    final params = {'categoryId': categoryId};
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomeBannerModel.fromMap(result);
    });
  }

  @override
  Future<List<FilterAttribute>> loadFilterData(int categoryId) {
    const url = ApiEndPoint.getFilterData;

    return _networkService.post(url, data: {
      "GroupName": "All",
      "CategoryIds": [categoryId]
    }).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final filterData = result['Data'] as List;
      return filterData.map((e) => FilterAttribute.fromMap(e)).toList();
    });
  }

  @override
  Future<List<IdNameModel>> loadTags(int categoryId) {
    const url = ApiEndPoint.getTagsData;
    final params = {"categoryId": categoryId};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final tags = result['Data'] as List;
      return tags.map((e) => IdNameModel.fromMap(e)).toList();
    });
  }

  @override
  Future<List<CategoryBrandModel>> loadCategoryBrands(int categoryId) {
    const url = ApiEndPoint.getCategoryBrandsData;
    final data = [categoryId];
    final params = {"includeSubCategories": true};

    return _networkService
        .post(url, queryParameters: params, data: data)
        .then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final tags = result['Data'] as List;
      return tags.map((e) => CategoryBrandModel.fromMap(e)).toList();
    });
  }

  @override
  Future<HomePageCategoriesModel> loadSubCategoriesData(int categoryId) {
    const url = ApiEndPoint.getSubCategories;
    final params = {"categoryId": categoryId};
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return HomePageCategoriesModel.fromMap(result);
    });
  }

  @override
  Future<PriceRangeModel> loadPriceRange(int categoryId) {
    const url = ApiEndPoint.getPriceRangeData;

    final params = {"categoryId": categoryId};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final data = result['Data'];
      return PriceRangeModel.fromMap(data);
    });
  }
}
