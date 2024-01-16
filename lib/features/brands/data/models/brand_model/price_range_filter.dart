import 'dart:convert';

import 'package:collection/collection.dart';

import 'available_price_range.dart';
import 'selected_price_range.dart';

class PriceRangeFilter {
  bool? enabled;
  SelectedPriceRange? selectedPriceRange;
  AvailablePriceRange? availablePriceRange;

  PriceRangeFilter({
    this.enabled,
    this.selectedPriceRange,
    this.availablePriceRange,
  });

  @override
  String toString() {
    return 'PriceRangeFilter(enabled: $enabled, selectedPriceRange: $selectedPriceRange, availablePriceRange: $availablePriceRange)';
  }

  factory PriceRangeFilter.fromMap(Map<String, dynamic> data) {
    return PriceRangeFilter(
      enabled: data['enabled']?.toString().contains("true"),
      selectedPriceRange: data['selected_price_range'] == null
          ? null
          : SelectedPriceRange.fromMap(
              Map<String, dynamic>.from(data['selected_price_range'])),
      availablePriceRange: data['available_price_range'] == null
          ? null
          : AvailablePriceRange.fromMap(
              Map<String, dynamic>.from(data['available_price_range'])),
    );
  }

  Map<String, dynamic> toMap() => {
        if (enabled != null) 'enabled': enabled,
        if (selectedPriceRange != null)
          'selected_price_range': selectedPriceRange?.toMap(),
        if (availablePriceRange != null)
          'available_price_range': availablePriceRange?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PriceRangeFilter].
  factory PriceRangeFilter.fromJson(String data) {
    return PriceRangeFilter.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PriceRangeFilter] to a JSON string.
  String toJson() => json.encode(toMap());

  PriceRangeFilter copyWith({
    bool? enabled,
    SelectedPriceRange? selectedPriceRange,
    AvailablePriceRange? availablePriceRange,
  }) {
    return PriceRangeFilter(
      enabled: enabled ?? this.enabled,
      selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
      availablePriceRange: availablePriceRange ?? this.availablePriceRange,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PriceRangeFilter) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      enabled.hashCode ^
      selectedPriceRange.hashCode ^
      availablePriceRange.hashCode;
}
