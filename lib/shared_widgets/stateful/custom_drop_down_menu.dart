import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/data/models/id_name_model.dart';
import '../../core/utils/type_defs.dart';
import '../../core/utils/validator.dart';
import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

class CustomDropDownMenu<T> extends StatefulWidget {
  const CustomDropDownMenu({
    Key? key,
    required T? currentItem,
    required List<T> items,
    String hint = '',
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
    EdgeInsets margin = EdgeInsets.zero,
    bool isRequired = false,
    bool underLine = true,
    required FutureValueChanged<T?>? onChanged,
    required String Function(T item) getStringFromItem,
    String? Function(T item)? getFontFamilyFromItem,
    bool Function(T item)? isDisabled,
    bool Function(T item)? isComingSoon,
  })  : _currentItem = currentItem,
        _items = items,
        _hint = hint,
        _padding = padding,
        _margin = margin,
        _isRequired = isRequired,
        _underline = underLine,
        _onChanged = onChanged,
        _getStringFromItem = getStringFromItem,
        _getFontFamilyFromItem = getFontFamilyFromItem,
        _isDisabled = isDisabled,
        _isComingSoon = isComingSoon,
        super(key: key);

  final T? _currentItem;
  final List<T> _items;
  final String _hint;
  final EdgeInsets _padding;
  final EdgeInsets _margin;
  final bool _isRequired;
  final bool _underline;
  final FutureValueChanged<T?>? _onChanged;
  final String Function(T item) _getStringFromItem;
  final String? Function(T item)? _getFontFamilyFromItem;
  final bool Function(T item)? _isDisabled;
  final bool Function(T item)? _isComingSoon;

  @override
  State<CustomDropDownMenu<T>> createState() => _CustomDropDownMenuState<T>();
}

class _CustomDropDownMenuState<T> extends State<CustomDropDownMenu<T>> {
  bool _isBusy = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget._margin,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        hint: _buildHintText(context),
        decoration: InputDecoration(
          contentPadding: widget._padding,
          // filled: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: AppColors.PRIMARY_COLOR_DARK,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          counterText: '',
          border: InputBorder.none,
          disabledBorder: widget._underline
              ? const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )
              : null,
        ),
        icon: _isBusy
            ? const FittedBox(child: CircularProgressIndicator())
            : widget._currentItem == null || widget._isRequired
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.PRIMARY_COLOR,
                  )
                : InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                    onTap: () => widget._onChanged != null
                        ? widget._onChanged!(null)
                        : null,
                  ),
        value: widget._currentItem,
        items: widget._items.map(_buildDropDownMenuItem(context)).toList(),
        validator: widget._isRequired ? Validator().validateEmptyValue : null,
        onChanged: _isBusy
            ? null
            : (value) {
                if (widget._onChanged == null) return;
                var futureOr = widget._onChanged!(value);
                if (futureOr is Future) {
                  _setButtonToBusy();
                  futureOr.whenComplete(_setButtonToReady);
                }
              },
        onTap: FocusScope.of(context).requestFocus,
      ),
    );
  }

  Widget _buildHintText(BuildContext context) {
    return TitleText(text: widget._hint + (widget._isRequired ? '*' : ''));
  }

  DropdownMenuItem<T> Function(T) _buildDropDownMenuItem(
    BuildContext context,
  ) =>
      (item) {
        final isEnabled =
            !(widget._isDisabled ?? _isDisabledDefaultCallback)(item);
        final isComingSoon =
            (widget._isComingSoon ?? _isComingSoonDefaultCallback)(item);
        return CustomDropDownMenuItem<T>(
          value: item,
          enabled: isEnabled,
          itemColor: isEnabled ? null : AppColors.GREY_NORMAL_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TitleText(
                  text: widget._getStringFromItem(item),
                  maxLines: 1,
                  fontFamily: widget._getFontFamilyFromItem != null
                      ? widget._getFontFamilyFromItem!(item)
                      : null,
                ),
              ),
              if (isComingSoon)
                Text(
                  'coming_soon'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
            ],
          ),
        );
      };

  bool _isDisabledDefaultCallback(T item) {
    final condition = !T.toString().contains((IdNameModel).toString());
    if (condition) return false;

    return (item as IdNameModel?)?.disabled ?? false;
  }

  bool _isComingSoonDefaultCallback(T item) {
    final condition = !T.toString().contains((IdNameModel).toString());
    if (condition) return false;

    return (item as IdNameModel?)?.comingSoon ?? false;
  }

  void _setButtonToReady() => setState(() => _isBusy = false);
  void _setButtonToBusy() => setState(() => _isBusy = true);
}

class CustomDropDownMenuItem<T> extends DropdownMenuItem<T> {
  const CustomDropDownMenuItem({
    Key? key,
    VoidCallback? onTap,
    T? value,
    bool enabled = true,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    required Widget child,
    Color? itemColor,
  })  : _itemColor = itemColor,
        super(
          key: key,
          onTap: onTap,
          value: value,
          enabled: enabled,
          alignment: alignment,
          child: child,
        );

  final Color? _itemColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
      decoration: BoxDecoration(color: _itemColor),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: child,
    );
  }
}
