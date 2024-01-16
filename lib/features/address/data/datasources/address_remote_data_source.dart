import '../../../../api_end_point.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';
import '../models/address_by_id_model.dart';
import '../models/address_submit_model.dart';
import '../models/addresses_model.dart';
import '../models/edit_address_model.dart';
import '../models/states_model.dart';

abstract class AddressRemoteDataSource {
  Future<AddressesModel> getAddresses();

  Future<AddressByIdModel> getAddressById(int id);

  Future<EditAddressModel> editAddress(int id, AddressSubmitModel data);

  Future<void> deleteAddress(int id);

  Future<AddressByIdModel> getCountries();

  Future<List<StatesModel>> getStates(String id);

  Future<EditAddressModel> addAddress(AddressSubmitModel data);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final NetworkService _networkService;

  AddressRemoteDataSourceImpl(this._networkService);

  @override
  Future<AddressesModel> getAddresses() {
    const url = ApiEndPoint.getAddress;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);

      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return AddressesModel.fromMap(result['Data']);
    });
  }

  @override
  Future<AddressByIdModel> getAddressById(int id) {
    final url = ApiEndPoint.getAddressById + id.toString();

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return AddressByIdModel.fromMap(result['Data']);
    });
  }

  @override
  Future<EditAddressModel> editAddress(int id, AddressSubmitModel data) {
    final url = ApiEndPoint.getAddressById + id.toString();

    var dataModel = {
      "model": {
        "address": {
          "id": id,
          "first_name": data.firstName,
          "email": data.email,
          "country_id": data.countryId,
          "state_province_id": data.cityId,
          "country_name": data.countryName,
          "state_province_name": data.cityName,
          "address1": data.address,
          "phone_number": data.phone
        }
      },
      "form": data.form?.toMap()
    };

    return _networkService.put(url, data: dataModel).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return EditAddressModel.fromMap(result['Data']);
    });
  }

  @override
  Future<void> deleteAddress(int id) async {
    final url = ApiEndPoint.deleteAddress + id.toString();

    await _networkService.delete(url);
  }

  @override
  Future<AddressByIdModel> getCountries() {
    const url = ApiEndPoint.getCountries;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return AddressByIdModel.fromMap(result['Data']);
    });
  }

  @override
  Future<List<StatesModel>> getStates(String id) {
    final url = ApiEndPoint.getStates + id.toString();

    return _networkService.get(url,
        queryParameters: {"addSelectStateItem": true}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final states = result['Data'] as List;
      return states.map((e) => StatesModel.fromMap(e)).toList();
    });
  }

  @override
  Future<EditAddressModel> addAddress(AddressSubmitModel data) {
    const url = ApiEndPoint.getCountries;

    return _networkService.post(url, data: {
      "model": {
        "address": {
          "first_name": data.firstName,
          "email": data.email,
          "country_id": data.countryId,
          "state_province_id": data.cityId,
          "country_name": data.countryName,
          "state_province_name": data.cityName,
          "address1": data.address,
          "phone_number": data.phone
        }..removeWhere((_, v) => v == null)
      },
      "form": data.form?.toMap()
    }).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return EditAddressModel.fromMap(result['Data']);
    });
  }
}
