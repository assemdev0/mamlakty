import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: ColorManager.primaryColor,
    primarySwatch: Colors.grey,
    //text theme
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.primaryColor,
      elevation: AppSize.s0,
      iconTheme: IconThemeData(color: ColorManager.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: getLightStyle(
        fontSize: FontSizeManager.s10.sp,
        color: ColorManager.grey,
      ),
      bodyMedium: getMediumStyle(
        fontSize: FontSizeManager.s12.sp,
        color: ColorManager.primaryColor,
      ),
      headlineLarge: getSemiBoldStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.primaryColor,
      ),
      headlineMedium: getMediumStyle(
        fontSize: FontSizeManager.s16.sp,
        color: ColorManager.primaryColor,
      ),
      displaySmall: getRegularStyle(
        fontSize: FontSizeManager.s12.sp,
        color: ColorManager.yellow,
      ),
      displayMedium: getMediumStyle(
        fontSize: FontSizeManager.s16.sp,
        color: ColorManager.white,
      ),
    ),
  );
}
