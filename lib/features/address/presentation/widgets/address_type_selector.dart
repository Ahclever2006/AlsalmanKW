import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/enums/address_type_enum.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../res/style/app_colors.dart';

class AddressTypeSelector extends StatefulWidget {
  const AddressTypeSelector(
      {required this.onPress, required this.initialValue, super.key});

  final int initialValue;
  final ValueChanged<int> onPress;

  @override
  State<AddressTypeSelector> createState() => _AddressTypeSelectorState();
}

class _AddressTypeSelectorState extends State<AddressTypeSelector> {
  int? _initialValue;
  @override
  void initState() {
    _initialValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildAddressTypeItem(
            type: AddressType.home_type.index,
            isSelected: _initialValue == AddressType.home_type.index),
        const SizedBox(width: 16.0),
        _buildAddressTypeItem(
            type: AddressType.office_type.index,
            isSelected: _initialValue == AddressType.office_type.index),
        const SizedBox(width: 16.0),
        _buildAddressTypeItem(
            type: AddressType.other_type.index,
            isSelected: _initialValue == AddressType.other_type.index),
      ],
    );
  }

  Widget _buildAddressTypeItem({required int type, required bool isSelected}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _initialValue = type;
          });
          widget.onPress(type);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleText(
                text: type == AddressType.home_type.index
                    ? AddressType.home_type.name
                    : type == AddressType.office_type.index
                        ? AddressType.office_type.name
                        : AddressType.other_type.name,
                color: isSelected
                    ? AppColors.PRIMARY_COLOR_DARK
                    : AppColors.GREY_DARK_COLOR,
              ),
              const SizedBox(height: 16.0),
              SvgPicture.asset(
                type == AddressType.home_type.index
                    ? 'lib/res/assets/home_address_icon.svg'
                    : type == AddressType.office_type.index
                        ? 'lib/res/assets/office_address_icon.svg'
                        : 'lib/res/assets/other_address_icon.svg',
                color: isSelected
                    ? AppColors.PRIMARY_COLOR_DARK
                    : AppColors.GREY_DARK_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
