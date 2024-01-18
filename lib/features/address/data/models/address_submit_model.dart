import 'dart:convert';

class AddressSubmitModel {
  final int? id;
  final String? firstName;
  final String? email;
  final String? countryId;
  final String? countryName;
  final String? cityId;
  final String? cityName;
  final String? address;
  final String phone;
  final FormModel? form;
  AddressSubmitModel({
    this.id,
    this.firstName,
    this.email,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.address,
    required this.phone,
    this.form,
  });

  AddressSubmitModel copyWith({
    int? id,
    String? firstName,
    String? email,
    String? countryId,
    String? countryName,
    String? cityId,
    String? cityName,
    String? address,
    String? phone,
    FormModel? form,
  }) {
    return AddressSubmitModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      form: form ?? this.form,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'email': email,
      'countryId': countryId,
      'countryName': countryName,
      'cityId': cityId,
      'cityName': cityName,
      'address': address,
      'phone': phone,
      'form': form?.toMap(),
    }..removeWhere((_, v) => v == null);
  }

  factory AddressSubmitModel.fromMap(Map<String, dynamic> map) {
    return AddressSubmitModel(
      id: map['id']?.toInt(),
      firstName: map['firstName'],
      email: map['email'],
      countryId: map['countryId'],
      countryName: map['countryName'],
      cityId: map['cityId'],
      cityName: map['cityName'],
      address: map['address'],
      phone: map['phone'] ?? '',
      form: map['form'] != null ? FormModel.fromMap(map['form']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressSubmitModel.fromJson(String source) =>
      AddressSubmitModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressSubmitModel(id: $id, firstName: $firstName, email: $email, countryId: $countryId, countryName: $countryName, cityId: $cityId, cityName: $cityName, address: $address, phone: $phone, form: $form)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressSubmitModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.email == email &&
        other.countryId == countryId &&
        other.countryName == countryName &&
        other.cityId == cityId &&
        other.cityName == cityName &&
        other.address == address &&
        other.phone == phone &&
        other.form == form;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        email.hashCode ^
        countryId.hashCode ^
        countryName.hashCode ^
        cityId.hashCode ^
        cityName.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        form.hashCode;
  }
}

class FormModel {
  final String? addressAttribute_4;
  final String? addressAttribute_5;
  final String? addressAttribute_6;
  final String? addressAttribute_11;
  final String? addressAttribute_13;
  final String? addressAttribute_14;
  final String? addressAttribute_15;
  final String? addressAttribute_16;
  FormModel({
    this.addressAttribute_4,
    this.addressAttribute_5,
    this.addressAttribute_6,
    this.addressAttribute_11,
    this.addressAttribute_13,
    this.addressAttribute_14,
    this.addressAttribute_15,
    this.addressAttribute_16,
  });

  FormModel copyWith({
    String? addressAttribute_4,
    String? addressAttribute_5,
    String? addressAttribute_6,
    String? addressAttribute_11,
    String? addressAttribute_13,
    String? addressAttribute_14,
    String? addressAttribute_15,
    String? addressAttribute_16,
  }) {
    return FormModel(
      addressAttribute_4: addressAttribute_4 ?? this.addressAttribute_4,
      addressAttribute_5: addressAttribute_5 ?? this.addressAttribute_5,
      addressAttribute_6: addressAttribute_6 ?? this.addressAttribute_6,
      addressAttribute_11: addressAttribute_11 ?? this.addressAttribute_11,
      addressAttribute_13: addressAttribute_13 ?? this.addressAttribute_13,
      addressAttribute_14: addressAttribute_14 ?? this.addressAttribute_14,
      addressAttribute_15: addressAttribute_15 ?? this.addressAttribute_15,
      addressAttribute_16: addressAttribute_16 ?? this.addressAttribute_16,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_attribute_4': addressAttribute_4,
      'address_attribute_5': addressAttribute_5,
      'address_attribute_6': addressAttribute_6,
      'address_attribute_11': addressAttribute_11,
      'address_attribute_13': addressAttribute_13,
      'address_attribute_14': addressAttribute_14,
      'address_attribute_15': addressAttribute_15,
      'address_attribute_16': addressAttribute_16,
    }..removeWhere((_, v) => v == null);
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      addressAttribute_4: map['address_attribute_4'],
      addressAttribute_5: map['address_attribute_5'],
      addressAttribute_6: map['address_attribute_6'],
      addressAttribute_11: map['address_attribute_11'],
      addressAttribute_13: map['address_attribute_13'],
      addressAttribute_14: map['address_attribute_14'],
      addressAttribute_15: map['address_attribute_15'],
      addressAttribute_16: map['address_attribute_16'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FormModel(addressAttribute_4: $addressAttribute_4, addressAttribute_5: $addressAttribute_5, addressAttribute_6: $addressAttribute_6, addressAttribute_11: $addressAttribute_11, addressAttribute_13: $addressAttribute_13, addressAttribute_14: $addressAttribute_14, addressAttribute_15: $addressAttribute_15, addressAttribute_16: $addressAttribute_16)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormModel &&
        other.addressAttribute_4 == addressAttribute_4 &&
        other.addressAttribute_5 == addressAttribute_5 &&
        other.addressAttribute_6 == addressAttribute_6 &&
        other.addressAttribute_11 == addressAttribute_11 &&
        other.addressAttribute_13 == addressAttribute_13 &&
        other.addressAttribute_14 == addressAttribute_14 &&
        other.addressAttribute_15 == addressAttribute_15 &&
        other.addressAttribute_16 == addressAttribute_16;
  }

  @override
  int get hashCode {
    return addressAttribute_4.hashCode ^
        addressAttribute_5.hashCode ^
        addressAttribute_6.hashCode ^
        addressAttribute_11.hashCode ^
        addressAttribute_13.hashCode ^
        addressAttribute_14.hashCode ^
        addressAttribute_15.hashCode ^
        addressAttribute_16.hashCode;
  }
}
