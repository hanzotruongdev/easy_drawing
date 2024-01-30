import 'package:ar_drawing/components/popup.dart';
import 'package:ar_drawing/config/assets_path.dart';
import 'package:ar_drawing/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraScreen extends StatefulWidget {
  final DrawAsset draw;
  const CameraScreen({super.key, required this.draw});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum Menus {
  none(-1),
  opacity(0),
  picture(1),
  video(2),
  zoomImage(3),
  zoomCamera(4);

  final int value;
  const Menus(this.value);

  get activeMenu => value != Menus.none.value;
  get activeMenuOpacity => value == Menus.opacity.value;
  get activeMenuCamera => value == Menus.picture.value || value == Menus.video.value;
  get activeMenuZoom => value == Menus.zoomImage.value || value == Menus.zoomCamera.value;
  get activeSubMenuPicture => value == Menus.picture.value;
  get activeSubMenuVideo => value == Menus.video.value;
  get activeSubMenuZoomImage => value == Menus.zoomImage.value;
  get activeSubMenuZoomCamera => value == Menus.zoomCamera.value;
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  // default size and position of image
  double x = (1.sw - 1050.w) / 2, y = (1.sh - 1050.w - 560.w) / 2;
  double w = 1050.w, h = 1050.w;
  // default off flash
  bool flash = false;
  Menus activeMenu = Menus.none;
  double opacityValue = 0.85;
  double zoomImageValue = 0.5;
  double zoomCameraValue = 0;
  bool recording = false;
  double zoomMinLevel = 0;
  double zoomMaxLevel = 0;

  @override
  void initState() {
    super.initState();
    controller = cameras.isNotEmpty ? CameraController(cameras[0], ResolutionPreset.max) : null;
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller!.setFlashMode(FlashMode.off);
      controller!.getMaxZoomLevel().then((value) => zoomMaxLevel = value);
      controller!.getMinZoomLevel().then((value) => zoomMinLevel = value);

      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7F8891),
      body: Column(
        children: [
          Container(
            color: Colors.black.withOpacity(0.46),
            padding: EdgeInsets.only(bottom: 72.w, left: 72.w, right: 72.w),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppImagePath.btnBack,
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                  Text(
                    'AR Drawing',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 96.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller?.setFlashMode(flash ? FlashMode.off : FlashMode.torch);
                      setState(() {
                        flash = !flash;
                      });
                    },
                    child: SvgPicture.asset(
                      AppSvgPath.iconFlash,
                      width: 120.w,
                      height: 120.w,
                      color: Colors.white.withOpacity(flash ? 1 : 0.25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: _buildCamPreview()),
        ],
      ),
    );
  }

  _buildCamPreview() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          // camera preview
          Positioned.fill(
            child: (controller != null) ? CameraPreview(controller!) : const Center(child: CupertinoActivityIndicator()),
          ),

          Positioned(
            left: x,
            top: y,
            width: w,
            height: h,
            child: _buildDrawSample(),
          ),

          // bottom menus
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomMenus(),
          )
        ],
      ),
    );
  }

  _buildDrawSample() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
              child: GestureDetector(
            onPanUpdate: (details) {
              final newX = x + details.delta.dx;
              final newY = y + details.delta.dy;
              // x = (newX > 0 && newX < 1.sw - w) ? newX : x;
              // y = (newY > 0 && newY < 1.sh - h) ? newY : y;
              x = newX;
              y = newY;
              setState(() {});
            },
            child: FittedBox(fit: BoxFit.fill, child: Image.asset(widget.draw.path, opacity: AlwaysStoppedAnimation(opacityValue))),
          )),
          Positioned(
            bottom: 48.w,
            right: 48.w,
            child: GestureDetector(
              onPanUpdate: (details) {
                final newX = x + details.delta.dx;
                final newY = y + details.delta.dy;
                // x = (newX > 0 && newX < 1.sw - w) ? newX : x;
                // y = (newY > 0 && newY < 1.sh - h) ? newY : y;
                x = newX;
                y = newY;
                setState(() {});
              },
              child: SvgPicture.asset(
                AppSvgPath.iconMove,
                height: 96.w,
                width: 96.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomMenus() {
    return Container(
      height: activeMenu.activeMenu ? 600.w : 360.w,
      decoration: BoxDecoration(
        color: const Color(0xff454A4F),
        borderRadius: BorderRadius.circular(120.w),
      ),
      child: Stack(
        children: [
          // line
          if (activeMenu.activeMenu)
            Positioned(
              left: 0,
              right: 0,
              bottom: 357.w,
              child: Container(
                height: 6.w,
                width: double.infinity,
                color: Colors.black,
              ),
            ),

          // opacity sub menu
          if (activeMenu.activeMenuOpacity)
            Positioned(
              right: 0,
              left: 0,
              bottom: 360.w,
              child: _buildOpacityMenu(),
            ),

          // camera sub menu
          if (activeMenu.activeMenuCamera)
            Positioned(
              top: 60.w,
              left: 0,
              right: 0,
              child: _buildCameraMenu(),
            ),

          // zoom sub menu
          if (activeMenu.activeMenuZoom)
            Positioned(
              top: 0.w,
              left: 0,
              right: 0,
              child: _buildZoomMenu(),
            ),

          // main menus
          Positioned(
            left: 0,
            right: 0,
            bottom: 60.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeMenu = activeMenu.activeMenuOpacity ? Menus.none : Menus.opacity;
                    });
                  },
                  child: SvgPicture.asset(
                    width: 240.w,
                    height: 240.w,
                    activeMenu.activeMenuOpacity ? AppSvgPath.btnMenuOpacityActive : AppSvgPath.btnMenuOpacity,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeMenu = activeMenu.activeMenuCamera
                          ? Menus.none
                          : recording
                              ? Menus.video
                              : Menus.picture;
                    });
                  },
                  child: SvgPicture.asset(
                    width: 240.w,
                    height: 240.w,
                    activeMenu.activeMenuCamera ? AppSvgPath.btnMenuCameraActive : AppSvgPath.btnMenuCamera,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeMenu = activeMenu.activeMenuZoom ? Menus.none : Menus.zoomImage;
                    });
                  },
                  child: SvgPicture.asset(
                    width: 240.w,
                    height: 240.w,
                    activeMenu.activeMenuZoom ? AppSvgPath.btnMenuZoomActive : AppSvgPath.btnMenuZoom,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildOpacityMenu() {
    return Column(children: [
      SvgPicture.asset(
        AppSvgPath.btnSubMenuOpacity,
        width: 179.w,
        height: 48.w,
      ),
      Row(
        children: [
          SizedBox(width: 120.w),
          SvgPicture.asset(
            AppSvgPath.iconOpacityDecrease,
            width: 72.w,
            height: 72.h,
          ),
          Expanded(
              child: Slider(
            inactiveColor: const Color(0xff1C2129),
            activeColor: const Color(0xff1C2129),
            thumbColor: const Color(0xff1C2129),
            value: opacityValue,
            onChanged: (value) {
              setState(() {
                opacityValue = value;
              });
            },
          )),
          SvgPicture.asset(
            AppSvgPath.iconOpacityIncrease,
            width: 72.w,
            height: 72.h,
          ),
          SizedBox(width: 120.w),
        ],
      )
    ]);
  }

  _buildCameraMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 196.w),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeMenu = Menus.picture;
                  });
                },
                child: SvgPicture.asset(
                  activeMenu.activeSubMenuPicture ? AppSvgPath.btnSubMenuCameraActive : AppSvgPath.btnSubMenuCamera,
                  height: 40.w,
                  width: 179.w,
                ),
              ),
              SizedBox(height: 138.w),

              GestureDetector(
                onTap: () {
                  setState(() {
                    activeMenu = Menus.video;
                  });
                },
                child: SvgPicture.asset(
                  activeMenu.activeSubMenuVideo ? AppSvgPath.btnSubMenuVideoActive : AppSvgPath.btnSubMenuVideo,
                  height: 40.w,
                  width: 179.w,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (activeMenu.activeSubMenuPicture) {
                    // take a pick ture
                    final file = await controller?.takePicture();
                    if (file == null) return;
                    // ignore: use_build_context_synchronously
                    final res = await AppPopups.showPopupPreview(context, file);
                    if (res) {
                      final saveRes = await GallerySaver.saveImage(file.path);
                      if (saveRes != null && saveRes) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Image saved!"),
                        ));
                      }
                    }
                  } else {
                    // start/ stop recording
                    if (recording) {
                      final file = await controller?.stopVideoRecording();
                      recording = false;

                      if (file == null) return;

                      // ignore: use_build_context_synchronously
                      final res = await AppPopups.showPopupPreview(context, file, video: true);
                      
                      if (res) {
                        final saveRes = await GallerySaver.saveVideo(file.path);
                        if (saveRes != null && saveRes) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Video saved!"),
                          ));
                        }
                      }
                    } else {
                      await controller?.startVideoRecording();
                      recording = true;
                    }
                  }

                  setState(() {});
                },
                child: SvgPicture.asset(
                  recording ? AppSvgPath.btnRecording : AppSvgPath.btnCapture,
                  width: 138.w,
                  height: 138.w,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildZoomMenu() {
    return Container(
      height: 237.w,
      padding: EdgeInsets.symmetric(horizontal: 123.w),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 138.w),
              GestureDetector(
                onTap: () {
                  if (activeMenu.activeSubMenuZoomCamera) {
                    activeMenu = Menus.zoomImage;
                  } else {
                    activeMenu = Menus.zoomCamera;
                  }
                  setState(() {});
                },
                child: SvgPicture.asset(
                  AppSvgPath.iconAdjust,
                  width: 72.w,
                  height: 72.w,
                ),
              ),
              SizedBox(height: 138.w),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 72.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                //
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeMenu = Menus.zoomCamera;
                    });
                  },
                  child: SvgPicture.asset(
                    activeMenu.activeSubMenuZoomCamera ? AppSvgPath.btnSubMenuCameraActive : AppSvgPath.btnSubMenuCamera,
                    width: 179.w,
                    height: 40.w,
                  ),
                ),
                SizedBox(height: 138.w),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeMenu = Menus.zoomImage;
                    });
                  },
                  child: SvgPicture.asset(
                    activeMenu.activeSubMenuZoomImage ? AppSvgPath.btnSubMenuZoomPictureActive : AppSvgPath.btnSubMenuZoomPicture,
                    height: 40.w,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100.w,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                SvgPicture.asset(
                  AppSvgPath.iconZoomOut,
                  width: 72.w,
                  height: 72.h,
                ),
                Expanded(
                    child: Slider(
                  inactiveColor: const Color(0xff1C2129),
                  activeColor: const Color(0xff1C2129),
                  thumbColor: const Color(0xff1C2129),
                  value: activeMenu.activeSubMenuZoomCamera ? zoomCameraValue : zoomImageValue,
                  onChanged: (value) async {
                    if (activeMenu.activeSubMenuZoomCamera) {
                      zoomCameraValue = value;
                      final zoomLevel = zoomCameraValue * (zoomMaxLevel - zoomMinLevel) + zoomMinLevel;
                      controller?.setZoomLevel(zoomLevel);
                    } else {
                      zoomImageValue = value;
                      final calculatedW = zoomImageValue * (2.sw - 500.w) + 500.w;
                      x = x - (calculatedW - w) / 2;
                      y = y - (calculatedW - h) / 2;
                      w = calculatedW;
                      h = calculatedW;

                      print('new x: $x, new y: $y, new width: $w, new height: $h');
                    }
                    setState(() {});
                  },
                )),
                SvgPicture.asset(
                  AppSvgPath.iconZoomIn,
                  width: 72.w,
                  height: 72.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
