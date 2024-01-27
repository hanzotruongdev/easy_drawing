import 'dart:async';

import 'package:ar_drawing/config/assets_path.dart';
import 'package:ar_drawing/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Đợi 2 giây sau đó chuyển đến màn hình chính
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(AppImagePath.imgSplash),
      ),
    );
  }
}
