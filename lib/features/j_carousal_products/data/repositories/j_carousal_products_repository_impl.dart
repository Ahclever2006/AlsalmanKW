import '../../../../core/data/models/home_carousal_collection_model.dart';
import '../datasources/j_carousal_products_list_remote_data_source.dart';

abstract class JCarousalProductsRepository {
  Future<JCarouselsModel> loadProductsData(
    int carousalId, {
    int pageNumber = 1,
    int pageSize = 9,
  });
}

class JCarousalProductsRepositoryImpl implements JCarousalProductsRepository {
  final JCarousalProductsRemoteDataSource _jCarousalProductsRemoteDataSource;
  JCarousalProductsRepositoryImpl(this._jCarousalProductsRemoteDataSource);

  @override
  Future<JCarouselsModel> loadProductsData(
    int carousalId, {
    int pageNumber = 1,
    int pageSize = 9,
  }) =>
      _jCarousalProductsRemoteDataSource.loadProductsData(
        carousalId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
}
