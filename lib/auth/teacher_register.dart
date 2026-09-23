import 'package:als/auth/custom_widgets/custom_button.dart';
import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/auth/custom_widgets/custom_text_field.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/viewmodel/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeacherRegister extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Switch to Student",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
            toolbarHeight: 50.h,
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorPalette.background,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomCircleButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.chooserole);
                },
                icon: Icons.keyboard_arrow_left_rounded,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Image.asset("assets/school.png"),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      CustomText(
                        "Teacher Registration",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.w,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomText(
                        "Access your classes and manage\nattendance".tr,
                        style: TextStyle(fontSize: 16.w),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    errorText: authController.nameError,
                    controller: authController.regnamecontrol,
                    hint: "Enter Your Name".tr,
                    prefixIcon: Icons.email_outlined,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: authController.regEnrollNumcontrol,
                    errorText: authController.enrollNoError,
                    hint: "Enter Enrollment Number".tr,
                    prefixIcon: Icons.numbers,
                    isPassword: false,
                  ),

                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: authController.regEmailcontrol,
                    errorText: authController.signupEmailError,
                    hint: "Enter Email Address".tr,
                    prefixIcon: Icons.email_outlined,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: authController.regpasscontrol,
                    errorText: authController.signupPasswordError,
                    hint: "Create New Password".tr,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    errorText: authController.confirmPasswordError,
                    controller: authController.regreppasscontrol,
                    hint: "Repeat The Password".tr,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  SizedBox(height: 10.h),

                  CustomButton(
                    title: "Sign Up",
                    callback: () {
                      authController.isLoading == true
                          ? CircularProgressIndicator()
                          : authController.signupCheck(
                              authController.regnamecontrol.text.trim(),
                              authController.regEnrollNumcontrol.text.trim(),
                              authController.regEmailcontrol.text.trim(),
                              authController.regpasscontrol.text.trim(),
                              authController.regreppasscontrol.text.trim(),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed(AppRoutes.teacherlogin);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Don't have an Account? ",
                      style: TextStyle(color: ColorPalette.textSecondary),
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: TextStyle(color: ColorPalette.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
