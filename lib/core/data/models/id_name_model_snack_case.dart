import 'dart:convert';

class IdNameModelSnackCase {
  final int id;
  final String name;
  final bool disabled;
  final bool comingSoon;
  IdNameModelSnackCase({
    required this.id,
    required this.name,
    required this.disabled,
    required this.comingSoon,
  });

  IdNameModelSnackCase copyWith({
    int? id,
    String? name,
    bool? disabled,
    bool? comingSoon,
  }) {
    return IdNameModelSnackCase(
      id: id ?? this.id,
      name: name ?? this.name,
      disabled: disabled ?? this.disabled,
      comingSoon: comingSoon ?? this.comingSoon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'disabled': disabled,
      'comingSoon': comingSoon,
    };
  }

  factory IdNameModelSnackCase.fromMap(Map<String, dynamic> map) {
    return IdNameModelSnackCase(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      disabled: map['disabled'] ?? false,
      comingSoon: map['comingSoon'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdNameModelSnackCase.fromJson(String source) =>
      IdNameModelSnackCase.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IdNameModelSnackCase(id: $id, name: $name, disabled: $disabled, comingSoon: $comingSoon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IdNameModelSnackCase &&
        other.id == id &&
        other.name == name &&
        other.disabled == disabled &&
        other.comingSoon == comingSoon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        disabled.hashCode ^
        comingSoon.hashCode;
  }
}
