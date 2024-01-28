class AppImagePath {
  static const _folderPath = 'assets/images';
  static const imgSplash = '$_folderPath/splash.png';
  static const iconClose = '$_folderPath/icon_close.png';
  static const listIntroImgs = [
    '$_folderPath/intro1.png',
    '$_folderPath/intro2.png',
    '$_folderPath/intro3.png',
    '$_folderPath/intro4.png',
  ];
  static const iconSelectedGradient = '$_folderPath/icon_selected_gradient.png';
  static const btnContinue = '$_folderPath/btn_continue.png';
  static const btnSwitchOff = '$_folderPath/btn_switch_off.png';
  static const btnSwitchOn = '$_folderPath/btn_switch_on.png';
  static const btnUpload = '$_folderPath/btn_upload.png';
  static const bgCat = '$_folderPath/bg_cat.png';
  static const bgCatItem = '$_folderPath/bg_cat_item.png';
  static const bgCatItemLarge = '$_folderPath/bg_cat_item_large.png';
  static const iconStarActive = '$_folderPath/icon_star_active.png';
  static const iconStarInactive = '$_folderPath/icon_star_inactive.png';
  static const btnBack = '$_folderPath/btn_back.png';
  static const contentHelp = '$_folderPath/content_help.png';
}

class AppSvgPath {
  static const _folderPath = 'assets/svgs';
  static const listIntroTexts = [
    '$_folderPath/text-intro1.svg',
    '$_folderPath/text-intro2.svg',
    '$_folderPath/text-intro3.svg',
    '$_folderPath/text-intro4.svg',
  ];
  static const logo = '$_folderPath/logo.svg';
  static const btnHelp = '$_folderPath/btn_help.svg';
  static const bgPopupHelp = '$_folderPath/bg_popup_help.svg';
  static const iconMove = '$_folderPath/icon_move.svg';
  static const iconFlash = '$_folderPath/icon_flash.svg';
  static const btnMenuOpacity = '$_folderPath/btn_menu_opacity.svg';
  static const btnMenuCamera = '$_folderPath/btn_menu_camera.svg';
  static const btnMenuZoom = '$_folderPath/btn_menu_zoom.svg';
  static const iconOpacityDecrease = '$_folderPath/icon_opacity_decrease.svg';
  static const iconOpacityIncrease = '$_folderPath/icon_opacity_increase.svg';
  static const btnSubMenuOpacity = '$_folderPath/btn_sub_menu_opacity.svg';
}

class DrawAsset {
  static const _folderPath = 'assets/samples';
  final String name;
  final int star;

  get path => '$_folderPath/$name';
  DrawAsset({required this.name, this.star = 3});
}

Map<String, List> appSamplePath = {
  "Anime": [
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
  ],
  "Anatomy": [
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
  ],
  "Objects": [
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
    DrawAsset(name: 'sample1.png'),
  ],
};
