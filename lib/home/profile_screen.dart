import 'package:als/auth/custom_widgets/custom_button_two.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/main.dart';
import 'package:als/viewmodel/auth_controller.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButtonTwo(
          title: "Logout",
          callback: () async {
            await supabase.auth.signOut();
            final home = Get.find<HomeController>();
            home.changeIndex(0);
            Get.offAllNamed(AppRoutes.chooserole);
          },
          textColor: ColorPalette.error,
          color: Color.lerp(ColorPalette.error, Colors.white, 0.8),
        ),
      ),
    );
  }
}
