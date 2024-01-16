import 'package:collection/collection.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
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
    this.initialIndex = 0,
    this.addressId,
  }) : super(key: key);

  final bool isEdit;
  final int? addressId;
  final int initialIndex;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String? selectedCountryId;
  String? selectedCountryName;
  String? selectedCityId;
  String? selectedCityName;
  int selectedTabIndex = 0;
  late final PageController _controller;
  late final GlobalKey<FormState> _formKey;
  late final GlobalKey<FormState> _giftFormKey;

  PhoneNumber? _phoneNumber;
  PhoneNumber? _giftPhoneNumber;

  late final TextEditingController _addressNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _blockTextController;
  late final TextEditingController _addressTextController;
  late final TextEditingController _phoneTextController;
  late final TextEditingController _avenueTextController;
  late final TextEditingController _placeTypeTextController;
  late final TextEditingController _floorTextController;
  late final TextEditingController _apartmentTextController;
  late final TextEditingController _notesTextController;

  late final TextEditingController _receiverNameTextController;
  late final TextEditingController _giftPhoneTextController;
  late final TextEditingController _giftNotesTextController;

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

  late final FocusNode _receiverNameFocusNode;
  late final FocusNode _giftPhoneFocusNode;
  late final FocusNode _giftNotesFocusNode;

  bool _isAutoValidating = false;
  bool _isGiftAutoValidating = false;

  @override
  void initState() {
    selectedTabIndex = widget.initialIndex;
    _controller =
        PageController(initialPage: selectedTabIndex, viewportFraction: 0.9999);
    _formKey = GlobalKey<FormState>();
    _giftFormKey = GlobalKey<FormState>();

    _addressNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _blockTextController = TextEditingController();
    _addressTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _avenueTextController = TextEditingController();
    _placeTypeTextController = TextEditingController();
    _floorTextController = TextEditingController();
    _apartmentTextController = TextEditingController();
    _notesTextController = TextEditingController();
    _receiverNameTextController = TextEditingController();
    _giftPhoneTextController = TextEditingController();
    _giftNotesTextController = TextEditingController();

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
    _receiverNameFocusNode = FocusNode();
    _giftPhoneFocusNode = FocusNode();
    _giftNotesFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
    _receiverNameTextController.dispose();
    _giftPhoneTextController.dispose();
    _giftNotesTextController.dispose();

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
    _receiverNameFocusNode.dispose();
    _giftPhoneFocusNode.dispose();
    _giftNotesFocusNode.dispose();

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
                      label: ((widget.addressId != null &&
                                  widget.initialIndex == selectedTabIndex)
                              ? 'edit_address'
                              : 'add_address')
                          .tr()
                          .toUpperCase(),
                      actionIcon: (widget.addressId != null &&
                              widget.initialIndex == selectedTabIndex)
                          ? 'delete_icon'
                          : null,
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
                _buildAddressesTabs(context),
                const SizedBox(height: 8.0),
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
                        child: PageView(
                          controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildAddressTab(context),
                            _buildGiftTab(context),
                          ],
                        ),
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
    if (widget.initialIndex == 0) {
      final address = oldAddress.address!;
      _addressNameTextController.text = address.firstName!;
      _addressTextController.text = address.address1!;
      _emailTextController.text = address.email ?? '';
      _blockTextController.text = _getBlock(address) ?? '';
      _floorTextController.text = _getFloor(address) ?? '';
      _apartmentTextController.text = _getApartment(address) ?? '';
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
    } else {
      final address = oldAddress.address!;
      _receiverNameTextController.text = address.firstName!;
      _giftNotesTextController.text = _getNotes(address) ?? '';
      PhoneNumber.getRegionInfoFromPhoneNumber(
              oldAddress.address!.phoneNumber ?? '', 'KW')
          .then((value) {
        _giftPhoneNumber = value;
      });
    }

    setState(() {});
  }

  String? _getPlaceType(Address address) {
    final placeType = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 2)
        ?.defaultValue;
    return placeType;
  }

  String? _getArea(Address address) {
    String? area = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 13)
        ?.defaultValue;
    return area;
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
          const SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultButton(
                label: ((widget.addressId != null &&
                            widget.initialIndex == selectedTabIndex)
                        ? 'update'
                        : 'add')
                    .tr()
                    .toUpperCase(),
                onPressed: () {
                  if (_isNotValid()) return;
                  if (selectedCountryId == null)
                    return showSnackBar(context,
                        message: 'please_choose_country');
                  if (selectedCityId == null)
                    return showSnackBar(context, message: 'please_choose_city');
                  if (widget.addressId != null &&
                      widget.initialIndex == selectedTabIndex)
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
                                addressAttribute_2:
                                    _placeTypeTextController.text,
                                addressAttribute_10: _avenueTextController.text,
                                addressAttribute_4: _floorTextController.text,
                                addressAttribute_11: _notesTextController.text,
                                addressAttribute_5:
                                    _apartmentTextController.text,
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
                                addressAttribute_2:
                                    _placeTypeTextController.text,
                                addressAttribute_10: _avenueTextController.text,
                                addressAttribute_4: _floorTextController.text,
                                addressAttribute_11: _notesTextController.text,
                                addressAttribute_5:
                                    _apartmentTextController.text,
                              ),
                              phone: _phoneNumber?.phoneNumber ?? ''),
                        );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, AddressByIdModel? countries) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state.isUserLoggedIn;
    return Form(
        key: _formKey,
        autovalidateMode: _isAutoValidating
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DefaultTextFormField(
                  isRequired: true,
                  hint: 'address_name'.tr(),
                  currentController: _addressNameTextController,
                  currentFocusNode: _addressNameFocusNode,
                  nextFocusNode: _emailFocusNode),
              const SizedBox(height: 16.0),
              _buildCountriesDropDown(context, countries),
              const SizedBox(height: 16.0),
              _buildCitiesDropDown(),
              const SizedBox(height: 16.0),
              if (!isLoggedIn)
                EmailTextFormField(
                  currentFocusNode: _emailFocusNode,
                  nextFocusNode: _blockFocusNode,
                  currentController: _emailTextController,
                ),
              if (!isLoggedIn) const SizedBox(height: 16.0),
              DefaultTextFormField(
                  isRequired: true,
                  currentFocusNode: _blockFocusNode,
                  nextFocusNode: _addressFocusNode,
                  currentController: _blockTextController,
                  hint: 'block'.tr()),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  isRequired: true,
                  currentFocusNode: _addressFocusNode,
                  nextFocusNode: _avenueFocusNode,
                  currentController: _addressTextController,
                  hint: 'street'.tr()),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  currentFocusNode: _avenueFocusNode,
                  nextFocusNode: _placeTypeFocusNode,
                  currentController: _avenueTextController,
                  hint: 'avenue'.tr()),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  isRequired: true,
                  currentFocusNode: _placeTypeFocusNode,
                  nextFocusNode: _floorFocusNode,
                  currentController: _placeTypeTextController,
                  hint: 'address_type'.tr()),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  currentFocusNode: _floorFocusNode,
                  nextFocusNode: _apartmentFocusNode,
                  currentController: _floorTextController,
                  hint: 'floor'.tr()),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  currentFocusNode: _apartmentFocusNode,
                  nextFocusNode: _phoneFocusNode,
                  currentController: _apartmentTextController,
                  hint: 'apartment'.tr()),
              const SizedBox(height: 16.0),
              PhoneTextFormField(
                currentController: _phoneTextController,
                initialValue: _phoneNumber,
                currentFocusNode: _phoneFocusNode,
                nextFocusNode: _addressFocusNode,
                onInputChanged: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  currentFocusNode: _notesFocusNode,
                  currentController: _notesTextController,
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

  Widget _buildCountriesDropDown(
      BuildContext context, AddressByIdModel? countries) {
    if (countries?.address?.availableCountries?.isNotEmpty != true)
      return const SizedBox();

    final countriesModel = countries!.address!.availableCountries!;

    final cubit = context.read<AddressCubit>();

    return CustomDropDownMenu<Available>(
      key: ValueKey(countriesModel.toString()),
      isRequired: true,
      currentItem: selectedCountryId == null
          ? countriesModel.first
          : countriesModel.where((e) => e.value == selectedCountryId).first,
      items: countriesModel,
      onChanged: (item) async {
        selectedCountryId = item!.value;
        selectedCountryName = item.text;
        selectedCityId = null;
        await cubit.getCities(selectedCountryId!);
        setState(
          () {},
        );
      },
      getStringFromItem: (item) => item.text!,
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
            labelStyle:
                Theme.of(context).textTheme.displayLarge!.copyWith(height: 1.0),
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

  Widget _buildAddressesTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildTab(context,
                label: 'address_type'.tr(),
                isSelected: selectedTabIndex == 0, onPress: () {
              setState(() {
                selectedTabIndex = 0;
                if (_controller.hasClients)
                  _controller.jumpToPage(selectedTabIndex);
              });
            }),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _buildTab(context,
                label: 'gift'.tr(),
                isSelected: selectedTabIndex == 1, onPress: () {
              setState(() {
                selectedTabIndex = 1;
                if (_controller.hasClients)
                  _controller.jumpToPage(selectedTabIndex);
              });
            }),
          )
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context,
      {required bool isSelected,
      required String label,
      required VoidCallback onPress}) {
    return DefaultButton(
        isExpanded: true,
        label: label,
        labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.0,
            color: isSelected ? Colors.white : AppColors.PRIMARY_COLOR_DARK),
        borderColor: isSelected ? null : AppColors.PRIMARY_COLOR_DARK,
        backgroundColor:
            isSelected ? AppColors.PRIMARY_COLOR_DARK : Colors.transparent,
        onPressed: onPress);
  }

  Widget _buildGiftTab(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGiftForm(context),
          const SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultButton(
                label: ((widget.addressId != null &&
                            widget.initialIndex == selectedTabIndex)
                        ? 'update'
                        : 'add')
                    .tr()
                    .toUpperCase(),
                onPressed: () {
                  if (_isGiftNotValid()) return;
                  if (widget.addressId != null &&
                      widget.initialIndex == selectedTabIndex)
                    addressCubit.editAddress(
                      widget.addressId!,
                      AddressSubmitModel(
                          id: widget.addressId!,
                          firstName: _receiverNameTextController.text,
                          form: FormModel(
                            addressAttribute_11: _giftNotesTextController.text,
                          ),
                          phone: _giftPhoneNumber?.phoneNumber ?? ''),
                    );
                  else
                    addressCubit.addAddress(
                      AddressSubmitModel(
                          firstName: _receiverNameTextController.text,
                          form: FormModel(
                            addressAttribute_11: _giftNotesTextController.text,
                          ),
                          phone: _giftPhoneNumber?.phoneNumber ?? ''),
                    );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildGiftForm(BuildContext context) {
    return Form(
        key: _giftFormKey,
        autovalidateMode: _isGiftAutoValidating
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DefaultTextFormField(
                  isRequired: true,
                  hint: 'receiver_name'.tr(),
                  currentController: _receiverNameTextController,
                  currentFocusNode: _receiverNameFocusNode,
                  nextFocusNode: _giftPhoneFocusNode),
              const SizedBox(height: 16.0),
              PhoneTextFormField(
                currentController: _giftPhoneTextController,
                initialValue: _giftPhoneNumber,
                currentFocusNode: _giftPhoneFocusNode,
                nextFocusNode: _giftNotesFocusNode,
                onInputChanged: (value) => _giftPhoneNumber = value,
              ),
              const SizedBox(height: 16.0),
              DefaultTextFormField(
                  currentFocusNode: _giftNotesFocusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  currentController: _giftNotesTextController,
                  hint: 'notes'.tr())
            ],
          ),
        ));
  }

  bool _isGiftNotValid() {
    if (!_giftFormKey.currentState!.validate()) {
      setState(() => _isGiftAutoValidating = true);
      return true;
    }
    return false;
  }
}
