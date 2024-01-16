import 'dart:convert';

class IdNameModel {
  final int id;
  final String name;
  final bool disabled;
  final bool comingSoon;

  const IdNameModel(
    this.id,
    this.name, {
    this.disabled = false,
    this.comingSoon = false,
  });

  IdNameModel copyWith({
    int? id,
    String? name,
    bool? disabled,
    bool? comingSoon,
  }) {
    return IdNameModel(
      id ?? this.id,
      name ?? this.name,
      disabled: disabled ?? this.disabled,
      comingSoon: comingSoon ?? this.comingSoon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'disabled': disabled,
      'comingSoon': comingSoon,
    }..removeWhere((_, v) => v == null);
  }

  factory IdNameModel.fromMap(Map<String, dynamic> map) {
    return IdNameModel(
      map['Id'],
      map['Name'],
      disabled: map['disabled'] ?? false,
      comingSoon: map['comingSoon'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdNameModel.fromJson(String source) =>
      IdNameModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'IdNameModel(Id: $id, Name: $name, disabled: $disabled, comingSoon: $comingSoon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IdNameModel &&
        other.id == id &&
        other.name == name &&
        other.disabled == disabled &&
        other.comingSoon == comingSoon;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ disabled.hashCode ^ comingSoon.hashCode;
}
