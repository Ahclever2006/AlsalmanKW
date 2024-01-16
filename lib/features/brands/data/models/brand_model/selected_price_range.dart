import 'dart:convert';

import 'package:collection/collection.dart';

class SelectedPriceRange {
  dynamic from;
  dynamic to;

  SelectedPriceRange({this.from, this.to});

  @override
  String toString() {
    return 'SelectedPriceRange(from: $from, to: $to)';
  }

  factory SelectedPriceRange.fromMap(Map<String, dynamic> data) {
    return SelectedPriceRange(
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
  /// Parses the string and returns the resulting Json object as [SelectedPriceRange].
  factory SelectedPriceRange.fromJson(String data) {
    return SelectedPriceRange.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SelectedPriceRange] to a JSON string.
  String toJson() => json.encode(toMap());

  SelectedPriceRange copyWith({
    dynamic from,
    dynamic to,
  }) {
    return SelectedPriceRange(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SelectedPriceRange) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
