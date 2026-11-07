import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/view/student_screens/student_homepage.dart';
import 'package:als/view/teacher_homepage.dart';
import 'package:als/view/profile_screen.dart';
import 'package:als/main.dart';
import 'package:als/viewmodel/auth_controller.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const new({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final auth = Get.find<AuthController>();
    if (auth.user != null) auth.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return GetBuilder<AuthController>(
          builder: (authController) {
            return Scaffold(
              backgroundColor: ColorPalette.background,
              appBar: CustomAppBar(
                leadingwidget: homeController.currentIndex == 1
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomCircleButton(
                          onPressed: () {
                            homeController.changeIndex(0);
                          },
                          icon: Icons.keyboard_arrow_left,
                        ),
                      )
                    : Icon(Icons.menu),
                title: homeController.currentIndex == 1
                    ? "Profile"
                    : homeController.getGreeting(),

                showBackButton: false,
                actions: [
                  homeController.currentIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8,
                          ),
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            child: CustomCircleButton(
                              icon: Icons.edit_outlined,
                              iconsize: 16,
                              onPressed: () {
                                // supabase.auth.signOut();
                              },
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),

              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PageView(
                  controller: homeController.pageController,
                  onPageChanged: (value) {
                    homeController.changeIndex(value);
                  },
                  children: [
                    authController.isStudent == true
                        ? StudentHomepage()
                        : TeacherHomepage(),
                    ProfileScreen(),
                  ],
                ),
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: homeController.currentIndex,
                  onTap: (value) {
                    homeController.changeIndex(value);
                  },
                  // type: BottomNavigationBarType.shifting,
                  showUnselectedLabels: true,

                  selectedItemColor: ColorPalette.primary,
                  unselectedItemColor: ColorPalette.black,
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
              ),
            );
          },
        );
      },
    );
  }
}
