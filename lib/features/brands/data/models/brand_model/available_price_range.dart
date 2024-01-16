import 'dart:convert';

import 'package:collection/collection.dart';

class AvailablePriceRange {
  dynamic from;
  dynamic to;

  AvailablePriceRange({this.from, this.to});

  @override
  String toString() {
    return 'AvailablePriceRange(from: $from, to: $to)';
  }

  factory AvailablePriceRange.fromMap(Map<String, dynamic> data) {
    return AvailablePriceRange(
      from: data['from'],
      to: data['to'],
    );
  }

  Map<String, dynamic> toMap() => {
        if (from != null) 'from': from,
        if (to != null) 'to': to,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AvailablePriceRange].
  factory AvailablePriceRange.fromJson(String data) {
    return AvailablePriceRange.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AvailablePriceRange] to a JSON string.
  String toJson() => json.encode(toMap());

  AvailablePriceRange copyWith({
    dynamic from,
    dynamic to,
  }) {
    return AvailablePriceRange(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AvailablePriceRange) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
