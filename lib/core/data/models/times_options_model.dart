import 'dart:convert';

class TimesOptionModel {
  final int? id;
  final String? title;
  final String? day;
  final num? cost;
  final String? start;
  final String? end;
  final bool? isAvailable;
  final int? quantity;
  final int? productAttributeId;
  final bool? isMorning;
  final int? remainingQuantity;
  TimesOptionModel({
    this.id,
    this.title,
    this.day,
    this.cost,
    this.start,
    this.end,
    this.isAvailable,
    this.quantity,
    this.productAttributeId,
    this.isMorning,
    this.remainingQuantity,
  });

  TimesOptionModel copyWith({
    int? id,
    String? title,
    String? day,
    num? cost,
    String? start,
    String? end,
    bool? isAvailable,
    int? quantity,
    int? productAttributeId,
    bool? isMorning,
    int? remainingQuantity,
  }) {
    return TimesOptionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      day: day ?? this.day,
      cost: cost ?? this.cost,
      start: start ?? this.start,
      end: end ?? this.end,
      isAvailable: isAvailable ?? this.isAvailable,
      quantity: quantity ?? this.quantity,
      productAttributeId: productAttributeId ?? this.productAttributeId,
      isMorning: isMorning ?? this.isMorning,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'day': day,
      'cost': cost,
      'start': start,
      'end': end,
      'isAvailable': isAvailable,
      'quantity': quantity,
      'productAttributeId': productAttributeId,
      'isMorning': isMorning,
      'remainingQuantity': remainingQuantity,
    };
  }

  factory TimesOptionModel.fromMap(Map<String, dynamic> map) {
    return TimesOptionModel(
      id: map['id']?.toInt(),
      title: map['title'],
      day: map['day'],
      cost: map['cost'],
      start: map['start'],
      end: map['end'],
      isAvailable: map['isAvailable'],
      quantity: map['quantity']?.toInt(),
      productAttributeId: map['productAttributeId']?.toInt(),
      isMorning: map['isMorning'],
      remainingQuantity: map['remainingQuantity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimesOptionModel.fromJson(String source) =>
      TimesOptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TimesOptionModel(id: $id, title: $title, day: $day, cost: $cost, start: $start, end: $end, isAvailable: $isAvailable, quantity: $quantity, productAttributeId: $productAttributeId, isMorning: $isMorning, remainingQuantity: $remainingQuantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimesOptionModel &&
        other.id == id &&
        other.title == title &&
        other.day == day &&
        other.cost == cost &&
        other.start == start &&
        other.end == end &&
        other.isAvailable == isAvailable &&
        other.quantity == quantity &&
        other.productAttributeId == productAttributeId &&
        other.isMorning == isMorning &&
        other.remainingQuantity == remainingQuantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        day.hashCode ^
        cost.hashCode ^
        start.hashCode ^
        end.hashCode ^
        isAvailable.hashCode ^
        quantity.hashCode ^
        productAttributeId.hashCode ^
        isMorning.hashCode ^
        remainingQuantity.hashCode;
  }
}
