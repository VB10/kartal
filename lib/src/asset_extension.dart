extension AssetPathHelper on String {
  String get asAssetPath => 'assets/$this';

  String get asImagePath => 'assets/images/$this';

  String get asIconPath => 'assets/icons/$this';

  String get asJsonPath => 'assets/json/$this';

  String get asSvgPath => 'assets/svg/$this';

  String get asLottiePath => 'assets/lottie/$this';

  String get asFontPath => 'assets/fonts/$this';

  String get asAudioPath => 'assets/audio/$this';

  String get asVideoPath => 'assets/video/$this';
}

extension AssetHelper on String {
  String get asset => 'assets/$this';
  String get image => 'assets/images/$this';
  String get icon => 'assets/icons/$this';
  String get json => 'assets/json/$this';
  String get svg => 'assets/svg/$this';
  String get lottie => 'assets/lottie/$this';
  String get font => 'assets/fonts/$this';
  String get audio => 'assets/audio/$this';
  String get video => 'assets/video/$this';
}
