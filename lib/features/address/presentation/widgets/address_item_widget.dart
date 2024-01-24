import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/enums/address_type_enum.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../data/models/addresses_model.dart';

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    Key? key,
    required this.address,
    this.onPress,
    this.inCheckOut = false,
    this.isSelected = false,
    this.backgroundColor = AppColors.PRIMARY_COLOR_LIGHT,
    this.borderColor = AppColors.GREY_NORMAL_COLOR,
  }) : super(key: key);

  final Address address;
  final VoidCallback? onPress;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? inCheckOut;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    String? placeType = _getPlaceType();
    String? avenue = _getAvenue();
    String? block = _getBlock();
    String? apartment = _getApartment();
    String? office = _getOffice();
    String? other = _getOther();
    String? floor = _getFloor();
    String? notes = _getNotes();
    //TODO: adjust extra fields
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (onPress != null && inCheckOut == true) onPress!();
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor!),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (placeType != null)
                  Row(
                    children: [
                      if (isSelected == true)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 16.0),
                          child: SvgPicture.asset(
                              'lib/res/assets/selected_icon.svg'),
                        ),
                      TitleText.large(
                        text: placeType,
                        color: AppColors.PRIMARY_COLOR_DARK,
                      ),
                    ],
                  ),
                const SizedBox(height: 16.0),
                SubtitleText(
                  text: address.firstName!,
                  color: AppColors.PRIMARY_COLOR_DARK,
                ),
                if (block != null)
                  SubtitleText(
                    text: block,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (address.address1 != null)
                  SubtitleText(
                    text: address.address1!,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (avenue != null)
                  SubtitleText(
                    text: avenue,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (floor != null)
                  SubtitleText(
                    text: floor,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (apartment != null &&
                    placeType == AddressType.home_type.name)
                  SubtitleText(
                    text: apartment,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (office != null && placeType == AddressType.office_type.name)
                  SubtitleText(
                    text: office,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (other != null && placeType == AddressType.other_type.name)
                  SubtitleText(
                    text: other,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                SubtitleText(
                  text: address.phoneNumber!,
                  color: AppColors.PRIMARY_COLOR_DARK,
                ),
                if (address.countryName != null)
                  SubtitleText(
                    text: address.countryName!,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (address.stateProvinceName != null)
                  SubtitleText(
                    text: address.stateProvinceName!,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (address.email != null)
                  SubtitleText(
                    text: address.email!,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
                if (notes != null)
                  SubtitleText(
                    text: notes,
                    color: AppColors.PRIMARY_COLOR_DARK,
                  ),
              ],
            ),
          ),
        ),
        if (onPress != null && inCheckOut == false)
          PositionedDirectional(
              top: 16.0,
              end: 24.0,
              child: InkWell(
                onTap: onPress,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('lib/res/assets/edit_icon.svg'),
                ),
              ))
      ],
    );
  }

  String? _getPlaceType() {
    var placeType = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 2)
        ?.defaultValue;
    switch (placeType) {
      case '0':
        placeType = AddressType.home_type.name;
        break;

      case '1':
        placeType = AddressType.office_type.name;
        break;

      case '2':
        placeType = AddressType.other_type.name;
        break;
      default:
    }
    return placeType;
  }

  String? _getOther() {
    String? other = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 12)
        ?.defaultValue;
    return other;
  }

  String? _getBlock() {
    final block = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 7)
        ?.defaultValue;
    return block;
  }

  String? _getAvenue() {
    final avenue = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 10)
        ?.defaultValue;
    return avenue;
  }

  String? _getApartment() {
    final apartment = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 5)
        ?.defaultValue;
    return apartment;
  }

  String? _getFloor() {
    final floor = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 4)
        ?.defaultValue;
    return floor;
  }

  String? _getOffice() {
    final office = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 9)
        ?.defaultValue;
    return office;
  }

  String? _getNotes() {
    final notes = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 11)
        ?.defaultValue;
    return notes;
  }
}
