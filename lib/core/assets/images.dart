final class Images {
  Images._();
  static Images? _instace;
  static Images get instance {
    if (_instace != null) return _instace!;
    _instace = Images._();
    return _instace!;
  }

  static const String _basePath = "assets/";

  String _joinPath(String filename) => '$_basePath$filename';
  String get logo => _joinPath("logo/logo.png");
  String get logoLight => _joinPath("logo/logo_light.png");
  String get imgMainpageMyDayGeneric =>
      _joinPath("images/img_mainpage_myday_generic.png");
  String get imgMainpageMyDayInterest =>
      _joinPath("images/img_mainpage_myday_interest.png");
  String get imgMainpageMyDayPadel =>
      _joinPath("images/img_mainpage_myday_padel.png");
  String get imgMainpageMyDayPeople =>
      _joinPath("images/img_mainpage_myday_people.png");
  String get imgMainpageMyDayWisdom =>
      _joinPath("images/img_mainpage_myday_wisdom.png");
  String get imgMainpageMyooba1 => _joinPath("images/img_mainpage_myooba1.png");
  String get imgMainpageMyooba2 => _joinPath("images/img_mainpage_myooba2.png");
  String get imgSignIn => _joinPath("images/img_sign_in.png");
  String get proifleImage => _joinPath("images/profile_image.png");
  String get imageOverGradient => _joinPath("images/image_over_gradient.png");
}
