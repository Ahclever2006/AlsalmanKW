import 'dart:convert';

import 'package:flutter/foundation.dart';

class EditAddressModel {
  Model? model;
  dynamic errors;
  EditAddressModel({
    this.model,
    required this.errors,
  });

  EditAddressModel copyWith({
    Model? model,
    dynamic errors,
  }) {
    return EditAddressModel(
      model: model ?? this.model,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
      'errors': errors,
    };
  }

  factory EditAddressModel.fromMap(Map<String, dynamic> map) {
    return EditAddressModel(
      model: map['model'] != null ? Model.fromMap(map['model']) : null,
      errors: map['errors'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditAddressModel.fromJson(String source) =>
      EditAddressModel.fromMap(json.decode(source));

  @override
  String toString() => 'EditAddressModel(model: $model, errors: $errors)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditAddressModel &&
        other.model == model &&
        other.errors == errors;
  }

  @override
  int get hashCode => model.hashCode ^ errors.hashCode;
}

class Model {
  Address? address;
  Model({
    this.address,
  });

  Model copyWith({
    Address? address,
  }) {
    return Model(
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address?.toMap(),
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  @override
  String toString() => 'Model(address: $address)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Model && other.address == address;
  }

  @override
  int get hashCode => address.hashCode;
}

class Address {
  String? firstName;
  String? lastName;
  String? email;
  bool? companyEnabled;
  bool? companyRequired;
  dynamic company;
  bool? countryEnabled;
  int? countryId;
  dynamic countryName;
  bool? stateProvinceEnabled;
  int? stateProvinceId;
  dynamic stateProvinceName;
  bool? countyEnabled;
  bool? countyRequired;
  dynamic county;
  bool? cityEnabled;
  bool? cityRequired;
  dynamic city;
  bool? streetAddressEnabled;
  bool? streetAddressRequired;
  String? address1;
  bool? streetAddress2Enabled;
  bool? streetAddress2Required;
  dynamic address2;
  bool? zipPostalCodeEnabled;
  bool? zipPostalCodeRequired;
  dynamic zipPostalCode;
  bool? phoneEnabled;
  bool? phoneRequired;
  String? phoneNumber;
  bool? faxEnabled;
  bool? faxRequired;
  dynamic faxNumber;
  List<dynamic>? availableCountries;
  List<dynamic>? availableStates;
  dynamic formattedCustomAddressAttributes;
  List<dynamic>? customAddressAttributes;
  int? id;
  Address({
    this.firstName,
    this.lastName,
    this.email,
    this.companyEnabled,
    this.companyRequired,
    required this.company,
    this.countryEnabled,
    this.countryId,
    required this.countryName,
    this.stateProvinceEnabled,
    this.stateProvinceId,
    required this.stateProvinceName,
    this.countyEnabled,
    this.countyRequired,
    required this.county,
    this.cityEnabled,
    this.cityRequired,
    required this.city,
    this.streetAddressEnabled,
    this.streetAddressRequired,
    this.address1,
    this.streetAddress2Enabled,
    this.streetAddress2Required,
    required this.address2,
    this.zipPostalCodeEnabled,
    this.zipPostalCodeRequired,
    required this.zipPostalCode,
    this.phoneEnabled,
    this.phoneRequired,
    this.phoneNumber,
    this.faxEnabled,
    this.faxRequired,
    required this.faxNumber,
    this.availableCountries,
    this.availableStates,
    required this.formattedCustomAddressAttributes,
    this.customAddressAttributes,
    this.id,
  });

  Address copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? companyEnabled,
    bool? companyRequired,
    dynamic company,
    bool? countryEnabled,
    int? countryId,
    dynamic countryName,
    bool? stateProvinceEnabled,
    int? stateProvinceId,
    dynamic stateProvinceName,
    bool? countyEnabled,
    bool? countyRequired,
    dynamic county,
    bool? cityEnabled,
    bool? cityRequired,
    dynamic city,
    bool? streetAddressEnabled,
    bool? streetAddressRequired,
    String? address1,
    bool? streetAddress2Enabled,
    bool? streetAddress2Required,
    dynamic address2,
    bool? zipPostalCodeEnabled,
    bool? zipPostalCodeRequired,
    dynamic zipPostalCode,
    bool? phoneEnabled,
    bool? phoneRequired,
    String? phoneNumber,
    bool? faxEnabled,
    bool? faxRequired,
    dynamic faxNumber,
    List<dynamic>? availableCountries,
    List<dynamic>? availableStates,
    dynamic formattedCustomAddressAttributes,
    List<dynamic>? customAddressAttributes,
    int? id,
  }) {
    return Address(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      companyEnabled: companyEnabled ?? this.companyEnabled,
      companyRequired: companyRequired ?? this.companyRequired,
      company: company ?? this.company,
      countryEnabled: countryEnabled ?? this.countryEnabled,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
      stateProvinceEnabled: stateProvinceEnabled ?? this.stateProvinceEnabled,
      stateProvinceId: stateProvinceId ?? this.stateProvinceId,
      stateProvinceName: stateProvinceName ?? this.stateProvinceName,
      countyEnabled: countyEnabled ?? this.countyEnabled,
      countyRequired: countyRequired ?? this.countyRequired,
      county: county ?? this.county,
      cityEnabled: cityEnabled ?? this.cityEnabled,
      cityRequired: cityRequired ?? this.cityRequired,
      city: city ?? this.city,
      streetAddressEnabled: streetAddressEnabled ?? this.streetAddressEnabled,
      streetAddressRequired:
          streetAddressRequired ?? this.streetAddressRequired,
      address1: address1 ?? this.address1,
      streetAddress2Enabled:
          streetAddress2Enabled ?? this.streetAddress2Enabled,
      streetAddress2Required:
          streetAddress2Required ?? this.streetAddress2Required,
      address2: address2 ?? this.address2,
      zipPostalCodeEnabled: zipPostalCodeEnabled ?? this.zipPostalCodeEnabled,
      zipPostalCodeRequired:
          zipPostalCodeRequired ?? this.zipPostalCodeRequired,
      zipPostalCode: zipPostalCode ?? this.zipPostalCode,
      phoneEnabled: phoneEnabled ?? this.phoneEnabled,
      phoneRequired: phoneRequired ?? this.phoneRequired,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      faxEnabled: faxEnabled ?? this.faxEnabled,
      faxRequired: faxRequired ?? this.faxRequired,
      faxNumber: faxNumber ?? this.faxNumber,
      availableCountries: availableCountries ?? this.availableCountries,
      availableStates: availableStates ?? this.availableStates,
      formattedCustomAddressAttributes: formattedCustomAddressAttributes ??
          this.formattedCustomAddressAttributes,
      customAddressAttributes:
          customAddressAttributes ?? this.customAddressAttributes,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'company_enabled': companyEnabled,
      'company_required': companyRequired,
      'company': company,
      'country_enabled': countryEnabled,
      'country_id': countryId,
      'country_name': countryName,
      'state_province_enabled': stateProvinceEnabled,
      'state_province_id': stateProvinceId,
      'state_province_name': stateProvinceName,
      'county_enabled': countyEnabled,
      'county_required': countyRequired,
      'county': county,
      'city_enabled': cityEnabled,
      'city_required': cityRequired,
      'city': city,
      'street_address_enabled': streetAddressEnabled,
      'street_address_required': streetAddressRequired,
      'address1': address1,
      'street_address2_enabled': streetAddress2Enabled,
      'street_address2_required': streetAddress2Required,
      'address2': address2,
      'zip_postal_code_enabled': zipPostalCodeEnabled,
      'zip_postal_code_required': zipPostalCodeRequired,
      'zip_postal_code': zipPostalCode,
      'phone_enabled': phoneEnabled,
      'phone_required': phoneRequired,
      'phone_number': phoneNumber,
      'fax_enabled': faxEnabled,
      'fax_required': faxRequired,
      'fax_number': faxNumber,
      'available_countries': availableCountries,
      'available_states': availableStates,
      'formatted_custom_address_attributes': formattedCustomAddressAttributes,
      'custom_address_attributes': customAddressAttributes,
      'id': id,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      companyEnabled: map['company_enabled'],
      companyRequired: map['company_required'],
      company: map['company'],
      countryEnabled: map['country_enabled'],
      countryId: map['country_id']?.toInt(),
      countryName: map['country_name'],
      stateProvinceEnabled: map['state_province_enabled'],
      stateProvinceId: map['state_province_id']?.toInt(),
      stateProvinceName: map['state_province_name'],
      countyEnabled: map['county_enabled'],
      countyRequired: map['county_required'],
      county: map['county'],
      cityEnabled: map['city_enabled'],
      cityRequired: map['city_required'],
      city: map['city'],
      streetAddressEnabled: map['street_address_enabled'],
      streetAddressRequired: map['street_address_required'],
      address1: map['address1'],
      streetAddress2Enabled: map['street_address2_enabled'],
      streetAddress2Required: map['street_address2_required'],
      address2: map['address2'],
      zipPostalCodeEnabled: map['zip_postal_code_enabled'],
      zipPostalCodeRequired: map['zip_postal_code_required'],
      zipPostalCode: map['zip_postal_code'],
      phoneEnabled: map['phone_enabled'],
      phoneRequired: map['phone_required'],
      phoneNumber: map['phone_number'],
      faxEnabled: map['fax_enabled'],
      faxRequired: map['fax_required'],
      faxNumber: map['fax_number'],
      availableCountries: List<dynamic>.from(map['available_countries']),
      availableStates: List<dynamic>.from(map['available_states']),
      formattedCustomAddressAttributes:
          map['formatted_customAddress_attributes'],
      customAddressAttributes:
          List<dynamic>.from(map['custom_address_attributes']),
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(first_name: $firstName, last_name: $lastName, email: $email, company_enabled: $companyEnabled, company_required: $companyRequired, company: $company, country_enabled: $countryEnabled, country_id: $countryId, country_name: $countryName, state_province_enabled: $stateProvinceEnabled, state_province_id: $stateProvinceId, state_province_name: $stateProvinceName, county_enabled: $countyEnabled, county_required: $countyRequired, county: $county, city_enabled: $cityEnabled, city_required: $cityRequired, city: $city, street_address_enabled: $streetAddressEnabled, street_address_required: $streetAddressRequired, address1: $address1, street_address2_enabled: $streetAddress2Enabled, street_address2_required: $streetAddress2Required, address2: $address2, zip_postal_code_enabled: $zipPostalCodeEnabled, zip_postal_code_required: $zipPostalCodeRequired, zip_postal_code: $zipPostalCode, phone_enabled: $phoneEnabled, phone_required: $phoneRequired, phone_number: $phoneNumber, fax_enabled: $faxEnabled, fax_required: $faxRequired, fax_number: $faxNumber, available_countries: $availableCountries, available_states: $availableStates, formatted_custom_address_attributes: $formattedCustomAddressAttributes, custom_address_attributes: $customAddressAttributes, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.companyEnabled == companyEnabled &&
        other.companyRequired == companyRequired &&
        other.company == company &&
        other.countryEnabled == countryEnabled &&
        other.countryId == countryId &&
        other.countryName == countryName &&
        other.stateProvinceEnabled == stateProvinceEnabled &&
        other.stateProvinceId == stateProvinceId &&
        other.stateProvinceName == stateProvinceName &&
        other.countyEnabled == countyEnabled &&
        other.countyRequired == countyRequired &&
        other.county == county &&
        other.cityEnabled == cityEnabled &&
        other.cityRequired == cityRequired &&
        other.city == city &&
        other.streetAddressEnabled == streetAddressEnabled &&
        other.streetAddressRequired == streetAddressRequired &&
        other.address1 == address1 &&
        other.streetAddress2Enabled == streetAddress2Enabled &&
        other.streetAddress2Required == streetAddress2Required &&
        other.address2 == address2 &&
        other.zipPostalCodeEnabled == zipPostalCodeEnabled &&
        other.zipPostalCodeRequired == zipPostalCodeRequired &&
        other.zipPostalCode == zipPostalCode &&
        other.phoneEnabled == phoneEnabled &&
        other.phoneRequired == phoneRequired &&
        other.phoneNumber == phoneNumber &&
        other.faxEnabled == faxEnabled &&
        other.faxRequired == faxRequired &&
        other.faxNumber == faxNumber &&
        listEquals(other.availableCountries, availableCountries) &&
        listEquals(other.availableStates, availableStates) &&
        other.formattedCustomAddressAttributes ==
            formattedCustomAddressAttributes &&
        listEquals(other.customAddressAttributes, customAddressAttributes) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        companyEnabled.hashCode ^
        companyRequired.hashCode ^
        company.hashCode ^
        countryEnabled.hashCode ^
        countryId.hashCode ^
        countryName.hashCode ^
        stateProvinceEnabled.hashCode ^
        stateProvinceId.hashCode ^
        stateProvinceName.hashCode ^
        countyEnabled.hashCode ^
        countyRequired.hashCode ^
        county.hashCode ^
        cityEnabled.hashCode ^
        cityRequired.hashCode ^
        city.hashCode ^
        streetAddressEnabled.hashCode ^
        streetAddressRequired.hashCode ^
        address1.hashCode ^
        streetAddress2Enabled.hashCode ^
        streetAddress2Required.hashCode ^
        address2.hashCode ^
        zipPostalCodeEnabled.hashCode ^
        zipPostalCodeRequired.hashCode ^
        zipPostalCode.hashCode ^
        phoneEnabled.hashCode ^
        phoneRequired.hashCode ^
        phoneNumber.hashCode ^
        faxEnabled.hashCode ^
        faxRequired.hashCode ^
        faxNumber.hashCode ^
        availableCountries.hashCode ^
        availableStates.hashCode ^
        formattedCustomAddressAttributes.hashCode ^
        customAddressAttributes.hashCode ^
        id.hashCode;
  }
}
