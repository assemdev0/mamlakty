import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/constants_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  void _startDelay() {
    _timer = Timer(
      const Duration(
        seconds: AppConstants.splashTime,
      ),
      _nextScreen,
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.mamlektyColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: AppSize.s0,
        backgroundColor: ColorManager.mamlektyColor,
      ),
      backgroundColor: ColorManager.mamlektyColor,
      body: Center(
        child: Image(width: AppSize.s100.w,
          image:const AssetImage(
            AssetsManager.logo,
          ),
        ),
      ),
    );
  }

  void _nextScreen() {
    Navigator.pushReplacementNamed(
      context,
      Routes.homeRoute,
    );
  }
}
