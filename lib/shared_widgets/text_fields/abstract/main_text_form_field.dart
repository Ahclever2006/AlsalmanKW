import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../res/style/app_colors.dart';

abstract class MainTextFormField extends StatefulWidget {
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? margin;
  final bool enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool expanded;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final Color? borderColor;
  final Color? hintColor;
  final bool enableSuggestions;
  final bool showScrollbar;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? style;
  final VoidCallback? onTap;

  const MainTextFormField({
    Key? key,
    required this.currentFocusNode,
    this.nextFocusNode,
    required this.currentController,
    required this.hintText,
    this.keyboardType,
    required this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.enabled = true,
    this.maxLength,
    this.inputFormatters,
    this.expanded = false,
    this.maxLines,
    this.contentPadding,
    this.borderColor,
    this.hintColor,
    this.enableSuggestions = false,
    this.showScrollbar = false,
    this.obscureText,
    this.suffixIcon,
    this.onChanged,
    this.fillColor,
    this.cursorColor,
    this.style,
    this.prefixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  TextDirection? _currentDir;
  @override
  Widget build(BuildContext context) {
    _currentDir ??= context.locale == const Locale('ar')
        ? TextDirection.rtl
        : TextDirection.ltr;
    Widget textFieldWidget = TextFormField(
        onTap: widget.onTap ??
            () {
              var selection = widget.currentController.selection;
              var length = widget.currentController.text.length;
              var isLast = selection ==
                  TextSelection.fromPosition(TextPosition(offset: length - 1));
              if (isLast) {
                selection =
                    TextSelection.fromPosition(TextPosition(offset: length));
              }
            },
        cursorColor: widget.cursorColor,
        textDirection: _currentDir,
        focusNode: widget.currentFocusNode,
        controller: widget.currentController,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        expands: widget.expanded,
        enableSuggestions: widget.enableSuggestions,
        style: widget.style ??
            context
                .sizeHelper(
                    mobileLarge: Theme.of(context).textTheme.bodyText1!,
                    tabletSmall: Theme.of(context).textTheme.bodyText2!,
                    tabletNormal: Theme.of(context).textTheme.bodyText2!,
                    desktopSmall: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 21.0))
                .copyWith(color: Colors.black),
        textCapitalization: widget.textCapitalization,
        textAlignVertical:
            widget.expanded ? const TextAlignVertical(y: -0.8) : null,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          fillColor: widget.enabled ? Colors.white : Colors.white,
          filled: true,
          contentPadding:
              widget.contentPadding ?? const EdgeInsets.fromLTRB(16, 0, 16, 0),
          hintText: widget.hintText,
          hintStyle: context
              .sizeHelper(
                mobileLarge: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 10.0),
                tabletSmall: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 12.0),
                tabletNormal: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 12.0),
                desktopSmall: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 20.0),
              )
              .copyWith(
                  color: widget.hintColor ??
                      widget.borderColor ??
                      AppColors.GREY_DARK_COLOR),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.PRIMARY_COLOR),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.PRIMARY_COLOR),
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
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.GREY_LIGHT_COLOR),
          ),
        ),
        validator: widget.validator,
        onChanged: (text) {
          if (text.isEmpty)
            setState(() => _currentDir = null);
          else {
            final dir = _getDirection(text);
            if (dir != _currentDir) setState(() => _currentDir = dir);
          }
          (widget.onChanged ?? (_) {})(text);
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        });

    if (widget.showScrollbar)
      textFieldWidget = Scrollbar(child: textFieldWidget);

    return Container(
      margin: widget.margin,
      child: textFieldWidget,
    );
  }

  TextDirection _getDirection(String v) {
    final string = v.trim();
    if (string.isEmpty) return TextDirection.ltr;
    final firstUnit = string.codeUnitAt(0);
    if (firstUnit > 0x0600 && firstUnit < 0x06FF ||
        firstUnit > 0x0750 && firstUnit < 0x077F ||
        firstUnit > 0x07C0 && firstUnit < 0x07EA ||
        firstUnit > 0x0840 && firstUnit < 0x085B ||
        firstUnit > 0x08A0 && firstUnit < 0x08B4 ||
        firstUnit > 0x08E3 && firstUnit < 0x08FF ||
        firstUnit > 0xFB50 && firstUnit < 0xFBB1 ||
        firstUnit > 0xFBD3 && firstUnit < 0xFD3D ||
        firstUnit > 0xFD50 && firstUnit < 0xFD8F ||
        firstUnit > 0xFD92 && firstUnit < 0xFDC7 ||
        firstUnit > 0xFDF0 && firstUnit < 0xFDFC ||
        firstUnit > 0xFE70 && firstUnit < 0xFE74 ||
        firstUnit > 0xFE76 && firstUnit < 0xFEFC ||
        firstUnit > 0x10800 && firstUnit < 0x10805 ||
        firstUnit > 0x1B000 && firstUnit < 0x1B0FF ||
        firstUnit > 0x1D165 && firstUnit < 0x1D169 ||
        firstUnit > 0x1D16D && firstUnit < 0x1D172 ||
        firstUnit > 0x1D17B && firstUnit < 0x1D182 ||
        firstUnit > 0x1D185 && firstUnit < 0x1D18B ||
        firstUnit > 0x1D1AA && firstUnit < 0x1D1AD ||
        firstUnit > 0x1D242 && firstUnit < 0x1D244) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}
