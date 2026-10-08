import 'package:als/auth/custom_widgets/custom_button_two.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/home/add_class/attendance_widgets.dart/today_attendance.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TodayAttendance(),
          SizedBox(height: 10.h),
          CustomButtonTwo(
            color: ColorPalette.primary,
            textColor: ColorPalette.white,
            radius: 10,
            prefixwidget: Icon(Icons.qr_code, color: ColorPalette.white),
            title: "Start Attendance",
            callback: () {},
          ),
        ],
      ),
    );
  }
}
