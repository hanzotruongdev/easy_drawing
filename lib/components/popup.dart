import 'package:ar_drawing/config/assets_path.dart';
import 'package:ar_drawing/screens/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppPopups {
  static showPopupHelp(BuildContext c) {
    showDialog(
        context: c,
        builder: ((context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: SizedBox(
              width: 1050.w,
              height: 1500.w,
              child: Stack(
                children: [
                  // bg
                  Positioned.fill(child: SvgPicture.asset(AppSvgPath.bgPopupHelp)),
                  // content
                  Positioned(
                    top: 5.w,
                    bottom: 5.w,
                    right: 5.w,
                    left: 5.w,
                    child: SingleChildScrollView(
                      child: Image.asset(AppImagePath.contentHelp),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  static showPopupItemDetail(BuildContext c, DrawAsset da) {
    showModalBottomSheet(
      context: c,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(240.w), bottom: Radius.circular(120.w)),
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          width: 1290.w,
          height: 1674.w,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xff384152),
                  Colors.black,
                ],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(240.w), bottom: Radius.circular(120.w))),
          child: Stack(
            children: [
              // image
              Positioned(
                top: 120.w,
                left: 120.w,
                right: 120.w,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(120.w)),
                  child: Image.asset(
                    da.path,
                    width: 1050.w,
                    height: 1050.w,
                  ),
                ),
              ),

              // star
              Positioned(
                left: 0,
                right: 0,
                bottom: 350.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.filled(da.star, 1).map((e) {
                      return Image.asset(
                        AppImagePath.iconStarActive,
                        width: 72.w,
                        height: 72.w,
                      );
                    }).toList(),
                    ...List.filled(5 - da.star, 1).map((e) {
                      return Image.asset(
                        AppImagePath.iconStarInactive,
                        width: 72.w,
                        height: 72.w,
                      );
                    }).toList(),
                  ],
                ),
              ),

              // bottom button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(c, MaterialPageRoute(builder: (context) => CameraScreen(draw: da)));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 240.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color(0xffEC4899),
                          Color(0xffEF4444),
                          Color(0xffEAB308),
                        ],
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(120.w)),
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 96.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
