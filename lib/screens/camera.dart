import 'package:ar_drawing/config/assets_path.dart';
import 'package:ar_drawing/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  // default size and position of image
  double x = (1.sw - 1050.w) / 2, y = (1.sh - 1050.w - 560.w) / 2;
  double w = 1050.w, h = 1050.w;
  // default off flash
  bool flash = false;
  Menus activeMenu = Menus.none;
  double opacityValue = 0.5;
  @override
  void initState() {
    super.initState();
    controller = cameras.isNotEmpty ? CameraController(cameras[0], ResolutionPreset.max) : null;
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
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
                    onTap: () {
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
          Image.asset(widget.draw.path, opacity: AlwaysStoppedAnimation(opacityValue)),
          Positioned(
            bottom: 48.w,
            right: 48.w,
            child: GestureDetector(
              onPanUpdate: (details) {
                final newX = x + details.delta.dx;
                final newY = y + details.delta.dy;
                x = (newX > 0 && newX < 1.sw - w) ? newX : x;
                y = (newY > 0 && newY < 1.sh - h) ? newY : y;
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

          if (activeMenu.activeMenuOpacity)
            Positioned(
              right: 0,
              left: 0,
              bottom: 360.w,
              child: _buildOpacityMenu(),
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
                    activeMenu.activeMenuOpacity ? AppSvgPath.btnMenuOpacity : AppSvgPath.btnMenuOpacity,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeMenu = activeMenu.activeMenuCamera ? Menus.none : Menus.picture;
                    });
                  },
                  child: SvgPicture.asset(
                    width: 240.w,
                    height: 240.w,
                    activeMenu.activeMenuCamera ? AppSvgPath.btnMenuCamera : AppSvgPath.btnMenuCamera,
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
                    activeMenu.activeMenuZoom ? AppSvgPath.btnMenuZoom : AppSvgPath.btnMenuZoom,
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
        height: 72.w,
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
}
