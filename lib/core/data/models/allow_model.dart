import 'dart:convert';

class AllowValueModel {
  final int? value;
  final bool? allowed;
  AllowValueModel({
    this.value,
    this.allowed,
  });

  AllowValueModel copyWith({
    int? value,
    bool? allowed,
  }) {
    return AllowValueModel(
      value: value ?? this.value,
      allowed: allowed ?? this.allowed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'allowed': allowed,
    };
  }

  factory AllowValueModel.fromMap(Map<String, dynamic> map) {
    return AllowValueModel(
      value: map['value']?.toInt(),
      allowed: map['allowed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AllowValueModel.fromJson(String source) =>
      AllowValueModel.fromMap(json.decode(source));

  @override
  String toString() => 'AllowValueModel(value: $value, allowed: $allowed)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllowValueModel &&
        other.value == value &&
        other.allowed == allowed;
  }

  @override
  int get hashCode => value.hashCode ^ allowed.hashCode;
}
