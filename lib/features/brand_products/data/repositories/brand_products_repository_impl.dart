import '../../../../core/data/models/home_section_product_model.dart';
import '../datasources/brand_products_list_remote_data_source.dart';

abstract class BrandProductsRepository {
  Future<HomeSectionProductModel> loadBrandProductsData({
    required int brandId,
    int pageNumber = 1,
    int pageSize = 9,
  });
}

class BrandProductsRepositoryImpl implements BrandProductsRepository {
  final BrandProductsRemoteDataSource _brandProductsRemoteDataSource;
  BrandProductsRepositoryImpl(this._brandProductsRemoteDataSource);

  @override
  Future<HomeSectionProductModel> loadBrandProductsData({
    required int brandId,
    int pageNumber = 1,
    int pageSize = 9,
  }) =>
      _brandProductsRemoteDataSource.loadBrandProductsData(
        brandId: brandId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
}
