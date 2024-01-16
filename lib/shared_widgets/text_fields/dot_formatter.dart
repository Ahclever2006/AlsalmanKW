import 'package:flutter/services.dart';

class DotRestrictionFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value contains more than one dot
    if (newValue.text.contains('.') &&
        newValue.text.lastIndexOf('.') != newValue.text.indexOf('.')) {
      // Remove the additional dots
      return oldValue;
    }
    // Allow the update
    return newValue;
  }
}