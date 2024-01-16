import 'dart:convert';

class StatesModel {
  String? name;
  int? id;
  StatesModel({
    this.name,
    this.id,
  });

  StatesModel copyWith({
    String? name,
    int? id,
  }) {
    return StatesModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory StatesModel.fromMap(Map<String, dynamic> map) {
    return StatesModel(
      name: map['name'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatesModel.fromJson(String source) =>
      StatesModel.fromMap(json.decode(source));

  @override
  String toString() => 'StatesModel(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatesModel && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
