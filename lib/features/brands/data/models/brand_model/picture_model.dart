import 'dart:convert';

import 'package:collection/collection.dart';

class PictureModel {
  num? id;
  String? imageUrl;
  dynamic thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;

  PictureModel({
    this.id,
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  @override
  String toString() {
    return 'PictureModel(id: $id, imageUrl: $imageUrl, thumbImageUrl: $thumbImageUrl, fullSizeImageUrl: $fullSizeImageUrl, title: $title, alternateText: $alternateText)';
  }

  factory PictureModel.fromMap(Map<String, dynamic> data) => PictureModel(
        id: num.tryParse(data['id'].toString()),
        imageUrl: data['image_url']?.toString(),
        thumbImageUrl: data['thumb_image_url'],
        fullSizeImageUrl: data['full_size_image_url']?.toString(),
        title: data['title']?.toString(),
        alternateText: data['alternate_text']?.toString(),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        if (imageUrl != null) 'image_url': imageUrl,
        if (thumbImageUrl != null) 'thumb_image_url': thumbImageUrl,
        if (fullSizeImageUrl != null) 'full_size_image_url': fullSizeImageUrl,
        if (title != null) 'title': title,
        if (alternateText != null) 'alternate_text': alternateText,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PictureModel].
  factory PictureModel.fromJson(String data) {
    return PictureModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PictureModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PictureModel copyWith({
    num? id,
    String? imageUrl,
    dynamic thumbImageUrl,
    String? fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return PictureModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbImageUrl: thumbImageUrl ?? this.thumbImageUrl,
      fullSizeImageUrl: fullSizeImageUrl ?? this.fullSizeImageUrl,
      title: title ?? this.title,
      alternateText: alternateText ?? this.alternateText,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PictureModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      imageUrl.hashCode ^
      thumbImageUrl.hashCode ^
      fullSizeImageUrl.hashCode ^
      title.hashCode ^
      alternateText.hashCode;
}
