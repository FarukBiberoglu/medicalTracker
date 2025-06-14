import 'package:flutter/services.dart';

class HeightWeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Boş değer kontrolü
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Sadece rakam ve nokta girişine izin ver
    final filteredText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Slash'dan önceki ve sonraki değerleri ayır
    final parts = filteredText.split('/');
    String height = parts[0];
    String weight = parts.length > 1 ? parts[1] : '';

    // Boy kısmı için kontrol (1.XX formatında)
    if (height.length <= 4) {
      // İlk karakter 1 veya 2 olmalı
      if (height.isNotEmpty && !['1', '2'].contains(height[0])) {
        height = '';
      }
      // Nokta kontrolü
      if (height.length == 2 && !height.contains('.')) {
        height = '${height[0]}.${height[1]}';
      }
    } else {
      height = height.substring(0, 4);
    }

    // Kilo kısmı için kontrol (max 3 basamak)
    if (weight.length > 3) {
      weight = weight.substring(0, 3);
    }

    // Boy 4 karaktere ulaştığında otomatik slash ekle
    String finalText = height;
    if (height.length == 4 && weight.isNotEmpty) {
      finalText = '$height/$weight';
    } else if (height.length == 4) {
      finalText = '$height/';
    }

    return TextEditingValue(
      text: finalText,
      selection: TextSelection.collapsed(offset: finalText.length),
    );
  }
}
