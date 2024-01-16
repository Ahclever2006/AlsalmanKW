import 'dart:convert';

class ScheduleDeliveryShippingMethodsModel {
  int? id;
  String? title;
  String? optionName;
  String? shippingMethodSystemName;
  String? description;
  num? price;
  int? capacity;
  String? type;
  bool? isAvailable;
  ScheduleDeliveryShippingMethodsModel({
    this.id,
    this.title,
    this.optionName,
    this.shippingMethodSystemName,
    this.description,
    this.price,
    this.capacity,
    this.type,
    this.isAvailable,
  });

  ScheduleDeliveryShippingMethodsModel copyWith({
    int? id,
    String? title,
    String? optionName,
    String? shippingMethodSystemName,
    String? description,
    num? price,
    int? capacity,
    String? type,
    bool? isAvailable,
  }) {
    return ScheduleDeliveryShippingMethodsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      optionName: optionName ?? this.optionName,
      shippingMethodSystemName:
          shippingMethodSystemName ?? this.shippingMethodSystemName,
      description: description ?? this.description,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      type: type ?? this.type,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'optionName': optionName,
      'shippingMethodSystemName': shippingMethodSystemName,
      'description': description,
      'price': price,
      'capacity': capacity,
      'type': type,
      'isAvailble': isAvailable,
    };
  }

  factory ScheduleDeliveryShippingMethodsModel.fromMap(
      Map<String, dynamic> map) {
    return ScheduleDeliveryShippingMethodsModel(
      id: map['id']?.toInt(),
      title: map['title'],
      optionName: map['optionName'],
      shippingMethodSystemName: map['shippingMethodSystemName'],
      description: map['description'],
      price: map['price'],
      capacity: map['capacity']?.toInt(),
      type: map['type'],
      isAvailable: map['isAvailble'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleDeliveryShippingMethodsModel.fromJson(String source) =>
      ScheduleDeliveryShippingMethodsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleDeliveryShippingMethodsModel(id: $id, title: $title, optionName: $optionName, shippingMethodSystemName: $shippingMethodSystemName, description: $description, price: $price, capacity: $capacity, type: $type, isAvailble: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScheduleDeliveryShippingMethodsModel &&
        other.id == id &&
        other.title == title &&
        other.optionName == optionName &&
        other.shippingMethodSystemName == shippingMethodSystemName &&
        other.description == description &&
        other.price == price &&
        other.capacity == capacity &&
        other.type == type &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        optionName.hashCode ^
        shippingMethodSystemName.hashCode ^
        description.hashCode ^
        price.hashCode ^
        capacity.hashCode ^
        type.hashCode ^
        isAvailable.hashCode;
  }
}
