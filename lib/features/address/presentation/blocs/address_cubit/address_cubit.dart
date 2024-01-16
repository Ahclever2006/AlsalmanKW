import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/address_by_id_model.dart';
import '../../../data/models/address_submit_model.dart';
import '../../../data/models/addresses_model.dart';
import '../../../data/models/states_model.dart';
import '../../../data/repositories/address_repository_impl.dart';

part 'address_state.dart';

class AddressCubit extends BaseCubit<AddressState> {
  final AddressRepository addressRepository;
  AddressCubit({required this.addressRepository})
      : super(const AddressInitial());

  Future<void> getAddresses() async {
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      final addressModel = await addressRepository.getAddresses();
      emit(AddressStateLoaded(
        addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    }
  }

  Future<void> refreshAddresses() => getAddresses();

  Future<void> getCountries() async {
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      final countries = await addressRepository.getCountries();
      emit(AddressStateLoaded(
        state.addressModel,
        countries,
        state.oldAddress,
        state.cities,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    }
  }

  Future<void> getCities(String id) async {
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      final cities = await addressRepository.getStates(id);
      emit(AddressStateLoaded(
        state.addressModel,
        state.countries,
        state.oldAddress,
        cities,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    }
  }

  Future<void> addAddress(AddressSubmitModel data) async {
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      await addressRepository.addAddress(data);
      emit(AddressAddedState(
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    }
  }

  Future<void> getAddressForEdit(int? id) async {
    if (id == null) return;
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      final oldAddress = await addressRepository.getAddressById(id);
      emit(GetEditedAddressStateLoaded(
        state.addressModel,
        state.countries,
        oldAddress,
        state.cities,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    }
  }

  Future<void> editAddress(int id, AddressSubmitModel data) async {
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      await addressRepository.editAddress(id, data);
      emit(AddressUpdatedState(
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
    }
  }

  Future<bool> deleteAddress(int id) async {
    emit(AddressStateLoading(
      state.addressModel,
      state.countries,
      state.oldAddress,
      state.cities,
    ));
    try {
      await addressRepository.deleteAddress(id);

      emit(AddressDeletedState(
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
      return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(AddressStateError(
        e.toString(),
        state.addressModel,
        state.countries,
        state.oldAddress,
        state.cities,
      ));
      return false;
    }
  }
}
