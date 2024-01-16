import '../datasources/brands_remote_data_source.dart';
import '../models/brand_model/brand_model.dart';

abstract class BrandsRepository {
  Future<List<BrandModel>> loadBrands({
    int pageNumber = 1,
    int pageSize = 9,
  });
}

class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsRemoteDataSource _brandsRemoteDataSource;
  BrandsRepositoryImpl(this._brandsRemoteDataSource);

  @override
  Future<List<BrandModel>> loadBrands({
    int pageNumber = 1,
    int pageSize = 9,
  }) =>
      _brandsRemoteDataSource.loadBrands(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
}
