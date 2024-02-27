import 'dart:math' as math;

import 'package:flutter/services.dart';

class DecimalTextInputFormatterNew extends TextInputFormatter {
  DecimalTextInputFormatterNew({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      } else {
        final regEx = RegExp(r"^\d*\.?\d*");
        String newString = regEx.stringMatch(newValue.text) ?? "";
        if (newString == newValue.text) {
          truncated = newValue.text;
          newSelection = newValue.selection;
        } else {
          truncated = oldValue.text;
          newSelection = oldValue.selection;
        }
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
