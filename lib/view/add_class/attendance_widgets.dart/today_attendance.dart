import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/view/add_class/attendance_widgets.dart/attendance_count_card.dart';
import 'package:als/view/add_class/attendance_widgets.dart/attendance_status.dart';
import 'package:als/view/add_class/attendance_widgets.dart/progress_card.dart';
import 'package:als/viewmodel/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodayAttendance extends StatefulWidget {
  final Map<String, dynamic> newClass;
  const new({super.key, required this.newClass});

  @override
  State<TodayAttendance> createState() => _TodayAttendanceState();
}

class _TodayAttendanceState extends State<TodayAttendance> {
  void fetchattendance() async {
    await Get.find<AttendanceController>().fetchStudentAttendance();
    await Get.find<AttendanceController>().fetchAllStudent(
      widget.newClass["id"],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchattendance();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      builder: (a) {
        return Container(
          decoration: BoxDecoration(
            color: ColorPalette.backgroundtop,
            border: Border.all(
              color: ColorPalette.primary.withOpacity(0.8),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    AttendanceProgressCard(
                      present: a.studentpresent.length,
                      total: 120,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          AttendanceCountCard(title: "Present", count: 76),
                          AttendanceCountCard(
                            title: "Absent",
                            count: 76,
                            countColor: ColorPalette.error,
                            iconColor: ColorPalette.error,
                            iconBackgroundColor: ColorPalette.error.withOpacity(
                              0.12,
                            ),
                          ),

                          AttendanceCountCard(
                            title: "Total Student",
                            count: a.students.length,
                            icon: Icons.people,
                            countColor: ColorPalette.black,
                            iconColor: ColorPalette.black,
                            iconBackgroundColor: ColorPalette.black.withOpacity(
                              0.08,
                            ),
                          ),
                        ],
                      ),
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
