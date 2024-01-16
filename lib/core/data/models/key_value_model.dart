import 'dart:convert';

class KeyValueModel {
  final String key;
  final String value;

  const KeyValueModel(
    this.key,
    this.value,
  );

  KeyValueModel copyWith({
    String? key,
    String? value,
  }) {
    return KeyValueModel(
      key ?? this.key,
      value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
    }..removeWhere((_, v) => v == null);
  }

  factory KeyValueModel.fromMap(Map<String, dynamic> map) {
    return KeyValueModel(
      map['key'],
      map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyValueModel.fromJson(String source) =>
      KeyValueModel.fromMap(json.decode(source));

  @override
  String toString() => 'KeyValueModel(key: $key, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeyValueModel && other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}
