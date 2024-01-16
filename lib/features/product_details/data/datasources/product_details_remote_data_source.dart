import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../model/combination_attributes_model.dart';
import '../model/conditional_attributes_model.dart';
import '../model/product_details_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> loadProductDetailsData(int productId);
  // Future<SliderModel> loadProductDetailsSlider(int productId);
  Future<List<ConditionalAttributesModel>>
      loadProductDetailsConditionalAttributes(int productId);

  Future<List<CombinationAttributesModel>>
      loadProductDetailsCombinationAttributes(int productId);

  // Future<String> uploadProductFilesData(String id, File file);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final NetworkService _networkService;

  ProductDetailsRemoteDataSourceImpl(this._networkService);

  @override
  Future<ProductDetailsModel> loadProductDetailsData(int productId) {
    final url = ApiEndPoint.getProductDetailsData + productId.toString();
    final params = {'getFavoriteCount': true, 'getRelatedProducts': true};

    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return ProductDetailsModel.fromMap(result['Data']);
    });
  }

  @override
  Future<List<ConditionalAttributesModel>>
      loadProductDetailsConditionalAttributes(int productId) {
    const url = ApiEndPoint.GET_PRODUCT_DETAILS_CONDITIONAL_ATTRIBUTES_DATA;

    return _networkService
        .get(url, queryParameters: {"productId": productId}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return (result['Data'] as List)
          .map((attributeMap) =>
              ConditionalAttributesModel.fromMap(attributeMap))
          .toList();
    });
  }

  @override
  Future<List<CombinationAttributesModel>>
      loadProductDetailsCombinationAttributes(int productId) {
    final url = ApiEndPoint.GET_PRODUCT_DETAILS_COMBINATION_ATTRIBUTES_DATA +
        productId.toString();

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return (result['Data'] as List)
          .map((attributeMap) =>
              CombinationAttributesModel.fromMap(attributeMap))
          .toList();
    });
  }

  // @override
  // Future<SliderModel> loadProductDetailsSlider(int productId) {
  //   const url = ApiEndPoint.GET_PRODUCT_DETAILS_SLIDER_DATA;

  //   return _networkService
  //       .get(url, queryParameters: {"productId": productId}).then((response) {
  //     if (response.statusCode != 200) throw RequestException(response.data);
  //     final result = response.data;

  //     return SliderModel.fromMap(result);
  //   });
  // }

  // @override
  // Future<String> uploadProductFilesData(String id, File file) async {
  //   final url = ApiEndPoint.UPLOAD_PRODUCT_ATTRIBUTE_FILE + id.toString();
  //   late dynamic result;

  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(file.path,
  //         filename: file.path.split('/').last),
  //   });
  //   await _networkService
  //       .post(
  //     url,
  //     data: formData,
  //   )
  //       .then((response) {
  //     if (response.statusCode != 200) throw RequestException(response.data);
  //     result = response.data;

  //     if (result['success'] != true) throw RequestException(result['message']);
  //   });

  //   return result['downloadGuid'];
  // }
}
