import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/images.dart';
import 'package:calculator/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      Get.off(HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Center(
        child: SizedBox(
              height: 100,
              width: Get.width * 0.5,
              child: Image.asset(AppImage.images + "logo.png"),
            ),
      ),
    );
  }
}
