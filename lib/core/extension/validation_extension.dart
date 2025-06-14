extension StringValidation on String? {
  /// Null ya da boş değilse true döner.
  bool get isNotEmptyOrNull => this != null && this!.trim().isNotEmpty;

  /// Email formatını, min ve max uzunluk şartlarını kontrol eder.
  /// [minLength] varsayılan olarak 15, [maxLength] ise 50 karakter.
  bool isValidEmail({int minLength = 15, int maxLength = 50}) {
    if (!isNotEmptyOrNull) return false;
    final trimmed = this!.trim();
    if (trimmed.length < minLength || trimmed.length > maxLength) return false;
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$",
    );
    return emailRegex.hasMatch(trimmed);
  }

  /// En az [minLength] karakterden oluşan bir şifre kontrolü.
  bool isValidPassword({int minLength = 8}) {
    return isNotEmptyOrNull && this!.trim().length >= minLength;
  }

  /// Sadece rakamlardan oluşuyor mu?
  bool isNumeric() {
    if (!isNotEmptyOrNull) return false;
    final numericRegex = RegExp(r'^\d+$');
    return numericRegex.hasMatch(this!.trim());
  }

  /// Sadece harf ve rakam içeriyor mu?
  bool isAlphaNumeric() {
    if (!isNotEmptyOrNull) return false;
    final alphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphaNumericRegex.hasMatch(this!.trim());
  }

  /// Belirtilen [length]'te ve [numericOnly] parametresine göre geçerli bir kod olup olmadığını kontrol eder.
  bool isValidCode({required int length, bool numericOnly = true}) {
    if (!isNotEmptyOrNull || this!.trim().length != length) return false;
    return numericOnly ? isNumeric() : isAlphaNumeric();
  }

  /// Verilen [pattern] ile eşleşme kontrolü yapar.
  bool isMatchingPattern(String pattern) {
    if (!isNotEmptyOrNull) return false;
    final regExp = RegExp(pattern);
    return regExp.hasMatch(this!.trim());
  }

  /// Minimum [minLength] kontrolü.
  bool hasMinLength(int minLength) {
    return isNotEmptyOrNull && this!.trim().length >= minLength;
  }

  /// Maksimum [maxLength] kontrolü.
  bool hasMaxLength(int maxLength) {
    return isNotEmptyOrNull && this!.trim().length <= maxLength;
  }

  /// Karakter sayısının [min] ile [max] arasında olup olmadığını kontrol eder.
  bool isBetweenLength({required int min, required int max}) {
    return isNotEmptyOrNull &&
        this!.trim().length >= min &&
        this!.trim().length <= max;
  }

  /// İsim ve soyisim için; minimum [minLength] karakter ve yalnızca harf (Türkçe karakterler dahil) ile boşluk kontrolü.
  bool isValidName({int minLength = 3}) {
    if (!isNotEmptyOrNull) return false;
    final nameRegex = RegExp(r'^[a-zA-ZçÇğĞıİöÖşŞüÜ\s]+$');
    final trimmed = this!.trim();
    return trimmed.length >= minLength && nameRegex.hasMatch(trimmed);
  }

  /// Yerel telefon numarası kontrolü (alan kodu hariç):
  /// Sadece rakamlardan oluşmalı ve [requiredLength] kadar hane içermeli.
  bool isValidLocalPhoneNumber({required int requiredLength}) {
    if (!isNotEmptyOrNull) return false;
    final trimmed = this!.trim();
    // '+' veya boşluk gibi karakterler kabul edilmez
    final phoneRegex = RegExp(r'^\d+$');
    return phoneRegex.hasMatch(trimmed) && trimmed.length == requiredLength;
  }

  /// Tam telefon numarası kontrolü (alan kodu dahil):
  /// İsteğe bağlı olarak başında '+' olabilir, ardından sadece rakamlar gelmeli.
  /// [totalDigits] parametresi, '+' işareti hariç tüm rakamların toplam sayısını belirtir.
  bool isValidFullPhoneNumber({required int totalDigits}) {
    if (!isNotEmptyOrNull) return false;
    final trimmed = this!.trim();
    // '+' varsa kaldırıp kalanının rakamlardan oluştuğunu kontrol et
    final processed = trimmed.startsWith('+') ? trimmed.substring(1) : trimmed;
    final phoneRegex = RegExp(r'^\d+$');
    return phoneRegex.hasMatch(processed) && processed.length == totalDigits;
  }


  /// Cinsiyet alanı için; [allowedValues] listesinde bulunan değerlerden biri olmalı.
  /// Örneğin: ['male', 'female', 'other'] gibi.
  bool isValidGender({List<String>? allowedValues}) {
    if (!isNotEmptyOrNull) return false;
    final gender = this!.trim().toLowerCase();
    allowedValues ??= ['male', 'female', 'other'];
    return allowedValues.contains(gender);
  }

  /// Konum (location) için, minimum ve maksimum karakter sınırı kontrolü.
  bool isValidLocation({int minLength = 2, int maxLength = 100}) {
    return isBetweenLength(min: minLength, max: maxLength);
  }

  /// Sosyal medya kullanıcı adı (handle) validasyonu.
  /// Harf, rakam, nokta ve alt çizgi karakterlerine izin verir.
  bool isValidSocialMediaHandle({int minLength = 3, int maxLength = 30}) {
    if (!isNotEmptyOrNull) return false;
    final handleRegex = RegExp(r'^[A-Za-z0-9._]+$');
    final trimmed = this!.trim();
    return trimmed.length >= minLength &&
        trimmed.length <= maxLength &&
        handleRegex.hasMatch(trimmed);
  }
}
