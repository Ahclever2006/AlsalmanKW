import 'dart:convert';

import 'package:collection/collection.dart';

class SpecificationFilter {
  bool? enabled;
  List<dynamic>? attributes;

  SpecificationFilter({
    this.enabled,
    this.attributes,
  });

  @override
  String toString() {
    return 'SpecificationFilter(enabled: $enabled, attributes: $attributes)';
  }

  factory SpecificationFilter.fromMap(Map<String, dynamic> data) {
    return SpecificationFilter(
      enabled: data['enabled']?.toString().contains("true"),
      attributes: List<dynamic>.from(data['attributes'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        if (enabled != null) 'enabled': enabled,
        if (attributes != null) 'attributes': attributes,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SpecificationFilter].
  factory SpecificationFilter.fromJson(String data) {
    return SpecificationFilter.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SpecificationFilter] to a JSON string.
  String toJson() => json.encode(toMap());

  SpecificationFilter copyWith({
    bool? enabled,
    List<dynamic>? attributes,
  }) {
    return SpecificationFilter(
      enabled: enabled ?? this.enabled,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SpecificationFilter) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => enabled.hashCode ^ attributes.hashCode;
}
