import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/home/add_class/attendance_widgets.dart/attendance_count_card.dart';
import 'package:als/home/add_class/attendance_widgets.dart/attendance_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TodayAttendance extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minHeight: 100.h),
      height: 200.h,
      child: Column(
        children: [
          //today attendance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomCircleButton(
                    height: 40,
                    width: 40,
                    icon: Icons.calendar_month_outlined,
                    iconsize: 18,
                    onPressed: () {},
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText("Today's Attendance"),
                      Text(
                        "${DateFormat('dd MMM yyyy').format(DateTime.now()).toUpperCase()}",
                      ),
                    ],
                  ),
                ],
              ),
              AttendanceStatus(text: "Not Started"),
            ],
          ),

          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: 5,
                  backgroundColor: ColorPalette.background,
                  color: ColorPalette.primary,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    AttendanceCountCard(title: "Present", count: 76),
                    AttendanceCountCard(title: "Absent", count: 76),
                    AttendanceCountCard(title: "Total Student", count: 76),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
