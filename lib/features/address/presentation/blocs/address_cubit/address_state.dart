part of 'address_cubit.dart';

@immutable
abstract class AddressState {
  final AddressesModel? addressModel;
  final AddressByIdModel? countries;
  final AddressByIdModel? oldAddress;
  final List<StatesModel>? cities;
  const AddressState([
    this.addressModel,
    this.countries,
    this.oldAddress,
    this.cities,
  ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other is AddressState &&
        other.addressModel == addressModel &&
        other.countries == countries &&
        other.oldAddress == oldAddress &&
        listEquals(other.cities, cities);
  }

  @override
  int get hashCode =>
      addressModel.hashCode ^
      countries.hashCode ^
      oldAddress.hashCode ^
      cities.hashCode;
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
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class AddressStateLoaded extends AddressState {
  const AddressStateLoaded(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class GetEditedAddressStateLoaded extends AddressState {
  const GetEditedAddressStateLoaded(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class AddressAddedState extends AddressState {
  const AddressAddedState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class GetAddressForEditState extends AddressState {
  const GetAddressForEditState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class AddressUpdatedState extends AddressState {
  const AddressUpdatedState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class AddressDeletedState extends AddressState {
  const AddressDeletedState(
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
}

class AddressStateError extends AddressState {
  final String message;
  const AddressStateError(
    this.message,
    AddressesModel? addressModel,
    AddressByIdModel? countries,
    AddressByIdModel? oldAddress,
    List<StatesModel>? cities,
  ) : super(
          addressModel,
          countries,
          oldAddress,
          cities,
        );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressStateError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
