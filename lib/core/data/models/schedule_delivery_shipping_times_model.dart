import 'dart:convert';

class ScheduleDeliveryShippingTimesModel {
  int? id;
  int? dayId;
  String? fromTime;
  String? toTime;
  String? fullTimeText;
  int? capacity;
  bool? isAvailable;
  ScheduleDeliveryShippingTimesModel({
    this.id,
    this.dayId,
    this.fromTime,
    this.toTime,
    this.fullTimeText,
    this.capacity,
    this.isAvailable,
  });

  ScheduleDeliveryShippingTimesModel copyWith({
    int? id,
    int? dayId,
    String? fromTime,
    String? toTime,
    String? fullTimeText,
    int? capacity,
    bool? isAvailable,
  }) {
    return ScheduleDeliveryShippingTimesModel(
      id: id ?? this.id,
      dayId: dayId ?? this.dayId,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      fullTimeText: fullTimeText ?? this.fullTimeText,
      capacity: capacity ?? this.capacity,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dayId': dayId,
      'fromTime': fromTime,
      'toTime': toTime,
      'fullTimeText': fullTimeText,
      'capacity': capacity,
      'isAvailable': isAvailable,
    };
  }

  factory ScheduleDeliveryShippingTimesModel.fromMap(Map<String, dynamic> map) {
    return ScheduleDeliveryShippingTimesModel(
      id: map['id']?.toInt(),
      dayId: map['dayId']?.toInt(),
      fromTime: map['fromTime'],
      toTime: map['toTime'],
      fullTimeText: map['fullTimeText'],
      capacity: map['capacity']?.toInt(),
      isAvailable: map['isAvailable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleDeliveryShippingTimesModel.fromJson(String source) => ScheduleDeliveryShippingTimesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleDeliveryShippingTimesModel(id: $id, dayId: $dayId, fromTime: $fromTime, toTime: $toTime, fullTimeText: $fullTimeText, capacity: $capacity, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ScheduleDeliveryShippingTimesModel &&
      other.id == id &&
      other.dayId == dayId &&
      other.fromTime == fromTime &&
      other.toTime == toTime &&
      other.fullTimeText == fullTimeText &&
      other.capacity == capacity &&
      other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      dayId.hashCode ^
      fromTime.hashCode ^
      toTime.hashCode ^
      fullTimeText.hashCode ^
      capacity.hashCode ^
      isAvailable.hashCode;
  }
}
