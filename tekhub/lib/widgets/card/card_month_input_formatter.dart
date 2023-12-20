import 'package:flutter/services.dart';

class CardDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      final int nonZeroIndex = i + 1;
      if (nonZeroIndex.isEven && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    final String string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length),);
  }
}
