import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../data/models/addresses_model.dart';

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    Key? key,
    required this.address,
    required this.onPress,
    this.backgroundColor = AppColors.PRIMARY_COLOR,
    this.borderColor = AppColors.PRIMARY_COLOR,
  }) : super(key: key);

  final Address address;
  final VoidCallback onPress;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    String? placeType = _getPlaceType();
    String? avenue = _getAvenue();
    String? block = _getBlock();
    String? apartment = _getApartment();
    String? floor = _getFloor();
    String? notes = _getNotes();

    return InkWell(
      onTap: onPress,
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
            if (placeType != null) TitleText.large(text: placeType),
            const SizedBox(height: 16.0),
            SubtitleText(text: address.firstName!),
            if (block != null) SubtitleText(text: block),
            if (address.address1 != null) SubtitleText(text: address.address1!),
            if (avenue != null) SubtitleText(text: avenue),
            if (floor != null) SubtitleText(text: floor),
            if (apartment != null) SubtitleText(text: apartment),
            SubtitleText(text: address.phoneNumber!),
            if (address.countryName != null)
              SubtitleText(text: address.countryName!),
            if (address.stateProvinceName != null)
              SubtitleText(text: address.stateProvinceName!),
            if (address.email != null) SubtitleText(text: address.email!),
            if (notes != null) SubtitleText(text: notes),
          ],
        ),
      ),
    );
  }

  String? _getPlaceType() {
    final placeType = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 2)
        ?.defaultValue;
    return placeType;
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

  String? _getNotes() {
    final notes = address.customAddressAttributes!
        .firstWhereOrNull((e) => e.id == 11)
        ?.defaultValue;
    return notes;
  }
}
