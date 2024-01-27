import 'package:ar_drawing/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262F38),
        body: Container(
            width: 1.sw,
            height: 1.sh,
            padding: EdgeInsets.symmetric(horizontal: 72.w),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xff384152),
                  Colors.black,
                ],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                _buildCloseBtn(),
                _buildIntroImage(),
                _buildContinueButton(),
              ],
            )));
  }

  _buildCloseBtn() {
    return SafeArea(
      bottom: false,
      child: (step != 3)
          ? SizedBox(height: 96.w)
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  AppImagePath.iconClose,
                  width: 96.w,
                  height: 96.w,
                )
              ],
            ),
    );
  }

  _buildIntroImage() {
    return Container(
      alignment: Alignment.center,
      height: 1146.w,
      width: 1146.w,
      child: Image.asset(AppImagePath.listIntroImgs[step]),
    );
  }

  _buildContinueButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...[0, 1, 2, 3].map((e) {
              if (step != e) {
                return Container(
                  height: 24.w,
                  width: 24.w,
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.w),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                child: Image.asset(
                  AppImagePath.iconSelectedGradient,
                  width: 72.w,
                  height: 24.w,
                ),
              );
            }).toList()
          ],
        ),
        SizedBox(height: 48.w),
        GestureDetector(
          onTap: () {
            if (step < 3) {
              setState(() {
                step += 1;
              });
            }
          },
          child: Image.asset(
            AppImagePath.btnContinue,
            width: 1146.w,
            height: 192.w,
          ),
        )
      ],
    );
  }
}
