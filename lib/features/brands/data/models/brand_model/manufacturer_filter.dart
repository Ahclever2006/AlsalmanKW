import 'dart:convert';

import 'package:collection/collection.dart';

class ManufacturerFilter {
  bool? enabled;
  List<dynamic>? manufacturers;

  ManufacturerFilter({
    this.enabled,
    this.manufacturers,
  });

  @override
  String toString() {
    return 'ManufacturerFilter(enabled: $enabled, manufacturers: $manufacturers)';
  }

  factory ManufacturerFilter.fromMap(Map<String, dynamic> data) {
    return ManufacturerFilter(
      enabled: data['enabled']?.toString().contains("true"),
      manufacturers: List<dynamic>.from(data['manufacturers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        if (enabled != null) 'enabled': enabled,
        if (manufacturers != null) 'manufacturers': manufacturers,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ManufacturerFilter].
  factory ManufacturerFilter.fromJson(String data) {
    return ManufacturerFilter.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ManufacturerFilter] to a JSON string.
  String toJson() => json.encode(toMap());

  ManufacturerFilter copyWith({
    bool? enabled,
    List<dynamic>? manufacturers,
  }) {
    return ManufacturerFilter(
      enabled: enabled ?? this.enabled,
      manufacturers: manufacturers ?? this.manufacturers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ManufacturerFilter) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => enabled.hashCode ^ manufacturers.hashCode;
}
