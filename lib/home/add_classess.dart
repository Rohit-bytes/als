import 'package:als/core/color_pallete.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/viewmodel/auth_controller.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';

class AddClassess extends StatefulWidget {
  const new({super.key});

  @override
  State<AddClassess> createState() => _AddClassessState();
}

class _AddClassessState extends State<AddClassess> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        print(homeController.courses);
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(title: "Add New Class"),
          body: Center(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/addClass.png", height: 100.h),
                    Text(
                      textAlign: TextAlign.center,
                      "Create a new class and add students\nto start taking attendance.",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
