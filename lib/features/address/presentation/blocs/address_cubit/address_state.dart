part of 'address_cubit.dart';

@immutable
abstract class AddressState {
  final AddressesModel? addressModel;
  final AddressByIdModel? countries;
  final AddressByIdModel? oldAddress;
  final List<StatesModel>? cities;
  final double? lat, lng;
  final int? addressType;
  const AddressState([
    this.addressModel,
    this.countries,
    this.oldAddress,
    this.cities,
    this.lat,
    this.lng,
    this.addressType,
  ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other is AddressState &&
        other.addressModel == addressModel &&
        other.countries == countries &&
        other.oldAddress == oldAddress &&
        other.lat == lat &&
        other.lng == lng &&
        other.addressType == addressType &&
        listEquals(other.cities, cities);
  }

  @override
  int get hashCode =>
      addressModel.hashCode ^
      countries.hashCode ^
      oldAddress.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      addressType.hashCode ^
      cities.hashCode;
}

class AddressStateLocation extends AddressState {
  const AddressStateLocation(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressInitial extends AddressState {
  const AddressInitial();
}

class AddressStateLoading extends AddressState {
  const AddressStateLoading(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressStateLoaded extends AddressState {
  const AddressStateLoaded(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class GetEditedAddressStateLoaded extends AddressState {
  const GetEditedAddressStateLoaded(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressAddedState extends AddressState {
  const AddressAddedState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class GetAddressForEditState extends AddressState {
  const GetAddressForEditState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressUpdatedState extends AddressState {
  const AddressUpdatedState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressDeletedState extends AddressState {
  const AddressDeletedState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressTypeChangeState extends AddressState {
  const AddressTypeChangeState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
}

class AddressStateError extends AddressState {
  final String message;
  const AddressStateError(
    this.message,
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
    double? lat,
    double? lng,
    int? addressType,
  ) : super(addressModel, countries, oldAddress, cities, lat, lng, addressType);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressStateError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
