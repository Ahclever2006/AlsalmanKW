import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/times_options_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../../../core/service/dynamic_link_service.dart';
import '../../../../../core/service/share_service.dart';
import '../../../../cart_tab/data/repositories/cart_repository.dart';
import '../../../../favorites/data/repositories/favorites_repository.dart';
import '../../../data/model/combination_attributes_model.dart';
import '../../../data/model/conditional_attributes_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../../data/repositories/product_details_repository_impl.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends BaseCubit<ProductDetailsState> {
  ProductDetailsCubit(
    this._productDetailsRepository,
    this._cartRepository,
    this._favoritesRepository,
    this._shareService,
    this._dynamicLinkService,
  ) : super(const ProductDetailsState());

  final ProductDetailsRepository _productDetailsRepository;
  final CartRepository _cartRepository;
  final FavoritesRepository _favoritesRepository;
  final ShareService _shareService;
  final DynamicLinkService _dynamicLinkService;

  //Map for what the user choose from our attributes
  // Map<String, dynamic> selectedAttributesList = {};

  //List for conditional attributes to show in UI.
  List<ProductAttribute>? showConditionalAttributes = [];

  Future<void> getProductDetailsData(int productId,
      [bool refresh = false]) async {
    final ProductDetailsModel productDetailsData;

    try {
      if (!refresh)
        emit(state.copyWith(
          status: ProductDetailsStateStatus.loading,
          showConditionalAttributes: showConditionalAttributes,
          productPrice: 0.0,
        ));

      productDetailsData =
          await _productDetailsRepository.loadProductDetails(productId);
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        productDetailsData: productDetailsData,
        showConditionalAttributes: showConditionalAttributes,
        productPrice:
            productDetailsData.productDetailsModel?.productPrice?.priceValue,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
    }
  }

  Future<void> refresh(int productId) => getProductDetailsData(productId, true);

  void setBookingFeatureEnable() {
    emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        isBookingFeatureEnable: true));
  }

  Future<void> loadTimes({
    required int productId,
    required String date,
  }) async {
    try {
      emit(state.copyWith(status: ProductDetailsStateStatus.loading));
      final timesList = await _productDetailsRepository.getTimes(
          productId: productId, date: date);

      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        timesList: timesList,
        date: date,
        timeId: -1,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: ProductDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }

  void setTime(int id) {
    emit(state.copyWith(status: ProductDetailsStateStatus.loaded, timeId: id));
  }

  Future<void> getProductDetailsCombinationAttributesData(
    int productId,
  ) async {
    final List<CombinationAttributesModel> combinationAttributes;
    try {
      combinationAttributes = await _productDetailsRepository
          .loadProductDetailsCombinationAttributes(productId);
      emit(state.copyWith(
          status: ProductDetailsStateStatus.loaded,
          combinationAttributesModel: combinationAttributes));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: ProductDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getProductDetailsConditionalAttributesData(
    int productId,
  ) async {
    final List<ConditionalAttributesModel> conditionalAttributes;
    try {
      conditionalAttributes = await _productDetailsRepository
          .loadProductDetailsConditionalAttributes(productId);
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        conditionalAttributesModel: conditionalAttributes,
        showConditionalAttributes: showConditionalAttributes,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
    }
  }

  void addToAttributeList(Map<String, dynamic> map) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loading,
      showConditionalAttributes: showConditionalAttributes,
    ));

    var selectedAttributesList = state.selectedAttributesList ?? {};
    selectedAttributesList.addAll(map);

    // create combination && check equality
    List<String> selectedValuesToCompare = [];
    Map<String, List<String>> valuesToCompare = {};
    selectedAttributesList.forEach((key, value) {
      selectedValuesToCompare.add(value);
    });

    state.combinationAttributesModel?.forEach((e) {
      List<String> tempList = [];
      e.attributes?.forEach((x) {
        tempList.addAll(x.valueIds!.map((e) => e.toString()).toList());
      });

      valuesToCompare[e.pictureId.toString()] = tempList;
    });

    log('=============================');
    log(selectedValuesToCompare.toString());
    log(valuesToCompare.toString());

    log('=============================');

    valuesToCompare.values.forEach((values) {
      bool containsElement =
          values.every((element) => selectedValuesToCompare.contains(element));
      if (containsElement) {
        //change image id
        for (var entry in valuesToCompare.entries) {
          if (entry.value == values) {
            changeImageId(int.parse(entry.key));
          }
        }
      }
    });
    log('=============================');

    showConditionalAttributes!.clear();
    if (state.conditionalAttributesModel != null)
      for (var item in state.conditionalAttributesModel!) {
        if (selectedAttributesList.values
            .contains(item.dependToOptionId.toString())) {
          showConditionalAttributes!.add(state
              .productDetailsData!.productDetailsModel!.productAttributes!
              .firstWhere((e) => e.id == item.productAttributeMappingId));
        }
      }

    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      selectedAttributesList: selectedAttributesList,
      showConditionalAttributes: showConditionalAttributes,
    ));
  }

  void removeFromAttributeList(String key) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loading,
      showConditionalAttributes: showConditionalAttributes,
    ));

    var selectedAttributesList = state.selectedAttributesList ?? {};
    selectedAttributesList.remove(key);
    showConditionalAttributes!.clear();
    for (var item in state.conditionalAttributesModel!) {
      if (selectedAttributesList.values
          .contains(item.dependToOptionId.toString())) {
        showConditionalAttributes!.add(state
            .productDetailsData!.productDetailsModel!.productAttributes!
            .firstWhere((e) => e.id == item.productAttributeMappingId));
      }
    }

    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      selectedAttributesList: selectedAttributesList,
      showConditionalAttributes: showConditionalAttributes,
    ));
  }

  void createTextMessageOnProduct(String text) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      text: text,
    ));
  }

  void createTextMessageDotsInitialStatus(bool isDotsBetweenInitials) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      isDotsBetweenInitials: isDotsBetweenInitials,
    ));
  }

  void createTexColor(String? color) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      textColor: color,
    ));
  }

  void changeImageId(int? imageId) {
    if (imageId != 0)
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        imageId: imageId,
      ));
  }

  void createTexFontFamily(String? fontFamily) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      fontFamily: fontFamily,
    ));
  }

  void createTexFontSize(double? fontSize) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loaded,
      fontSize: fontSize,
    ));
  }

  num? newPrice;

  void adjustProductPrice(num priceValue) {
    emit(state.copyWith(
      status: ProductDetailsStateStatus.loading,
      showConditionalAttributes: showConditionalAttributes,
      productPrice: newPrice ?? state.productPrice,
    ));
    newPrice = state.productPrice! + priceValue;
    Future.delayed(Duration.zero, () {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice,
      ));
    });
  }

  Future<bool> addProductToFav(String id, Map<String, dynamic> data) async {
    try {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loading,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
      await _favoritesRepository.addToFav(id, data);

      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));

      return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));

      return false;
    }
  }

  Future<bool> removeProductFromFav(String id) async {
    try {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loading,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
      await _favoritesRepository.removeFromFav(id);

      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));

      return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
      return false;
    }
  }

  Future<void> addProductToCart(
      String id, int quantity, Map<String, dynamic> data) async {
    try {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
      await _cartRepository.addToCart(id, quantity, data);

      emit(state.copyWith(
        status: ProductDetailsStateStatus.productAddedToCart,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
    }
  }

  Future<bool> uploadProductFile(String id, File file) async {
    // var previousState = state;
    try {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.loading,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));

      // final result = await _uploadProductFilesUseCase.call(
      //     state.productDetailsData!.productDetailsModel!.id.toString(), file);

      //if (result != null) addToAttributeList({'product_attribute_$id': result});

      emit(state.copyWith(
        status: ProductDetailsStateStatus.productFileUploaded,
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));

      return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
      return false;
    }
  }

  Future<void> openProductSample() async {
    // final id = state.productDetailsData!.productDetailsModel!.id.toString();
    try {
      // await _openFileUseCase.call(
      //     'https://appapi.baramjk.com/download/sample/$id', 'pdf', 'sample$id');
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStateStatus.error,
        errorMessage: e.toString(),
        showConditionalAttributes: showConditionalAttributes,
        productPrice: newPrice ?? state.productPrice,
      ));
    }
  }

  void autoChangedCarouselIndex(int index) {
    emit(state.copyWith(
        status: ProductDetailsStateStatus.loaded, bannerIndex: index));
  }

  Future<void> shareProduct(Rect? sharePositionOrigin, String link) async {
    var product = state.productDetailsData!.productDetailsModel!;
    final dynamicLink = await _dynamicLinkService.createProductLink(
        id: product.id!,
        name: product.name!,
        seName: product.seName!,
        description: product.fullDescription ?? '',
        imageUrl: product.defaultPictureModel!.imageUrl!);
    await _shareService.shareLink(
      dynamicLink,
      //TODO: check later if we need this link or keep work with dynamic link
      // link,
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}
