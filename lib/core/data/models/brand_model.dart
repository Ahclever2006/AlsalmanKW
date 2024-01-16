import 'dart:convert';

class CategoryBrandModel {
  final int id;
  final String name;
  final String description;
  final int displayOrder;
  CategoryBrandModel({
    required this.id,
    required this.name,
    required this.description,
    required this.displayOrder,
  });

  CategoryBrandModel copyWith({
    int? id,
    String? name,
    String? description,
    int? displayOrder,
  }) {
    return CategoryBrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'DisplayOrder': displayOrder,
    };
  }

  factory CategoryBrandModel.fromMap(Map<String, dynamic> map) {
    return CategoryBrandModel(
      id: map['Id']?.toInt() ?? 0,
      name: map['Name'] ?? '',
      description: map['Description'] ?? '',
      displayOrder: map['DisplayOrder']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryBrandModel.fromJson(String source) =>
      CategoryBrandModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryBrandModel(Id: $id, Name: $name, Description: $description, DisplayOrder: $displayOrder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryBrandModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.displayOrder == displayOrder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        displayOrder.hashCode;
  }
}
