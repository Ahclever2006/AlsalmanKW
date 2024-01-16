import 'dart:convert';

import 'package:collection/collection.dart';

import 'manufacturer_filter.dart';
import 'price_range_filter.dart';
import 'specification_filter.dart';

class CatalogProductsModel {
  bool? useAjaxLoading;
  dynamic warningMessage;
  dynamic noResultMessage;
  PriceRangeFilter? priceRangeFilter;
  SpecificationFilter? specificationFilter;
  ManufacturerFilter? manufacturerFilter;
  bool? allowProductSorting;
  List<dynamic>? availableSortOptions;
  bool? allowProductViewModeChanging;
  List<dynamic>? availableViewModes;
  bool? allowCustomersToSelectPageSize;
  List<dynamic>? pageSizeOptions;
  dynamic orderBy;
  dynamic viewMode;
  List<dynamic>? products;
  num? pageIndex;
  num? pageNumber;
  num? pageSize;
  num? totalItems;
  num? totalPages;
  num? firstItem;
  num? lastItem;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CatalogProductsModel({
    this.useAjaxLoading,
    this.warningMessage,
    this.noResultMessage,
    this.priceRangeFilter,
    this.specificationFilter,
    this.manufacturerFilter,
    this.allowProductSorting,
    this.availableSortOptions,
    this.allowProductViewModeChanging,
    this.availableViewModes,
    this.allowCustomersToSelectPageSize,
    this.pageSizeOptions,
    this.orderBy,
    this.viewMode,
    this.products,
    this.pageIndex,
    this.pageNumber,
    this.pageSize,
    this.totalItems,
    this.totalPages,
    this.firstItem,
    this.lastItem,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  @override
  String toString() {
    return 'CatalogProductsModel(useAjaxLoading: $useAjaxLoading, warningMessage: $warningMessage, noResultMessage: $noResultMessage, priceRangeFilter: $priceRangeFilter, specificationFilter: $specificationFilter, manufacturerFilter: $manufacturerFilter, allowProductSorting: $allowProductSorting, availableSortOptions: $availableSortOptions, allowProductViewModeChanging: $allowProductViewModeChanging, availableViewModes: $availableViewModes, allowCustomersToSelectPageSize: $allowCustomersToSelectPageSize, pageSizeOptions: $pageSizeOptions, orderBy: $orderBy, viewMode: $viewMode, products: $products, pageIndex: $pageIndex, pageNumber: $pageNumber, pageSize: $pageSize, totalItems: $totalItems, totalPages: $totalPages, firstItem: $firstItem, lastItem: $lastItem, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
  }

  factory CatalogProductsModel.fromMap(Map<String, dynamic> data) {
    return CatalogProductsModel(
      useAjaxLoading: data['use_ajax_loading']?.toString().contains("true"),
      warningMessage: data['warning_message'],
      noResultMessage: data['no_result_message'],
      priceRangeFilter: data['price_range_filter'] == null
          ? null
          : PriceRangeFilter.fromMap(
              Map<String, dynamic>.from(data['price_range_filter'])),
      specificationFilter: data['specification_filter'] == null
          ? null
          : SpecificationFilter.fromMap(
              Map<String, dynamic>.from(data['specification_filter'])),
      manufacturerFilter: data['manufacturer_filter'] == null
          ? null
          : ManufacturerFilter.fromMap(
              Map<String, dynamic>.from(data['manufacturer_filter'])),
      allowProductSorting:
          data['allow_product_sorting']?.toString().contains("true"),
      availableSortOptions:
          List<dynamic>.from(data['available_sort_options'] ?? []),
      allowProductViewModeChanging:
          data['allow_product_view_mode_changing']?.toString().contains("true"),
      availableViewModes:
          List<dynamic>.from(data['available_view_modes'] ?? []),
      allowCustomersToSelectPageSize:
          data['allow_customers_to_select_page_size']
              ?.toString()
              .contains("true"),
      pageSizeOptions: List<dynamic>.from(data['page_size_options'] ?? []),
      orderBy: data['order_by'],
      viewMode: data['view_mode'],
      products: List<dynamic>.from(data['products'] ?? []),
      pageIndex: num.tryParse(data['page_index'].toString()),
      pageNumber: num.tryParse(data['page_number'].toString()),
      pageSize: num.tryParse(data['page_size'].toString()),
      totalItems: num.tryParse(data['total_items'].toString()),
      totalPages: num.tryParse(data['total_pages'].toString()),
      firstItem: num.tryParse(data['first_item'].toString()),
      lastItem: num.tryParse(data['last_item'].toString()),
      hasPreviousPage: data['has_previous_page']?.toString().contains("true"),
      hasNextPage: data['has_next_page']?.toString().contains("true"),
    );
  }

  Map<String, dynamic> toMap() => {
        if (useAjaxLoading != null) 'use_ajax_loading': useAjaxLoading,
        if (warningMessage != null) 'warning_message': warningMessage,
        if (noResultMessage != null) 'no_result_message': noResultMessage,
        if (priceRangeFilter != null)
          'price_range_filter': priceRangeFilter?.toMap(),
        if (specificationFilter != null)
          'specification_filter': specificationFilter?.toMap(),
        if (manufacturerFilter != null)
          'manufacturer_filter': manufacturerFilter?.toMap(),
        if (allowProductSorting != null)
          'allow_product_sorting': allowProductSorting,
        if (availableSortOptions != null)
          'available_sort_options': availableSortOptions,
        if (allowProductViewModeChanging != null)
          'allow_product_view_mode_changing': allowProductViewModeChanging,
        if (availableViewModes != null)
          'available_view_modes': availableViewModes,
        if (allowCustomersToSelectPageSize != null)
          'allow_customers_to_select_page_size': allowCustomersToSelectPageSize,
        if (pageSizeOptions != null) 'page_size_options': pageSizeOptions,
        if (orderBy != null) 'order_by': orderBy,
        if (viewMode != null) 'view_mode': viewMode,
        if (products != null) 'products': products,
        if (pageIndex != null) 'page_index': pageIndex,
        if (pageNumber != null) 'page_number': pageNumber,
        if (pageSize != null) 'page_size': pageSize,
        if (totalItems != null) 'total_items': totalItems,
        if (totalPages != null) 'total_pages': totalPages,
        if (firstItem != null) 'first_item': firstItem,
        if (lastItem != null) 'last_item': lastItem,
        if (hasPreviousPage != null) 'has_previous_page': hasPreviousPage,
        if (hasNextPage != null) 'has_next_page': hasNextPage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CatalogProductsModel].
  factory CatalogProductsModel.fromJson(String data) {
    return CatalogProductsModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CatalogProductsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CatalogProductsModel copyWith({
    bool? useAjaxLoading,
    dynamic warningMessage,
    dynamic noResultMessage,
    PriceRangeFilter? priceRangeFilter,
    SpecificationFilter? specificationFilter,
    ManufacturerFilter? manufacturerFilter,
    bool? allowProductSorting,
    List<dynamic>? availableSortOptions,
    bool? allowProductViewModeChanging,
    List<dynamic>? availableViewModes,
    bool? allowCustomersToSelectPageSize,
    List<dynamic>? pageSizeOptions,
    dynamic orderBy,
    dynamic viewMode,
    List<dynamic>? products,
    num? pageIndex,
    num? pageNumber,
    num? pageSize,
    num? totalItems,
    num? totalPages,
    num? firstItem,
    num? lastItem,
    bool? hasPreviousPage,
    bool? hasNextPage,
  }) {
    return CatalogProductsModel(
      useAjaxLoading: useAjaxLoading ?? this.useAjaxLoading,
      warningMessage: warningMessage ?? this.warningMessage,
      noResultMessage: noResultMessage ?? this.noResultMessage,
      priceRangeFilter: priceRangeFilter ?? this.priceRangeFilter,
      specificationFilter: specificationFilter ?? this.specificationFilter,
      manufacturerFilter: manufacturerFilter ?? this.manufacturerFilter,
      allowProductSorting: allowProductSorting ?? this.allowProductSorting,
      availableSortOptions: availableSortOptions ?? this.availableSortOptions,
      allowProductViewModeChanging:
          allowProductViewModeChanging ?? this.allowProductViewModeChanging,
      availableViewModes: availableViewModes ?? this.availableViewModes,
      allowCustomersToSelectPageSize:
          allowCustomersToSelectPageSize ?? this.allowCustomersToSelectPageSize,
      pageSizeOptions: pageSizeOptions ?? this.pageSizeOptions,
      orderBy: orderBy ?? this.orderBy,
      viewMode: viewMode ?? this.viewMode,
      products: products ?? this.products,
      pageIndex: pageIndex ?? this.pageIndex,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      firstItem: firstItem ?? this.firstItem,
      lastItem: lastItem ?? this.lastItem,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CatalogProductsModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      useAjaxLoading.hashCode ^
      warningMessage.hashCode ^
      noResultMessage.hashCode ^
      priceRangeFilter.hashCode ^
      specificationFilter.hashCode ^
      manufacturerFilter.hashCode ^
      allowProductSorting.hashCode ^
      availableSortOptions.hashCode ^
      allowProductViewModeChanging.hashCode ^
      availableViewModes.hashCode ^
      allowCustomersToSelectPageSize.hashCode ^
      pageSizeOptions.hashCode ^
      orderBy.hashCode ^
      viewMode.hashCode ^
      products.hashCode ^
      pageIndex.hashCode ^
      pageNumber.hashCode ^
      pageSize.hashCode ^
      totalItems.hashCode ^
      totalPages.hashCode ^
      firstItem.hashCode ^
      lastItem.hashCode ^
      hasPreviousPage.hashCode ^
      hasNextPage.hashCode;
}
