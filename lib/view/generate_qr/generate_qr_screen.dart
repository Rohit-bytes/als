import 'package:als/auth/custom_widgets/custom_button_two.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/view/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:als/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateQrScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> newclass = Get.arguments;
    final String subject = Get.arguments;
    final String date = Get.arguments;
    final String duration = Get.arguments;
    return GetBuilder<SubjectController>(
      builder: (subController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,

          appBar: CustomAppBar(
            title: newclass["class_name"],
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.Green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4,
                    ),
                    child: SizedBox(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Active",
                        style: TextStyle(
                          color: ColorPalette.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Center(child: Column(children: [Text(subject)])),
        );
      },
    );
  }
}
