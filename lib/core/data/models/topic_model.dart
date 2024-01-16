import 'dart:convert';

class Topic {
  final int? id;
  final String? systemName;
  final String? title;
  final String? body;
  final String? seName;
  Topic({
    this.id,
    this.systemName,
    this.title,
    this.body,
    this.seName,
  });

  Topic copyWith({
    int? id,
    String? systemName,
    String? title,
    String? body,
    String? seName,
  }) {
    return Topic(
      id: id ?? this.id,
      systemName: systemName ?? this.systemName,
      title: title ?? this.title,
      body: body ?? this.body,
      seName: seName ?? this.seName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'system_name': systemName,
      'title': title,
      'body': body,
      'se_name': seName,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id']?.toInt(),
      systemName: map['system_name'],
      title: map['title'],
      body: map['body'],
      seName: map['se_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) => Topic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Topic(id: $id, system_name: $systemName, title: $title, body: $body, se_name: $seName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Topic &&
        other.id == id &&
        other.systemName == systemName &&
        other.title == title &&
        other.body == body &&
        other.seName == seName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        systemName.hashCode ^
        title.hashCode ^
        body.hashCode ^
        seName.hashCode;
  }
}
