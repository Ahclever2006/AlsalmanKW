import 'dart:convert';

class PriceRangeModel {
  final num from;
  final num to;
  PriceRangeModel({
    required this.from,
    required this.to,
  });

  PriceRangeModel copyWith({
    num? from,
    num? to,
  }) {
    return PriceRangeModel(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
    };
  }

  factory PriceRangeModel.fromMap(Map<String, dynamic> map) {
    return PriceRangeModel(
      from: map['from'] ?? 0,
      to: map['to'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceRangeModel.fromJson(String source) =>
      PriceRangeModel.fromMap(json.decode(source));

  @override
  String toString() => 'PriceRangeModel(from: $from, to: $to)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceRangeModel && other.from == from && other.to == to;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
