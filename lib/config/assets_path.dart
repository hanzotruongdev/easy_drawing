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

  static const bgPopupHelp = '$_folderPath/bg_popup_help.svg';

  static const iconMove = '$_folderPath/icon_move.svg';
  static const iconZoomIn = '$_folderPath/icon_zoom_in.svg';
  static const iconZoomOut = '$_folderPath/icon_zoom_out.svg';
  static const iconAdjust = '$_folderPath/icon_adjust.svg';
  static const iconFlash = '$_folderPath/icon_flash.svg';
  static const iconOpacityDecrease = '$_folderPath/icon_opacity_decrease.svg';
  static const iconOpacityIncrease = '$_folderPath/icon_opacity_increase.svg';

  static const btnHelp = '$_folderPath/btn_help.svg';
  static const btnMenuOpacity = '$_folderPath/btn_menu_opacity.svg';
  static const btnMenuOpacityActive = '$_folderPath/btn_menu_opacity_active.svg';
  static const btnMenuCamera = '$_folderPath/btn_menu_camera.svg';
  static const btnMenuCameraActive = '$_folderPath/btn_menu_camera_active.svg';
  static const btnMenuZoom = '$_folderPath/btn_menu_zoom.svg';
  static const btnMenuZoomActive = '$_folderPath/btn_menu_zoom_active.svg';
  static const btnRecording = '$_folderPath/btn_recording.svg';
  static const btnCapture = '$_folderPath/btn_capture.svg';

  static const btnSubMenuOpacity = '$_folderPath/btn_sub_menu_opacity.svg';
  static const btnSubMenuCamera = '$_folderPath/btn_sub_menu_camera.svg';
  static const btnSubMenuCameraActive = '$_folderPath/btn_sub_menu_camera_active.svg';
  static const btnSubMenuVideo = '$_folderPath/btn_sub_menu_video.svg';
  static const btnSubMenuVideoActive = '$_folderPath/btn_sub_menu_video_active.svg';
  static const btnSubMenuZoomPicture = '$_folderPath/btn_sub_menu_zoom_picture.svg';
  static const btnSubMenuZoomPictureActive = '$_folderPath/btn_sub_menu_zoom_picture_active.svg';
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
  "350x350": [
    DrawAsset(name: '350x350/2023_12_22_09_33_IMG_2928-removebg-preview 3.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2929-removebg-preview 2.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2930.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2931-removebg-preview 2.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2932.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2933.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2934.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2936.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2937.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2938.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2939.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2942.png'),
    DrawAsset(name: '350x350/2023_12_22_09_34_IMG_2943.png'),
    DrawAsset(name: '350x350/2023_12_22_09_35_IMG_2944.png'),
    DrawAsset(name: '350x350/2023_12_22_09_35_IMG_2945.png'),
    DrawAsset(name: '350x350/2023_12_22_09_35_IMG_2946.png'),
    DrawAsset(name: '350x350/2023_12_22_09_35_IMG_2948.png'),
    DrawAsset(name: '350x350/2023_12_22_09_35_IMG_2949.png'),
    DrawAsset(name: '350x350/Vector.png'),
  ],
  "700x700": [
    DrawAsset(name: '700x700/2023_12_22_09_33_IMG_2928-removebg-preview 2.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2929-removebg-preview 1.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2930.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2931-removebg-preview 1.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2932.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2933.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2934.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2936.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2937.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2938.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2939.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2942.png'),
    DrawAsset(name: '700x700/2023_12_22_09_34_IMG_2943.png'),
    DrawAsset(name: '700x700/2023_12_22_09_35_IMG_2944.png'),
    DrawAsset(name: '700x700/2023_12_22_09_35_IMG_2945.png'),
    DrawAsset(name: '700x700/2023_12_22_09_35_IMG_2946.png'),
    DrawAsset(name: '700x700/2023_12_22_09_35_IMG_2948.png'),
    DrawAsset(name: '700x700/2023_12_22_09_35_IMG_2949.png'),
    DrawAsset(name: '700x700/Vector.png'),
  ],
  "test": [
    DrawAsset(name: '2023_12_22_09_33_IMG_2928-removebg-preview 2.png'),
    DrawAsset(name: '2023_12_22_09_34_IMG_2929-removebg-preview 1.png'),
    DrawAsset(name: '2023_12_22_09_34_IMG_2931-removebg-preview 1.png'),
    DrawAsset(name: '2023_12_22_09_34_IMG_2934.png'),
    DrawAsset(name: '2023_12_22_09_34_IMG_2936.png'),
    DrawAsset(name: '2023_12_22_09_34_IMG_2937.png'),
    DrawAsset(name: 'Vector.png'),
  ]
};
