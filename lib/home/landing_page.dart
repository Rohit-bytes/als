import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/home/homepage.dart';
import 'package:als/main.dart';
import 'package:als/viewmodel/auth_controller.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return GetBuilder<AuthController>(
          builder: (authController) {
            return Scaffold(
              appBar: CustomAppBar(
                leadingwidget: Icon(Icons.menu),
                title: "",
                showBackButton: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      child: CustomCircleButton(
                        icon: Icons.person,
                        iconsize: 16,
                        onPressed: () {
                          supabase.auth.signOut();
                        },
                      ),
                    ),
                  ),
                ],
              ),

              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PageView(children: [Homepage()]),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: homeController.currentIndex,
                onTap: (value) {
                  homeController.changeIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile".tr,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
