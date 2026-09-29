import 'package:als/core/color_pallete.dart';
import 'package:als/home/add_class/attendance_tab.dart';
import 'package:als/home/add_class/student_tab.dart';
import 'package:als/home/add_class/subject_tab.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_tabbar.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UploadExcelSheet extends StatelessWidget {
  const UploadExcelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: CustomAppBar(title: ""),
          backgroundColor: ColorPalette.background,

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  // ================= CLASS HEADER =================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            ColorPalette.background,
                            Colors.white,
                            0.5,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.school_sharp,
                            color: Colors.blue,
                            size: 60.sp,
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeController.classNamecontrol.text.trim(),
                              style: TextStyle(
                                color: ColorPalette.textPrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            Text(
                              homeController.finalcourseName ?? "Not Found",
                              style: TextStyle(
                                color: ColorPalette.textSecondary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // ================= TAB BAR =================
                  ClassTabBar(
                    selectedIndex: homeController.tabIndex,
                    onTabChanged: (index) {
                      homeController.tabchange(index);
                    },
                  ),

                  SizedBox(height: 15.h),

                  // ================= TAB CONTENT =================
                  _buildTab(homeController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(HomeController homeController) {
    switch (homeController.tabIndex) {
      // STUDENTS
      case 0:
        return const StudentTab();

      // SUBJECTS
      case 1:
        return SubjectTab();

      // ATTENDANCE
      case 2:
        return AttendanceTab();

      default:
        return const StudentTab();
    }
  }
}
