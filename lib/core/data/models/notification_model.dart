import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationModel {
  List<Data>? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<dynamic>? errors;
  NotificationModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  NotificationModel copyWith({
    List<Data>? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<dynamic>? errors,
  }) {
    return NotificationModel(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Data': data?.map((x) => x.toMap()).toList(),
      'StatusCode': statusCode,
      'Message': message,
      'IsSuccess': isSuccess,
      'Errors': errors,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      data: map['Data'] != null
          ? List<Data>.from(map['Data']?.map((x) => Data.fromMap(x)))
          : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: List<dynamic>.from(map['Errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(data: $data, statusCode: $statusCode, message: $message, isSuccess: $isSuccess, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        listEquals(other.data, data) &&
        other.statusCode == statusCode &&
        other.message == message &&
        other.isSuccess == isSuccess &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return data.hashCode ^
        statusCode.hashCode ^
        message.hashCode ^
        isSuccess.hashCode ^
        errors.hashCode;
  }
}

class Data {
  int? customerId;
  String? title;
  String? body;
  String? image;
  dynamic notificationType;
  dynamic link;
  dynamic code;
  dynamic extraData;
  String? data;
  String? platForm;
  String? onDateTime;
  int? id;
  Data({
    this.customerId,
    this.title,
    this.body,
    this.image,
    required this.notificationType,
    required this.link,
    required this.code,
    required this.extraData,
    this.data,
    this.platForm,
    this.onDateTime,
    this.id,
  });

  Data copyWith({
    int? customerId,
    String? title,
    String? body,
    String? image,
    dynamic notificationType,
    dynamic link,
    dynamic code,
    dynamic extraData,
    String? data,
    String? platForm,
    String? onDateTime,
    int? id,
  }) {
    return Data(
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      body: body ?? this.body,
      image: image ?? this.image,
      notificationType: notificationType ?? this.notificationType,
      link: link ?? this.link,
      code: code ?? this.code,
      extraData: extraData ?? this.extraData,
      data: data ?? this.data,
      platForm: platForm ?? this.platForm,
      onDateTime: onDateTime ?? this.onDateTime,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'CustomerId': customerId,
      'Title': title,
      'Body': body,
      'Image': image,
      'NotificationType': notificationType,
      'Link': link,
      'Code': code,
      'ExtraData': extraData,
      'Data': data,
      'PlatForm': platForm,
      'OnDateTime': onDateTime,
      'Id': id,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      customerId: map['CustomerId']?.toInt(),
      title: map['Title'],
      body: map['Body'],
      image: map['Image'],
      notificationType: map['NotificationType'],
      link: map['Link'],
      code: map['Code'],
      extraData: map['ExtraData'],
      data: map['Data'],
      platForm: map['PlatForm'],
      onDateTime: map['OnDateTime'],
      id: map['Id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(customerId: $customerId, title: $title, body: $body, image: $image, notificationType: $notificationType, link: $link, code: $code, extraData: $extraData, data: $data, platForm: $platForm, onDateTime: $onDateTime, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.customerId == customerId &&
        other.title == title &&
        other.body == body &&
        other.image == image &&
        other.notificationType == notificationType &&
        other.link == link &&
        other.code == code &&
        other.extraData == extraData &&
        other.data == data &&
        other.platForm == platForm &&
        other.onDateTime == onDateTime &&
        other.id == id;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
        title.hashCode ^
        body.hashCode ^
        image.hashCode ^
        notificationType.hashCode ^
        link.hashCode ^
        code.hashCode ^
        extraData.hashCode ^
        data.hashCode ^
        platForm.hashCode ^
        onDateTime.hashCode ^
        id.hashCode;
  }
}
