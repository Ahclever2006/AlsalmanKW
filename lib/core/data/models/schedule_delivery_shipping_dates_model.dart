import 'dart:convert';

class ScheduleDeliveryShippingDatesModel {
  int? id;
  int? deliveryId;
  String? date;
  bool? isAvailable;
  ScheduleDeliveryShippingDatesModel({
    this.id,
    this.deliveryId,
    this.date,
    this.isAvailable,
  });

  ScheduleDeliveryShippingDatesModel copyWith({
    int? id,
    int? deliveryId,
    String? date,
    bool? isAvailable,
  }) {
    return ScheduleDeliveryShippingDatesModel(
      id: id ?? this.id,
      deliveryId: deliveryId ?? this.deliveryId,
      date: date ?? this.date,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deliveryId': deliveryId,
      'date': date,
      'isAvailable': isAvailable,
    };
  }

  factory ScheduleDeliveryShippingDatesModel.fromMap(Map<String, dynamic> map) {
    return ScheduleDeliveryShippingDatesModel(
      id: map['id']?.toInt(),
      deliveryId: map['deliveryId']?.toInt(),
      date: map['date'],
      isAvailable: map['isAvailable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleDeliveryShippingDatesModel.fromJson(String source) => ScheduleDeliveryShippingDatesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleDeliveryShippingDatesModel(id: $id, deliveryId: $deliveryId, date: $date, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ScheduleDeliveryShippingDatesModel &&
      other.id == id &&
      other.deliveryId == deliveryId &&
      other.date == date &&
      other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      deliveryId.hashCode ^
      date.hashCode ^
      isAvailable.hashCode;
  }
}
