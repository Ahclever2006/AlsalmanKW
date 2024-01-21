import '../../../../core/data/models/times_options_model.dart';
import '../datasources/product_details_remote_data_source.dart';
import '../model/combination_attributes_model.dart';
import '../model/conditional_attributes_model.dart';
import '../model/product_details_model.dart';

abstract class ProductDetailsRepository {
  Future<ProductDetailsModel> loadProductDetails(int productId);

  Future<List<TimesOptionModel>> getTimes(
      {required int productId, required String date});

  // Future<SliderModel> loadProductDetailsSlider(int id);

  Future<List<ConditionalAttributesModel>>
      loadProductDetailsConditionalAttributes(int productId);

  Future<List<CombinationAttributesModel>>
      loadProductDetailsCombinationAttributes(int productId);

  // Future<String> uploadProductFiles(String id,File file);
}

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource _productDetailsRemoteDataSource;
  ProductDetailsRepositoryImpl(this._productDetailsRemoteDataSource);

  @override
  Future<ProductDetailsModel> loadProductDetails(int productId) =>
      _productDetailsRemoteDataSource.loadProductDetailsData(productId);

  // @override
  // Future<SliderModel> loadProductDetailsSlider(int productId) =>
  //     _productDetailsRemoteDataSource.loadProductDetailsSlider(productId);

  @override
  Future<List<ConditionalAttributesModel>>
      loadProductDetailsConditionalAttributes(int productId) =>
          _productDetailsRemoteDataSource
              .loadProductDetailsConditionalAttributes(productId);

  @override
  Future<List<CombinationAttributesModel>>
      loadProductDetailsCombinationAttributes(int productId) =>
          _productDetailsRemoteDataSource
              .loadProductDetailsCombinationAttributes(productId);

  @override
  Future<List<TimesOptionModel>> getTimes(
          {required int productId, required String date}) =>
      _productDetailsRemoteDataSource.getTimes(
          productId: productId, date: date);

  // @override
  // Future<String> uploadProductFiles(String id, File file) =>
  //     _productDetailsRemoteDataSource.uploadProductFilesData(id, file);
}
