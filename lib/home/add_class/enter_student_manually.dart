import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterStudentManually extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> newClass = Get.arguments;

    // String course = newClass['course'];
    // String semester = newClass['semester'];
    String className = newClass['class_name'];
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(title: ""),
          body: Center(
            child: Column(
              children: [
                CustomText("Add Student Manually"),
                Text("Enter student details to add to ${className}"),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: ColorPalette.primary,
            child: Icon(Icons.add, color: ColorPalette.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(50),
            ),
          ),
        );
      },
    );
  }
}
