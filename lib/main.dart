import 'package:als/auth/splash_screen.dart';
import 'package:als/core/app_binding.dart';
import 'package:als/core/app_pages.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/core/app_text.dart';
import 'package:als/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppText.supabaseUrl,
    publishableKey: AppText.supabasePublishableUrl,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'AttendEase',
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          theme: AppTheme.lightTheme,
          initialBinding: AppBindings(),
        );
      },
    ),
  );
}
