import 'package:als/auth/custom_widgets/custom_button.dart';
import 'package:als/auth/custom_widgets/custom_button_two.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentTab extends StatelessWidget {
  final Map<String, dynamic> newclass;
  const new({super.key, required this.newclass});

  @override
  Widget build(BuildContext context) {
    // final args = Get.arguments;

    // final classId = args['id'];

    return Center(
      child: Column(
        children: [
          Icon(Icons.groups, size: 300, color: ColorPalette.primaryLight),
          Text(
            "No Student added yet",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: ColorPalette.black,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            style: TextStyle(),
            "Add students to start taking attendance\nfor this class",
          ),
          SizedBox(height: 20.h),
          CustomButton(
            title: "Upload Excel Sheet",
            callback: () {
              final homeController = Get.find<HomeController>();
              homeController.pickexcelfile();
            },
          ),
          SizedBox(height: 10.h),
          CustomButtonTwo(
            title: "Manual Entry",
            callback: () {
              Get.toNamed(AppRoutes.enterStudentManually, arguments: newclass);
            },
          ),
        ],
      ),
    );
  }
}
