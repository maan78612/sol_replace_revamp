import 'package:flutter/services.dart';

class TextFieldFormatters{
  // Input Formatters

  /// VAT Number formatter - Uppercase letters and digits only
  static List<TextInputFormatter> getVATNumberFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
      UpperCaseTextFormatter(),
      LengthLimitingTextInputFormatter(14),
    ];
  }

  /// Full Name formatter - Letters, spaces, dots, apostrophes, hyphens only
  static List<TextInputFormatter> getFullNameFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s.'-]")),
      LengthLimitingTextInputFormatter(100),
      TrimSpacesFormatter(),
    ];
  }

  /// Postal Code formatter - Letters, digits, spaces, hyphens only
  static List<TextInputFormatter> getPostalCodeFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9 -]')),
      UpperCaseTextFormatter(),
      LengthLimitingTextInputFormatter(10),
    ];
  }

  /// Address formatter - Letters, digits, common symbols
  static List<TextInputFormatter> getAddressFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\s/.,'-]")),
      LengthLimitingTextInputFormatter(300),
      TrimSpacesFormatter(),
    ];
  }

  /// Email formatter - Standard email characters, lowercase
  static List<TextInputFormatter> getEmailFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._%+-@]')),
      LowerCaseTextFormatter(),
      LengthLimitingTextInputFormatter(254), // RFC 5321 limit
    ];
  }
}

// Custom Text Input Formatters

/// Converts input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Converts input to lowercase
class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

/// Trims multiple spaces to single spaces
class TrimSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String trimmed = newValue.text.replaceAll(RegExp(r'\s+'), ' ');

    return TextEditingValue(
      text: trimmed,
      selection: TextSelection.collapsed(
        offset: trimmed.length > newValue.selection.end
            ? newValue.selection.end
            : trimmed.length,
      ),
    );
  }
}

/// Capitalize first letter of each word
class CapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String capitalized = newValue.text
        .split(' ')
        .map((word) => word.isEmpty
        ? word
        : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');

    return TextEditingValue(
      text: capitalized,
      selection: newValue.selection,
    );
  }
}