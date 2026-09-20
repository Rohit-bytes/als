import 'package:als/auth/choose_role.dart';
import 'package:als/auth/teacher_login.dart';
import 'package:als/auth/splash_screen.dart';
import 'package:als/auth/teacher_register.dart';
import 'package:als/home/landing_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.choose_role,
      page: () => const ChooseRole(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.teacherlogin,
      page: () => const TeacherLogin(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const TeacherRegister(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.landingpage,
      page: () => const LandingPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
