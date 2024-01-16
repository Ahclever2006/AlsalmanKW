import '../../../../core/data/models/home_section_product_model.dart';
import '../datasources/search_remote_data_source.dart';

abstract class SearchRepository {
  Future<HomeSectionProductModel> loadSearchProductsData({
    int pageNumber = 1,
    int pageSize = 9,
    required String searchText,
  });
}

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl({
    required SearchRemoteDataSource searchRemoteDataSource,
  }) : _remoteDataSource = searchRemoteDataSource;

  @override
  Future<HomeSectionProductModel> loadSearchProductsData({
    int pageNumber = 1,
    int pageSize = 9,
    required String searchText,
  }) =>
      _remoteDataSource.loadSearchProductsData(
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchText: searchText,
      );
}
