import 'package:als/auth/splash_screen.dart';
import 'package:als/core/app_binding.dart';
import 'package:als/core/app_pages.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'AttendEase',
          initialRoute: AppRoutes.landingpage,
          getPages: AppPages.pages,
          theme: AppTheme.lightTheme,
          initialBinding: AppBindings(),
        );
      },
    ),
  );
}
