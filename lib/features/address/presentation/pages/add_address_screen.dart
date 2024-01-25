import 'dart:async';

import 'package:alsalman_app/shared_widgets/stateless/subtitle_text.dart';
import 'package:collection/collection.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../data/models/states_model.dart';

import '../../../../core/enums/address_type_enum.dart';
import '../../../../res/style/theme.dart';
import '../widgets/address_type_selector.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_simple_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/custom_drop_down_menu.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/text_fields/default_text_form_field.dart';
import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../../../../shared_widgets/text_fields/phone_number_text_field.dart';
import '../../data/models/address_by_id_model.dart';
import '../../data/models/address_submit_model.dart';
import '../blocs/address_cubit/address_cubit.dart';

class AddAddressPage extends StatefulWidget {
  static const routeName = '/AddAddressPage';
  const AddAddressPage({
    Key? key,
    this.isEdit = false,
    this.addressId,
  }) : super(key: key);

  final bool isEdit;
  final int? addressId;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String? selectedCountryId;
  String? selectedCountryName;
  String? selectedCityId;
  String? selectedCityName;
  late final GlobalKey<FormState> _formKey;

  PhoneNumber? _phoneNumber;

  late final TextEditingController _addressNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _blockTextController;
  late final TextEditingController _addressTextController;
  late final TextEditingController _phoneTextController;
  late final TextEditingController _avenueTextController;
  late final TextEditingController _placeTypeTextController;
  late final TextEditingController _floorTextController;
  late final TextEditingController _apartmentTextController;
  late final TextEditingController _officeTextController;
  late final TextEditingController _otherTextController;
  late final TextEditingController _notesTextController;

  late final FocusNode _addressNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _blockFocusNode;
  late final FocusNode _addressFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _avenueFocusNode;
  late final FocusNode _placeTypeFocusNode;
  late final FocusNode _floorFocusNode;
  late final FocusNode _apartmentFocusNode;
  late final FocusNode _notesFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _addressNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _blockTextController = TextEditingController();
    _addressTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _avenueTextController = TextEditingController();
    _placeTypeTextController =
        TextEditingController(text: AddressType.home_type.index.toString());
    _floorTextController = TextEditingController();
    _apartmentTextController = TextEditingController();
    _officeTextController = TextEditingController();
    _otherTextController = TextEditingController();
    _notesTextController = TextEditingController();

    _addressNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _blockFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _avenueFocusNode = FocusNode();
    _placeTypeFocusNode = FocusNode();
    _floorFocusNode = FocusNode();
    _apartmentFocusNode = FocusNode();
    _notesFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _addressNameTextController.dispose();
    _addressTextController.dispose();
    _phoneTextController.dispose();
    _emailTextController.dispose();
    _blockTextController.dispose();
    _avenueTextController.dispose();
    _placeTypeTextController.dispose();
    _floorTextController.dispose();
    _apartmentTextController.dispose();
    _notesTextController.dispose();

    _addressNameFocusNode.dispose();
    _addressFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _blockFocusNode.dispose();
    _avenueFocusNode.dispose();
    _placeTypeFocusNode.dispose();
    _floorFocusNode.dispose();
    _apartmentFocusNode.dispose();
    _notesFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().addressCubit
        ..getCountries()
        ..getAddressForEdit(widget.addressId),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(bottom: context.bottom),
            child: Column(
              children: [
                Builder(builder: (context) {
                  final addressCubit = context.read<AddressCubit>();
                  return InnerPagesAppBar(
                      label: ((widget.addressId != null)
                              ? 'edit_address'
                              : 'add_address')
                          .tr()
                          .toUpperCase(),
                      actionIcon:
                          (widget.addressId != null) ? 'delete_icon' : null,
                      onActionPress: () => showSimpleBottomSheet(
                            context,
                            label: 'delete',
                            subtitle: 'delete_address_subtitle',
                            onPress: () => addressCubit
                                .deleteAddress(widget.addressId!)
                                .whenComplete(() => NavigatorHelper.of(context)
                                  ..pop(true)
                                  ..pop(true)),
                          ));
                }),
                BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) async {
                    if (state is AddressStateError)
                      showSnackBar(context, message: state.message);

                    if (state is AddressAddedState ||
                        state is AddressUpdatedState)
                      NavigatorHelper.of(context).pop(true);
                    if (state is AddressStateLoaded && state.cities == null)
                      context.read<AddressCubit>().getCities(state.countries!
                          .address!.availableCountries!.first.value!);

                    if (state is GetEditedAddressStateLoaded &&
                        state.oldAddress != null) {
                      await _fillEditedAddressData(context, state.oldAddress!);
                    }
                  },
                  builder: (context, state) {
                    if (state is AddressInitial ||
                        (state is AddressStateLoading &&
                            state.countries == null))
                      return const Expanded(
                        child: CustomLoading(
                          loadingStyle: LoadingStyle.ShimmerList,
                        ),
                      );
                    else
                      return Expanded(
                        child: _buildAddressTab(context),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fillEditedAddressData(
      BuildContext context, AddressByIdModel oldAddress) async {
    final address = oldAddress.address!;
    _addressNameTextController.text = address.firstName!;
    _addressTextController.text = address.address1!;
    _emailTextController.text = address.email ?? '';
    _blockTextController.text = _getBlock(address) ?? '';
    _floorTextController.text = _getFloor(address) ?? '';
    _apartmentTextController.text = _getApartment(address) ?? '';
    _officeTextController.text = _getOffice(address) ?? '';
    _otherTextController.text = _getOther(address) ?? '';
    _placeTypeTextController.text = _getPlaceType(address) ?? '';
    _avenueTextController.text = _getAvenue(address) ?? '';
    _notesTextController.text = _getNotes(address) ?? '';

    await PhoneNumber.getRegionInfoFromPhoneNumber(
            oldAddress.address!.phoneNumber ?? '', 'KW')
        .then((value) {
      _phoneNumber = value;
    });

    selectedCountryId = oldAddress.address!.countryId.toString();

    selectedCountryName = oldAddress.address!.countryName;

    await context.read<AddressCubit>().getCities(selectedCountryId!);
    if (oldAddress.address!.stateProvinceId != null) {
      selectedCityId = oldAddress.address!.stateProvinceId.toString();
      selectedCityName = oldAddress.address!.stateProvinceName ?? '';
    }

    _addressTextController.text = oldAddress.address!.address1!;

    context
        .read<AddressCubit>()
        .changeAddressType(int.parse(_placeTypeTextController.text));

    setState(() {});
  }

  String? _getPlaceType(Address address) {
    final placeType = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 2)
        ?.defaultValue;
    return placeType;
  }

  String? _getOther(Address address) {
    String? other = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 12)
        ?.defaultValue;
    return other;
  }

  String? _getBlock(Address address) {
    final block = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 7)
        ?.defaultValue;
    return block;
  }

  String? _getAvenue(Address address) {
    final avenue = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 10)
        ?.defaultValue;
    return avenue;
  }

  String? _getApartment(Address address) {
    final apartment = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 5)
        ?.defaultValue;
    return apartment;
  }

  String? _getFloor(Address address) {
    final floor = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 4)
        ?.defaultValue;
    return floor;
  }

  String? _getOffice(Address address) {
    final office = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 9)
        ?.defaultValue;
    return office;
  }

  String? _getNotes(Address address) {
    final notes = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 11)
        ?.defaultValue;
    return notes;
  }

  Widget _buildAddressTab(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildForm(context, addressCubit.state.countries),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultButton(
                label: ((widget.addressId != null) ? 'update' : 'add')
                    .tr()
                    .toUpperCase(),
                onPressed: () {
                  if (_isNotValid()) return;
                  if (selectedCountryId == null)
                    return showSnackBar(context,
                        message: 'please_choose_country');
                  if (selectedCityId == null)
                    return showSnackBar(context, message: 'please_choose_city');
                  if (widget.addressId != null)
                    context.read<AddressCubit>().editAddress(
                          widget.addressId!,
                          AddressSubmitModel(
                              id: widget.addressId!,
                              firstName: _addressNameTextController.text,
                              email: _emailTextController.text.trim(),
                              countryId: selectedCountryId!,
                              countryName: selectedCountryName ?? '',
                              cityId: selectedCityId,
                              cityName: selectedCityName ?? '',
                              address: _addressTextController.text,
                              form: FormModel(
                                addressAttribute_7: _blockTextController.text,
                                addressAttribute_8: _addressTextController.text,
                                addressAttribute_2:
                                    _placeTypeTextController.text,
                                addressAttribute_10: _avenueTextController.text,
                                addressAttribute_4: _floorTextController.text,
                                addressAttribute_11: _notesTextController.text,
                                addressAttribute_5:
                                    _apartmentTextController.text,
                                addressAttribute_9: _officeTextController.text,
                                addressAttribute_12: _otherTextController.text,
                              ),
                              phone: _phoneNumber?.phoneNumber ?? ''),
                        );
                  else
                    context.read<AddressCubit>().addAddress(
                          AddressSubmitModel(
                              firstName: _addressNameTextController.text,
                              email: _emailTextController.text.trim(),
                              countryId: selectedCountryId!,
                              countryName: selectedCountryName ?? '',
                              cityId: selectedCityId,
                              cityName: selectedCityName ?? '',
                              address: _addressTextController.text,
                              form: FormModel(
                                addressAttribute_7: _blockTextController.text,
                                addressAttribute_8: _addressTextController.text,
                                addressAttribute_2:
                                    _placeTypeTextController.text,
                                addressAttribute_10: _avenueTextController.text,
                                addressAttribute_4: _floorTextController.text,
                                addressAttribute_11: _notesTextController.text,
                                addressAttribute_5:
                                    _apartmentTextController.text,
                                addressAttribute_9: _officeTextController.text,
                                addressAttribute_12: _otherTextController.text,
                              ),
                              phone: _phoneNumber?.phoneNumber ?? ''),
                        );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildTitle({required String label}) {
    return SubtitleText(
      text: label,
      margin: const EdgeInsets.only(bottom: 8.0),
    );
  }

  Widget _buildForm(BuildContext context, AddressByIdModel? countries) {
    var initialValue = int.tryParse(_placeTypeTextController.text);
    final addressCubit = context.read<AddressCubit>();
    return Form(
        key: _formKey,
        autovalidateMode: _isAutoValidating
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressTypeSelector(
                  key: ValueKey(initialValue.toString()),
                  initialValue: initialValue ?? AddressType.home_type.index,
                  onPress: (value) {
                    addressCubit.changeAddressType(value);
                    _placeTypeTextController.text = value.toString();
                  }),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'address_name'.tr()} ${'*'.tr()}'),
              DefaultTextFormField(
                  isRequired: true,
                  hint: 'address_name'.tr(),
                  currentController: _addressNameTextController,
                  currentFocusNode: _addressNameFocusNode,
                  nextFocusNode: _emailFocusNode),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'governorate'.tr()} ${'*'.tr()}'),
              _buildCountriesDropDown(context, countries),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'area'.tr()} ${'*'.tr()}'),
              _buildCitiesDropDown(),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'email_address'.tr()} ${'*'.tr()}'),
              EmailTextFormField(
                currentFocusNode: _emailFocusNode,
                nextFocusNode: _blockFocusNode,
                currentController: _emailTextController,
              ),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'block'.tr()} ${'*'.tr()}'),
              DefaultTextFormField(
                  isRequired: true,
                  currentFocusNode: _blockFocusNode,
                  nextFocusNode: _addressFocusNode,
                  currentController: _blockTextController,
                  hint: 'block'.tr()),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'street'.tr()} ${'*'.tr()}'),
              DefaultTextFormField(
                  isRequired: true,
                  currentFocusNode: _addressFocusNode,
                  nextFocusNode: _avenueFocusNode,
                  currentController: _addressTextController,
                  hint: 'street'.tr()),
              const SizedBox(height: 16.0),
              _buildTitle(label: 'avenue'.tr()),
              DefaultTextFormField(
                  currentFocusNode: _avenueFocusNode,
                  nextFocusNode: _placeTypeFocusNode,
                  currentController: _avenueTextController,
                  hint: 'avenue'.tr()),
              const SizedBox(height: 16.0),
              _buildTitle(label: 'floor'.tr()),
              DefaultTextFormField(
                  currentFocusNode: _floorFocusNode,
                  nextFocusNode: _apartmentFocusNode,
                  currentController: _floorTextController,
                  hint: 'floor'.tr()),
              const SizedBox(height: 16.0),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  var isHome =
                      (state.addressType == AddressType.home_type.index ||
                          state.addressType == null);
                  var isOffice =
                      state.addressType == AddressType.office_type.index;
                  return _buildTitle(
                      label: isHome
                          ? 'apartment'.tr()
                          : isOffice
                              ? 'office'.tr()
                              : 'other'.tr());
                },
              ),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  var isHome =
                      (state.addressType == AddressType.home_type.index ||
                          state.addressType == null);
                  var isOffice =
                      state.addressType == AddressType.office_type.index;
                  return DefaultTextFormField(
                      currentFocusNode: _apartmentFocusNode,
                      nextFocusNode: _phoneFocusNode,
                      currentController: isHome
                          ? _apartmentTextController
                          : isOffice
                              ? _officeTextController
                              : _otherTextController,
                      hint: isHome
                          ? 'apartment'.tr()
                          : isOffice
                              ? 'office'.tr()
                              : 'other'.tr());
                },
              ),
              const SizedBox(height: 16.0),
              _buildTitle(label: '${'phone_number'.tr()} ${'*'.tr()}'),
              PhoneTextFormField(
                currentController: _phoneTextController,
                initialValue: _phoneNumber,
                currentFocusNode: _phoneFocusNode,
                nextFocusNode: _addressFocusNode,
                onInputChanged: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 16.0),
              _buildTitle(label: 'notes'.tr()),
              DefaultTextFormField(
                  currentFocusNode: _notesFocusNode,
                  currentController: _notesTextController,
                  contentPadding: const EdgeInsets.all(8.0),
                  maxLines: 5,
                  hint: 'notes'.tr())
            ],
          ),
        ));
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void searchCityList(BuildContext context, String cityName) {
    final addressCubit = context.read<AddressCubit>();
    final cityList = addressCubit.state.cities;
    if (cityList != null && cityList.isNotEmpty) {
      StatesModel cityItem = cityList.firstWhere(
          (element) =>
              element.name?.toLowerCase().trim() ==
              cityName.toLowerCase().trim(),
          orElse: () => StatesModel());
      if (cityItem.id != null) {
        selectedCityId = cityItem.id.toString();
        selectedCityName = cityItem.name;

        setState(() {});
      }
    }
  }

  void searchCountryList(String countryName, countries, BuildContext context) {
    final countryList = countries!.address!.availableCountries;
    if (countryList != null && countryList.isNotEmpty) {
      Available countryItem = countryList.firstWhere(
          (element) =>
              element.text?.toLowerCase().trim() ==
              countryName.toLowerCase().trim(),
          orElse: () => Available(group: null));
      if (countryItem.value != null) {
        selectCountryCallBack(countryItem, context);
      }
    }
  }

  Widget _buildCountriesDropDown(
      BuildContext context, AddressByIdModel? countries) {
    if (countries?.address?.availableCountries?.isNotEmpty != true)
      return const SizedBox();

    final countriesModel = countries!.address!.availableCountries!;

    return CustomDropDownMenu<Available>(
      key: ValueKey(countriesModel.toString()),
      isRequired: true,
      currentItem: selectedCountryId == null
          ? countriesModel.first
          : countriesModel.where((e) => e.value == selectedCountryId).first,
      items: countriesModel,
      onChanged: (item) async {
        selectCountryCallBack(item, context);
      },
      getStringFromItem: (item) => item.text!,
    );
  }

  selectCountryCallBack(Available? item, BuildContext context) async {
    final cubit = context.read<AddressCubit>();
    selectedCountryId = item!.value;
    selectedCountryName = item.text;
    selectedCityId = null;
    await cubit.getCities(selectedCountryId!);
    setState(
      () {},
    );
  }

  Widget _buildCitiesDropDown() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressInitial ||
            state is AddressStateLoading ||
            state.cities == null) return const CustomLoading();
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: AppColors.PRIMARY_COLOR_DARK),
          ),
          child: CustomSearchableDropDown(
            dropdownHintText: 'search'.tr(),
            showLabelInMenu: false,
            dropdownItemStyle: const TextStyle(
                color: AppColors.PRIMARY_COLOR_DARK,
                fontWeight: FontWeight.bold),
            primaryColor: AppColors.PRIMARY_COLOR_DARK,
            menuMode: false,
            labelStyle: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(height: textHeight),
            items: state.cities!,
            hint: 'select_city'.tr(),
            label: 'select_city'.tr(),
            menuPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsetsDirectional.only(
                start: 16.0, top: 8.0, bottom: 8.0, end: 8.0),
            suffixIcon: const Icon(Icons.keyboard_arrow_down,
                color: AppColors.PRIMARY_COLOR),
            dropDownMenuItems: state.cities!.map((item) {
              return item.name;
            }).toList(),
            onChanged: (item) => setState(
              () {
                selectedCityId = item!.id.toString();
                selectedCityName = item.name;
              },
            ),
            initialIndex: selectedCityId != null
                ? state.cities!.indexOf(state.cities!
                    .where((e) => e.id.toString() == selectedCityId)
                    .first)
                : null,
          ),
        );
      },
    );
  }
}
