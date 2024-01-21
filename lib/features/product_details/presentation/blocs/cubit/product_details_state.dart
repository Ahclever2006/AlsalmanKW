part of 'product_details_cubit.dart';

enum ProductDetailsStateStatus {
  initial,
  loading,
  loaded,
  productAddedToCart,
  productFileUploaded,
  error
}

extension ProductDetailsStateX on ProductDetailsState {
  bool get isInitial => status == ProductDetailsStateStatus.initial;
  bool get isLoading => status == ProductDetailsStateStatus.loading;
  bool get isLoaded => status == ProductDetailsStateStatus.loaded;
  bool get isProductAddedToCart =>
      status == ProductDetailsStateStatus.productAddedToCart;
  bool get isProductFileUploaded =>
      status == ProductDetailsStateStatus.productFileUploaded;
  bool get isError => status == ProductDetailsStateStatus.error;
}

@immutable
class ProductDetailsState {
  final ProductDetailsStateStatus status;
  final ProductDetailsModel? productDetailsData;
  final List<ConditionalAttributesModel>? conditionalAttributesModel;
  final List<CombinationAttributesModel>? combinationAttributesModel;
  final Map<String, dynamic>? selectedAttributesList;
  final List<ProductAttribute>? showConditionalAttributes;
  final num? productPrice;
  final List<String>? imageFiles;
  final int bannerIndex;
  final String? text;
  final String? textColor;
  final String? fontFamily;
  final double? fontSize;
  final int? imageId;
  final bool? isDotsBetweenInitials;
  final bool? isBookingFeatureEnable;
  final int? timeId;
  final String? date;
  final List<TimesOptionModel>? timesList;
  final String? errorMessage;

  const ProductDetailsState({
    this.status = ProductDetailsStateStatus.initial,
    this.bannerIndex = 0,
    this.productDetailsData,
    this.conditionalAttributesModel,
    this.combinationAttributesModel,
    this.selectedAttributesList,
    this.showConditionalAttributes,
    this.productPrice,
    this.imageFiles,
    this.text,
    this.textColor,
    this.fontFamily,
    this.fontSize,
    this.imageId,
    this.isDotsBetweenInitials,
    this.isBookingFeatureEnable = false,
    this.timeId,
    this.date,
    this.timesList,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as ProductDetailsState).status == status &&
        other.productDetailsData == productDetailsData &&
        other.selectedAttributesList == selectedAttributesList &&
        other.productPrice == productPrice &&
        other.imageFiles == imageFiles &&
        other.bannerIndex == bannerIndex &&
        other.text == text &&
        other.textColor == textColor &&
        other.fontFamily == fontFamily &&
        other.fontSize == fontSize &&
        other.imageId == imageId &&
        other.isDotsBetweenInitials == isDotsBetweenInitials &&
        other.isBookingFeatureEnable == isBookingFeatureEnable &&
        other.date == date &&
        other.timeId == timeId &&
        listEquals(other.timesList, timesList) &&
        other.errorMessage == errorMessage &&
        listEquals(
            other.conditionalAttributesModel, conditionalAttributesModel) &&
        listEquals(
            other.combinationAttributesModel, combinationAttributesModel) &&
        listEquals(other.showConditionalAttributes, showConditionalAttributes);
  }

  @override
  int get hashCode =>
      productDetailsData.hashCode ^
      conditionalAttributesModel.hashCode ^
      combinationAttributesModel.hashCode ^
      selectedAttributesList.hashCode ^
      status.hashCode ^
      productPrice.hashCode ^
      imageFiles.hashCode ^
      bannerIndex.hashCode ^
      showConditionalAttributes.hashCode ^
      text.hashCode ^
      textColor.hashCode ^
      fontFamily.hashCode ^
      fontSize.hashCode ^
      imageId.hashCode ^
      isDotsBetweenInitials.hashCode ^
      isBookingFeatureEnable.hashCode ^
      timeId.hashCode ^
      errorMessage.hashCode ^
      timesList.hashCode ^
      errorMessage.hashCode;

  ProductDetailsState copyWith({
    ProductDetailsStateStatus? status,
    ProductDetailsModel? productDetailsData,
    List<ConditionalAttributesModel>? conditionalAttributesModel,
    List<CombinationAttributesModel>? combinationAttributesModel,
    Map<String, dynamic>? selectedAttributesList,
    List<ProductAttribute>? showConditionalAttributes,
    num? productPrice,
    List<String>? imageFiles,
    String? errorMessage,
    int? bannerIndex,
    String? text,
    String? textColor,
    String? fontFamily,
    double? fontSize,
    int? imageId,
    bool? isDotsBetweenInitials,
    bool? isBookingFeatureEnable,
    int? timeId,
    String? date,
    List<TimesOptionModel>? timesList,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      productDetailsData: productDetailsData ?? this.productDetailsData,
      conditionalAttributesModel:
          conditionalAttributesModel ?? this.conditionalAttributesModel,
      combinationAttributesModel:
          combinationAttributesModel ?? this.combinationAttributesModel,
      selectedAttributesList:
          selectedAttributesList ?? this.selectedAttributesList,
      showConditionalAttributes:
          showConditionalAttributes ?? this.showConditionalAttributes,
      productPrice: productPrice ?? this.productPrice,
      imageFiles: imageFiles ?? this.imageFiles,
      bannerIndex: bannerIndex ?? this.bannerIndex,
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      imageId: imageId ?? this.imageId,
      isDotsBetweenInitials:
          isDotsBetweenInitials ?? this.isDotsBetweenInitials,
      isBookingFeatureEnable:
          isBookingFeatureEnable ?? this.isBookingFeatureEnable,
      timeId: timeId ?? this.timeId,
      date: date ?? this.date,
      timesList: timesList ?? this.timesList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
