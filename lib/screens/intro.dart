import 'package:ar_drawing/config/assets_path.dart';
import 'package:ar_drawing/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int step = 0;
  bool freeTrial = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262F38),
        body: Container(
            width: 1.sw,
            height: 1.sh,
            padding: EdgeInsets.symmetric(horizontal: 72.h),
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
                SizedBox(height: 48.h),
                _buildIntroImage(),
                Expanded(
                  child: _buildIntroText(),
                ),
                Column(
                  children: [
                    _buildContinueButton(),
                    SizedBox(height: 48.h),
                    _buildLink(),
                  ],
                )
              ],
            )));
  }

  _buildCloseBtn() {
    return SafeArea(
      bottom: false,
      child: (step != 3)
          ? SizedBox(height: 96.h)
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  AppImagePath.iconClose,
                  width: 96.h,
                  height: 96.h,
                )
              ],
            ),
    );
  }

  _buildIntroImage() {
    return Container(
      alignment: Alignment.center,
      height: 1146.h,
      width: 1146.h,
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
                  height: 24.h,
                  width: 24.h,
                  margin: EdgeInsets.symmetric(horizontal: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.h),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.h),
                child: Image.asset(
                  AppImagePath.iconSelectedGradient,
                  width: 72.h,
                  height: 24.h,
                ),
              );
            }).toList()
          ],
        ),
        SizedBox(height: 48.h),
        GestureDetector(
          onTap: () {
            if (step < 3) {
              setState(() {
                step += 1;
              });
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
          child: Image.asset(
            AppImagePath.btnContinue,
            width: 1146.h,
            height: 192.h,
          ),
        )
      ],
    );
  }

  _buildIntroText() {
    if (step < 3) return SvgPicture.asset(AppSvgPath.listIntroTexts[step]);
    return _buildIntroText3();
  }

  _buildIntroText3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          AppSvgPath.listIntroTexts[3],
          height: 283.h,
        ),
        Column(
          children: [
            Text(
              'Just \$6,13/week',
              style: TextStyle(
                color: Colors.white,
                fontSize: 72.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Auto-renewable. Cancel anytime.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 48.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Container(
          height: 192.h,
          padding: EdgeInsets.symmetric(horizontal: 48.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(96.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not sure yet?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Enable free trial',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    freeTrial = !freeTrial;
                  });
                },
                child: Image.asset(
                  freeTrial ? AppImagePath.btnSwitchOn : AppImagePath.btnSwitchOff,
                  height: 96.h,
                  width: 192.h,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _buildLink() {
    return SafeArea(
      top: false,
      child: (step < 3)
          ? SizedBox(height: 72.h)
          : GestureDetector(
              onTap: () {},
              child: Text(
                'Restore Purchase',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
    );
  }
}
