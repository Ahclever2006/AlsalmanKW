import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserInfoModel {
  UserInfoData? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<String>? errors;
  UserInfoModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  UserInfoModel copyWith({
    UserInfoData? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<String>? errors,
  }) {
    return UserInfoModel(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Data': data?.toMap(),
      'StatusCode': statusCode,
      'Message': message,
      'IsSuccess': isSuccess,
      'Errors': errors,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      data: map['Data'] != null ? UserInfoData.fromMap(map['Data']) : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: map['Errors'] != null ? List<String>.from(map['Errors']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) =>
      UserInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserInfoModel(Data: $data, StatusCode: $statusCode, Message: $message, IsSuccess: $isSuccess, Errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfoModel &&
        other.data == data &&
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

class UserInfoData {
  String? email;
  dynamic emailToRevalidate;
  bool? checkUsernameAvailabilityEnabled;
  bool? allowUsersToChangeUsernames;
  bool? usernamesEnabled;
  dynamic username;
  bool? genderEnabled;
  dynamic gender;
  bool? firstNameEnabled;
  dynamic firstName;
  bool? firstNameRequired;
  bool? lastNameEnabled;
  dynamic lastName;
  bool? lastNameRequired;
  bool? dateOfBirthEnabled;
  dynamic dateOfBirthDay;
  dynamic dateOfBirthMonth;
  dynamic dateOfBirthYear;
  bool? dateOfBirthRequired;
  bool? companyEnabled;
  bool? companyRequired;
  dynamic company;
  bool? streetAddressEnabled;
  bool? streetAddressRequired;
  dynamic streetAddress;
  bool? streetAddress2Enabled;
  bool? streetAddress2Required;
  dynamic streetAddress2;
  bool? zipPostalCodeEnabled;
  bool? zipPostalCodeRequired;
  dynamic zipPostalCode;
  bool? cityEnabled;
  bool? cityRequired;
  dynamic city;
  bool? countyEnabled;
  bool? countyRequired;
  dynamic county;
  bool? countryEnabled;
  bool? countryRequired;
  int? countryId;
  List<dynamic>? availableCountries;
  bool? stateProvinceEnabled;
  bool? stateProvinceRequired;
  int? stateProvinceId;
  List<dynamic>? availableStates;
  bool? phoneEnabled;
  bool? phoneRequired;
  dynamic phone;
  bool? faxEnabled;
  bool? faxRequired;
  dynamic fax;
  bool? newsletterEnabled;
  bool? newsletter;
  bool? signatureEnabled;
  dynamic signature;
  dynamic timeZoneId;
  bool? allowCustomersToSetTimeZone;
  List<AvailableTimeZones>? availableTimeZones;
  dynamic vatNumber;
  String? vatNumberStatusNote;
  bool? displayVatNumber;
  List<dynamic>? associatedExternalAuthRecords;
  int? numberOfExternalAuthenticationProviders;
  bool? allowCustomersToRemoveAssociations;
  List<dynamic>? customerAttributes;
  List<dynamic>? gdprConsents;
  String? registerDateTimeOnUtc;
  String? avatarUrl;
  List<String>? roles;
  int? id;
  UserInfoData({
    this.email,
    this.emailToRevalidate,
    this.checkUsernameAvailabilityEnabled,
    this.allowUsersToChangeUsernames,
    this.usernamesEnabled,
    this.username,
    this.genderEnabled,
    this.gender,
    this.firstNameEnabled,
    this.firstName,
    this.firstNameRequired,
    this.lastNameEnabled,
    this.lastName,
    this.lastNameRequired,
    this.dateOfBirthEnabled,
    this.dateOfBirthDay,
    this.dateOfBirthMonth,
    this.dateOfBirthYear,
    this.dateOfBirthRequired,
    this.companyEnabled,
    this.companyRequired,
    this.company,
    this.streetAddressEnabled,
    this.streetAddressRequired,
    this.streetAddress,
    this.streetAddress2Enabled,
    this.streetAddress2Required,
    this.streetAddress2,
    this.zipPostalCodeEnabled,
    this.zipPostalCodeRequired,
    this.zipPostalCode,
    this.cityEnabled,
    this.cityRequired,
    this.city,
    this.countyEnabled,
    this.countyRequired,
    this.county,
    this.countryEnabled,
    this.countryRequired,
    this.countryId,
    this.availableCountries,
    this.stateProvinceEnabled,
    this.stateProvinceRequired,
    this.stateProvinceId,
    this.availableStates,
    this.phoneEnabled,
    this.phoneRequired,
    this.phone,
    this.faxEnabled,
    this.faxRequired,
    this.fax,
    this.newsletterEnabled,
    this.newsletter,
    this.signatureEnabled,
    this.signature,
    this.timeZoneId,
    this.allowCustomersToSetTimeZone,
    this.availableTimeZones,
    this.vatNumber,
    this.vatNumberStatusNote,
    this.displayVatNumber,
    this.associatedExternalAuthRecords,
    this.numberOfExternalAuthenticationProviders,
    this.allowCustomersToRemoveAssociations,
    this.customerAttributes,
    this.gdprConsents,
    this.registerDateTimeOnUtc,
    this.avatarUrl,
    this.roles,
    this.id,
  });

  UserInfoData copyWith({
    String? email,
    dynamic emailToRevalidate,
    bool? checkUsernameAvailabilityEnabled,
    bool? allowUsersToChangeUsernames,
    bool? usernamesEnabled,
    dynamic username,
    bool? genderEnabled,
    dynamic gender,
    bool? firstNameEnabled,
    dynamic firstName,
    bool? firstNameRequired,
    bool? lastNameEnabled,
    dynamic lastName,
    bool? lastNameRequired,
    bool? dateOfBirthEnabled,
    dynamic dateOfBirthDay,
    dynamic dateOfBirthMonth,
    dynamic dateOfBirthYear,
    bool? dateOfBirthRequired,
    bool? companyEnabled,
    bool? companyRequired,
    dynamic company,
    bool? streetAddressEnabled,
    bool? streetAddressRequired,
    dynamic streetAddress,
    bool? streetAddress2Enabled,
    bool? streetAddress2Required,
    dynamic streetAddress2,
    bool? zipPostalCodeEnabled,
    bool? zipPostalCodeRequired,
    dynamic zipPostalCode,
    bool? cityEnabled,
    bool? cityRequired,
    dynamic city,
    bool? countyEnabled,
    bool? countyRequired,
    dynamic county,
    bool? countryEnabled,
    bool? countryRequired,
    int? countryId,
    List<dynamic>? availableCountries,
    bool? stateProvinceEnabled,
    bool? stateProvinceRequired,
    int? stateProvinceId,
    List<dynamic>? availableStates,
    bool? phoneEnabled,
    bool? phoneRequired,
    dynamic phone,
    bool? faxEnabled,
    bool? faxRequired,
    dynamic fax,
    bool? newsletterEnabled,
    bool? newsletter,
    bool? signatureEnabled,
    dynamic signature,
    dynamic timeZoneId,
    bool? allowCustomersToSetTimeZone,
    List<AvailableTimeZones>? availableTimeZones,
    dynamic vatNumber,
    String? vatNumberStatusNote,
    bool? displayVatNumber,
    List<dynamic>? associatedExternalAuthRecords,
    int? numberOfExternalAuthenticationProviders,
    bool? allowCustomersToRemoveAssociations,
    List<dynamic>? customerAttributes,
    List<dynamic>? gdprConsents,
    String? registerDateTimeOnUtc,
    String? avatarUrl,
    List<String>? roles,
    int? id,
  }) {
    return UserInfoData(
      email: email ?? this.email,
      emailToRevalidate: emailToRevalidate ?? this.emailToRevalidate,
      checkUsernameAvailabilityEnabled: checkUsernameAvailabilityEnabled ??
          this.checkUsernameAvailabilityEnabled,
      allowUsersToChangeUsernames:
          allowUsersToChangeUsernames ?? this.allowUsersToChangeUsernames,
      usernamesEnabled: usernamesEnabled ?? this.usernamesEnabled,
      username: username ?? this.username,
      genderEnabled: genderEnabled ?? this.genderEnabled,
      gender: gender ?? this.gender,
      firstNameEnabled: firstNameEnabled ?? this.firstNameEnabled,
      firstName: firstName ?? this.firstName,
      firstNameRequired: firstNameRequired ?? this.firstNameRequired,
      lastNameEnabled: lastNameEnabled ?? this.lastNameEnabled,
      lastName: lastName ?? this.lastName,
      lastNameRequired: lastNameRequired ?? this.lastNameRequired,
      dateOfBirthEnabled: dateOfBirthEnabled ?? this.dateOfBirthEnabled,
      dateOfBirthDay: dateOfBirthDay ?? this.dateOfBirthDay,
      dateOfBirthMonth: dateOfBirthMonth ?? this.dateOfBirthMonth,
      dateOfBirthYear: dateOfBirthYear ?? this.dateOfBirthYear,
      dateOfBirthRequired: dateOfBirthRequired ?? this.dateOfBirthRequired,
      companyEnabled: companyEnabled ?? this.companyEnabled,
      companyRequired: companyRequired ?? this.companyRequired,
      company: company ?? this.company,
      streetAddressEnabled: streetAddressEnabled ?? this.streetAddressEnabled,
      streetAddressRequired:
          streetAddressRequired ?? this.streetAddressRequired,
      streetAddress: streetAddress ?? this.streetAddress,
      streetAddress2Enabled:
          streetAddress2Enabled ?? this.streetAddress2Enabled,
      streetAddress2Required:
          streetAddress2Required ?? this.streetAddress2Required,
      streetAddress2: streetAddress2 ?? this.streetAddress2,
      zipPostalCodeEnabled: zipPostalCodeEnabled ?? this.zipPostalCodeEnabled,
      zipPostalCodeRequired:
          zipPostalCodeRequired ?? this.zipPostalCodeRequired,
      zipPostalCode: zipPostalCode ?? this.zipPostalCode,
      cityEnabled: cityEnabled ?? this.cityEnabled,
      cityRequired: cityRequired ?? this.cityRequired,
      city: city ?? this.city,
      countyEnabled: countyEnabled ?? this.countyEnabled,
      countyRequired: countyRequired ?? this.countyRequired,
      county: county ?? this.county,
      countryEnabled: countryEnabled ?? this.countryEnabled,
      countryRequired: countryRequired ?? this.countryRequired,
      countryId: countryId ?? this.countryId,
      availableCountries: availableCountries ?? this.availableCountries,
      stateProvinceEnabled: stateProvinceEnabled ?? this.stateProvinceEnabled,
      stateProvinceRequired:
          stateProvinceRequired ?? this.stateProvinceRequired,
      stateProvinceId: stateProvinceId ?? this.stateProvinceId,
      availableStates: availableStates ?? this.availableStates,
      phoneEnabled: phoneEnabled ?? this.phoneEnabled,
      phoneRequired: phoneRequired ?? this.phoneRequired,
      phone: phone ?? this.phone,
      faxEnabled: faxEnabled ?? this.faxEnabled,
      faxRequired: faxRequired ?? this.faxRequired,
      fax: fax ?? this.fax,
      newsletterEnabled: newsletterEnabled ?? this.newsletterEnabled,
      newsletter: newsletter ?? this.newsletter,
      signatureEnabled: signatureEnabled ?? this.signatureEnabled,
      signature: signature ?? this.signature,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      allowCustomersToSetTimeZone:
          allowCustomersToSetTimeZone ?? this.allowCustomersToSetTimeZone,
      availableTimeZones: availableTimeZones ?? this.availableTimeZones,
      vatNumber: vatNumber ?? this.vatNumber,
      vatNumberStatusNote: vatNumberStatusNote ?? this.vatNumberStatusNote,
      displayVatNumber: displayVatNumber ?? this.displayVatNumber,
      associatedExternalAuthRecords:
          associatedExternalAuthRecords ?? this.associatedExternalAuthRecords,
      numberOfExternalAuthenticationProviders:
          numberOfExternalAuthenticationProviders ??
              this.numberOfExternalAuthenticationProviders,
      allowCustomersToRemoveAssociations: allowCustomersToRemoveAssociations ??
          this.allowCustomersToRemoveAssociations,
      customerAttributes: customerAttributes ?? this.customerAttributes,
      gdprConsents: gdprConsents ?? this.gdprConsents,
      registerDateTimeOnUtc:
          registerDateTimeOnUtc ?? this.registerDateTimeOnUtc,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      roles: roles ?? this.roles,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'email_to_revalidate': emailToRevalidate,
      'check_username_availability_enabled': checkUsernameAvailabilityEnabled,
      'allow_users_to_change_usernames': allowUsersToChangeUsernames,
      'usernames_enabled': usernamesEnabled,
      'username': username,
      'gender_enabled': genderEnabled,
      'gender': gender,
      'first_name_enabled': firstNameEnabled,
      'first_name': firstName,
      'first_name_required': firstNameRequired,
      'last_name_enabled': lastNameEnabled,
      'last_name': lastName,
      'last_name_required': lastNameRequired,
      'date_of_birth_enabled': dateOfBirthEnabled,
      'date_of_birth_day': dateOfBirthDay,
      'date_of_birth_month': dateOfBirthMonth,
      'date_of_birth_year': dateOfBirthYear,
      'date_of_birth_required': dateOfBirthRequired,
      'company_enabled': companyEnabled,
      'company_required': companyRequired,
      'company': company,
      'street_address_enabled': streetAddressEnabled,
      'street_address_required': streetAddressRequired,
      'street_address': streetAddress,
      'street_address2_enabled': streetAddress2Enabled,
      'street_address2_required': streetAddress2Required,
      'street_address2': streetAddress2,
      'zip_postal_code_enabled': zipPostalCodeEnabled,
      'zip_postal_code_required': zipPostalCodeRequired,
      'zip_postal_code': zipPostalCode,
      'city_enabled': cityEnabled,
      'city_required': cityRequired,
      'city': city,
      'county_enabled': countyEnabled,
      'county_required': countyRequired,
      'county': county,
      'country_enabled': countryEnabled,
      'country_required': countryRequired,
      'country_id': countryId,
      'available_countries': availableCountries,
      'state_province_enabled': stateProvinceEnabled,
      'state_province_required': stateProvinceRequired,
      'state_province_id': stateProvinceId,
      'available_states': availableStates,
      'phone_enabled': phoneEnabled,
      'phone_required': phoneRequired,
      'phone': phone,
      'fax_enabled': faxEnabled,
      'fax_required': faxRequired,
      'fax': fax,
      'newsletter_enabled': newsletterEnabled,
      'newsletter': newsletter,
      'signature_enabled': signatureEnabled,
      'signature': signature,
      'time_zone_id': timeZoneId,
      'allow_customers_to_set_time_zone': allowCustomersToSetTimeZone,
      'available_time_zones':
          availableTimeZones?.map((x) => x.toMap()).toList(),
      'vat_number': vatNumber,
      'vat_number_status_note': vatNumberStatusNote,
      'display_vat_number': displayVatNumber,
      'associated_external_auth_records': associatedExternalAuthRecords,
      'number_of_external_authentication_providers':
          numberOfExternalAuthenticationProviders,
      'allow_customers_to_remove_associations':
          allowCustomersToRemoveAssociations,
      'customer_attributes': customerAttributes,
      'gdpr_consents': gdprConsents,
      'register_date_time_on_utc': registerDateTimeOnUtc,
      'avatar_url': avatarUrl,
      'roles': roles,
      'id': id,
    };
  }

  factory UserInfoData.fromMap(Map<String, dynamic> map) {
    return UserInfoData(
      email: map['email'],
      emailToRevalidate: map['email_to_revalidate'],
      checkUsernameAvailabilityEnabled:
          map['check_username_availability_enabled'],
      allowUsersToChangeUsernames: map['allow_users_to_change_usernames'],
      usernamesEnabled: map['usernames_enabled'],
      username: map['username'],
      genderEnabled: map['gender_enabled'],
      gender: map['gender'],
      firstNameEnabled: map['first_name_enabled'],
      firstName: map['first_name'],
      firstNameRequired: map['first_name_required'],
      lastNameEnabled: map['last_name_enabled'],
      lastName: map['last_name'],
      lastNameRequired: map['last_name_required'],
      dateOfBirthEnabled: map['date_of_birth_enabled'],
      dateOfBirthDay: map['date_of_birth_day'],
      dateOfBirthMonth: map['date_of_birth_month'],
      dateOfBirthYear: map['date_of_birth_year'],
      dateOfBirthRequired: map['date_of_birth_required'],
      companyEnabled: map['company_enabled'],
      companyRequired: map['company_required'],
      company: map['company'],
      streetAddressEnabled: map['street_address_enabled'],
      streetAddressRequired: map['street_address_required'],
      streetAddress: map['street_address'],
      streetAddress2Enabled: map['street_address2_enabled'],
      streetAddress2Required: map['street_address2_required'],
      streetAddress2: map['street_address2'],
      zipPostalCodeEnabled: map['zip_postal_code_enabled'],
      zipPostalCodeRequired: map['zip_postal_code_required'],
      zipPostalCode: map['zip_postal_code'],
      cityEnabled: map['city_enabled'],
      cityRequired: map['city_required'],
      city: map['city'],
      countyEnabled: map['county_enabled'],
      countyRequired: map['county_required'],
      county: map['county'],
      countryEnabled: map['country_enabled'],
      countryRequired: map['country_required'],
      countryId: map['country_id']?.toInt(),
      availableCountries: List<dynamic>.from(map['available_countries']),
      stateProvinceEnabled: map['state+province_enabled'],
      stateProvinceRequired: map['state_province_required'],
      stateProvinceId: map['state_province_id']?.toInt(),
      availableStates: List<dynamic>.from(map['available_states']),
      phoneEnabled: map['phone_enabled'],
      phoneRequired: map['phone_required'],
      phone: map['phone'],
      faxEnabled: map['fax_enabled'],
      faxRequired: map['fax_required'],
      fax: map['fax'],
      newsletterEnabled: map['newsletter_enabled'],
      newsletter: map['newsletter'],
      signatureEnabled: map['signature_enabled'],
      signature: map['signature'],
      timeZoneId: map['time_zone_id'],
      allowCustomersToSetTimeZone: map['allow_customers_to_set_time_zone'],
      availableTimeZones: map['available_time_zones'] != null
          ? List<AvailableTimeZones>.from(map['available_time_zones']
              ?.map((x) => AvailableTimeZones.fromMap(x)))
          : null,
      vatNumber: map['vat_number'],
      vatNumberStatusNote: map['vat_number_status_note'],
      displayVatNumber: map['display_vat_number'],
      associatedExternalAuthRecords:
          List<dynamic>.from(map['associated_external_auth_records']),
      numberOfExternalAuthenticationProviders:
          map['number_of_external_authentication_providers']?.toInt(),
      allowCustomersToRemoveAssociations:
          map['allow_customers_to_remove_associations'],
      customerAttributes: List<dynamic>.from(map['customer_attributes']),
      gdprConsents: List<dynamic>.from(map['gdpr_consents']),
      registerDateTimeOnUtc: map['register_date_time_on_utc'],
      avatarUrl: map['avatar_url'],
      roles: List<String>.from(map['roles']),
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoData.fromJson(String source) =>
      UserInfoData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserInfoData(email: $email, email_to_revalidate: $emailToRevalidate, check_username_availability_enabled: $checkUsernameAvailabilityEnabled, allow_users_to_change_usernames: $allowUsersToChangeUsernames, usernames_enabled: $usernamesEnabled, username: $username, gender_enabled: $genderEnabled, gender: $gender, first_name_enabled: $firstNameEnabled, first_name: $firstName, first_name_required: $firstNameRequired, last_name_enabled: $lastNameEnabled, last_name: $lastName, last_name_required: $lastNameRequired, date_of_birth_enabled: $dateOfBirthEnabled, date_of_birth_day: $dateOfBirthDay, date_of_birth_month: $dateOfBirthMonth, date_of_birth_year: $dateOfBirthYear, date_of_birth_required: $dateOfBirthRequired, company_enabled: $companyEnabled, company_required: $companyRequired, company: $company, street_address_enabled: $streetAddressEnabled, street_address_required: $streetAddressRequired, street_address: $streetAddress, street_address2_enabled: $streetAddress2Enabled, street_address2_required: $streetAddress2Required, street_address2: $streetAddress2, zip_postal_code_enabled: $zipPostalCodeEnabled, zip_postal_code_required: $zipPostalCodeRequired, zip_postal_code: $zipPostalCode, city_enabled: $cityEnabled, city_required: $cityRequired, city: $city, county_enabled: $countyEnabled, county_required: $countyRequired, county: $county, country_enabled: $countryEnabled, country_required: $countryRequired, country_id: $countryId, available_countries: $availableCountries, state_province_enabled: $stateProvinceEnabled, state_province_required: $stateProvinceRequired, state_province_id: $stateProvinceId, available_states: $availableStates, phone_enabled: $phoneEnabled, phone_required: $phoneRequired, phone: $phone, fax_enabled: $faxEnabled, fax_required: $faxRequired, fax: $fax, newsletter_enabled: $newsletterEnabled, newsletter: $newsletter, signature_enabled: $signatureEnabled, signature: $signature, time_zone_id: $timeZoneId, allow_customers_to_set_time_zone: $allowCustomersToSetTimeZone, available_time_zones: $availableTimeZones, vat_number: $vatNumber, vat_number_status_note: $vatNumberStatusNote, display_vat_number: $displayVatNumber, associated_external_auth_records: $associatedExternalAuthRecords, number_of_external_authentication_providers: $numberOfExternalAuthenticationProviders, allow_customers_to_remove_associations: $allowCustomersToRemoveAssociations, customer_attributes: $customerAttributes, gdpr_consents: $gdprConsents, register_date_time_on_utc: $registerDateTimeOnUtc, avatar_url: $avatarUrl, roles: $roles, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfoData &&
        other.email == email &&
        other.emailToRevalidate == emailToRevalidate &&
        other.checkUsernameAvailabilityEnabled ==
            checkUsernameAvailabilityEnabled &&
        other.allowUsersToChangeUsernames == allowUsersToChangeUsernames &&
        other.usernamesEnabled == usernamesEnabled &&
        other.username == username &&
        other.genderEnabled == genderEnabled &&
        other.gender == gender &&
        other.firstNameEnabled == firstNameEnabled &&
        other.firstName == firstName &&
        other.firstNameRequired == firstNameRequired &&
        other.lastNameEnabled == lastNameEnabled &&
        other.lastName == lastName &&
        other.lastNameRequired == lastNameRequired &&
        other.dateOfBirthEnabled == dateOfBirthEnabled &&
        other.dateOfBirthDay == dateOfBirthDay &&
        other.dateOfBirthMonth == dateOfBirthMonth &&
        other.dateOfBirthYear == dateOfBirthYear &&
        other.dateOfBirthRequired == dateOfBirthRequired &&
        other.companyEnabled == companyEnabled &&
        other.companyRequired == companyRequired &&
        other.company == company &&
        other.streetAddressEnabled == streetAddressEnabled &&
        other.streetAddressRequired == streetAddressRequired &&
        other.streetAddress == streetAddress &&
        other.streetAddress2Enabled == streetAddress2Enabled &&
        other.streetAddress2Required == streetAddress2Required &&
        other.streetAddress2 == streetAddress2 &&
        other.zipPostalCodeEnabled == zipPostalCodeEnabled &&
        other.zipPostalCodeRequired == zipPostalCodeRequired &&
        other.zipPostalCode == zipPostalCode &&
        other.cityEnabled == cityEnabled &&
        other.cityRequired == cityRequired &&
        other.city == city &&
        other.countyEnabled == countyEnabled &&
        other.countyRequired == countyRequired &&
        other.county == county &&
        other.countryEnabled == countryEnabled &&
        other.countryRequired == countryRequired &&
        other.countryId == countryId &&
        listEquals(other.availableCountries, availableCountries) &&
        other.stateProvinceEnabled == stateProvinceEnabled &&
        other.stateProvinceRequired == stateProvinceRequired &&
        other.stateProvinceId == stateProvinceId &&
        listEquals(other.availableStates, availableStates) &&
        other.phoneEnabled == phoneEnabled &&
        other.phoneRequired == phoneRequired &&
        other.phone == phone &&
        other.faxEnabled == faxEnabled &&
        other.faxRequired == faxRequired &&
        other.fax == fax &&
        other.newsletterEnabled == newsletterEnabled &&
        other.newsletter == newsletter &&
        other.signatureEnabled == signatureEnabled &&
        other.signature == signature &&
        other.timeZoneId == timeZoneId &&
        other.allowCustomersToSetTimeZone == allowCustomersToSetTimeZone &&
        listEquals(other.availableTimeZones, availableTimeZones) &&
        other.vatNumber == vatNumber &&
        other.vatNumberStatusNote == vatNumberStatusNote &&
        other.displayVatNumber == displayVatNumber &&
        listEquals(other.associatedExternalAuthRecords,
            associatedExternalAuthRecords) &&
        other.numberOfExternalAuthenticationProviders ==
            numberOfExternalAuthenticationProviders &&
        other.allowCustomersToRemoveAssociations ==
            allowCustomersToRemoveAssociations &&
        listEquals(other.customerAttributes, customerAttributes) &&
        listEquals(other.gdprConsents, gdprConsents) &&
        other.registerDateTimeOnUtc == registerDateTimeOnUtc &&
        other.avatarUrl == avatarUrl &&
        listEquals(other.roles, roles) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        emailToRevalidate.hashCode ^
        checkUsernameAvailabilityEnabled.hashCode ^
        allowUsersToChangeUsernames.hashCode ^
        usernamesEnabled.hashCode ^
        username.hashCode ^
        genderEnabled.hashCode ^
        gender.hashCode ^
        firstNameEnabled.hashCode ^
        firstName.hashCode ^
        firstNameRequired.hashCode ^
        lastNameEnabled.hashCode ^
        lastName.hashCode ^
        lastNameRequired.hashCode ^
        dateOfBirthEnabled.hashCode ^
        dateOfBirthDay.hashCode ^
        dateOfBirthMonth.hashCode ^
        dateOfBirthYear.hashCode ^
        dateOfBirthRequired.hashCode ^
        companyEnabled.hashCode ^
        companyRequired.hashCode ^
        company.hashCode ^
        streetAddressEnabled.hashCode ^
        streetAddressRequired.hashCode ^
        streetAddress.hashCode ^
        streetAddress2Enabled.hashCode ^
        streetAddress2Required.hashCode ^
        streetAddress2.hashCode ^
        zipPostalCodeEnabled.hashCode ^
        zipPostalCodeRequired.hashCode ^
        zipPostalCode.hashCode ^
        cityEnabled.hashCode ^
        cityRequired.hashCode ^
        city.hashCode ^
        countyEnabled.hashCode ^
        countyRequired.hashCode ^
        county.hashCode ^
        countryEnabled.hashCode ^
        countryRequired.hashCode ^
        countryId.hashCode ^
        availableCountries.hashCode ^
        stateProvinceEnabled.hashCode ^
        stateProvinceRequired.hashCode ^
        stateProvinceId.hashCode ^
        availableStates.hashCode ^
        phoneEnabled.hashCode ^
        phoneRequired.hashCode ^
        phone.hashCode ^
        faxEnabled.hashCode ^
        faxRequired.hashCode ^
        fax.hashCode ^
        newsletterEnabled.hashCode ^
        newsletter.hashCode ^
        signatureEnabled.hashCode ^
        signature.hashCode ^
        timeZoneId.hashCode ^
        allowCustomersToSetTimeZone.hashCode ^
        availableTimeZones.hashCode ^
        vatNumber.hashCode ^
        vatNumberStatusNote.hashCode ^
        displayVatNumber.hashCode ^
        associatedExternalAuthRecords.hashCode ^
        numberOfExternalAuthenticationProviders.hashCode ^
        allowCustomersToRemoveAssociations.hashCode ^
        customerAttributes.hashCode ^
        gdprConsents.hashCode ^
        registerDateTimeOnUtc.hashCode ^
        avatarUrl.hashCode ^
        roles.hashCode ^
        id.hashCode;
  }
}

class AvailableTimeZones {
  bool? disabled;
  dynamic group;
  bool? selected;
  String? text;
  String? value;
  AvailableTimeZones({
    this.disabled,
    required this.group,
    this.selected,
    this.text,
    this.value,
  });

  AvailableTimeZones copyWith({
    bool? disabled,
    dynamic group,
    bool? selected,
    String? text,
    String? value,
  }) {
    return AvailableTimeZones(
      disabled: disabled ?? this.disabled,
      group: group ?? this.group,
      selected: selected ?? this.selected,
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'disabled': disabled,
      'group': group,
      'selected': selected,
      'text': text,
      'value': value,
    };
  }

  factory AvailableTimeZones.fromMap(Map<String, dynamic> map) {
    return AvailableTimeZones(
      disabled: map['disabled'],
      group: map['group'],
      selected: map['selected'],
      text: map['text'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableTimeZones.fromJson(String source) =>
      AvailableTimeZones.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AvailableTimeZones(disabled: $disabled, group: $group, selected: $selected, text: $text, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvailableTimeZones &&
        other.disabled == disabled &&
        other.group == group &&
        other.selected == selected &&
        other.text == text &&
        other.value == value;
  }

  @override
  int get hashCode {
    return disabled.hashCode ^
        group.hashCode ^
        selected.hashCode ^
        text.hashCode ^
        value.hashCode;
  }
}

// class CustomProperties {
//   //CustomProperties({});

//   CustomProperties.fromJson(Map<String, dynamic> json) {}

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     return data;
//   }
// }
