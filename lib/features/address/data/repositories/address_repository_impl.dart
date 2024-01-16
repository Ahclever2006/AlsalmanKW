import '../datasources/address_remote_data_source.dart';
import '../models/address_by_id_model.dart';
import '../models/address_submit_model.dart';
import '../models/addresses_model.dart';
import '../models/edit_address_model.dart';
import '../models/states_model.dart';

abstract class AddressRepository {
  Future<AddressesModel> getAddresses();

  Future<AddressByIdModel> getAddressById(int id);

  Future<EditAddressModel> editAddress(int id, AddressSubmitModel data);

  Future<void> deleteAddress(int id);

  Future<AddressByIdModel> getCountries();

  Future<List<StatesModel>> getStates(String id);

  Future<EditAddressModel> addAddress(AddressSubmitModel data);
}

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource _remoteDataSource;

  AddressRepositoryImpl(
    this._remoteDataSource,
  );

  @override
  Future<AddressesModel> getAddresses() => _remoteDataSource.getAddresses();

  @override
  Future<AddressByIdModel> getAddressById(int id) =>
      _remoteDataSource.getAddressById(id);

  @override
  Future<EditAddressModel> editAddress(int id, AddressSubmitModel data) =>
      _remoteDataSource.editAddress(id, data);

  @override
  Future<void> deleteAddress(int id) => _remoteDataSource.deleteAddress(id);

  @override
  Future<AddressByIdModel> getCountries() => _remoteDataSource.getCountries();

  @override
  Future<List<StatesModel>> getStates(String id) =>
      _remoteDataSource.getStates(id);

  @override
  Future<EditAddressModel> addAddress(AddressSubmitModel data) =>
      _remoteDataSource.addAddress(data);
}
