import 'package:als/auth/custom_widgets/custom_button_two.dart';
import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/auth/custom_widgets/custom_text_field.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/home/add_class/attendance_widgets.dart/attendance_checks.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_dropdown.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:als/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StartAttendanceScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<StartAttendanceScreen> createState() => _StartAttendanceScreenState();
}

class _StartAttendanceScreenState extends State<StartAttendanceScreen> {
  final Map<String, dynamic> newclass = Get.arguments;
  late SubjectController subjectController;
  @override
  void initState() {
    super.initState();

    subjectController = Get.find<SubjectController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subjectController.fetchClassSubject(newclass["id"].toString());
    });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (subjectController) {
        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(title: "Start Attendance"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomDropdown(
                  items: subjectController.subject.map((subject) {
                    return DropdownMenuEntry<String>(
                      value: subject['id'].toString() ?? '',
                      label:
                          '${subject['subject_name'] ?? ''} '.capitalizeFirst ??
                          "",
                    );
                  }).toList(),
                  hintText: "Select Subject",
                  label: "Select Subject",
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    CustomText(
                      "Date",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF17213A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                AbsorbPointer(
                  absorbing: true,
                  child: CustomTextField(
                    hint: DateFormat('dd MMM yyyy')
                        .format(DateTime.now())
                        .toUpperCase(),
                    prefixIcon: Icons.alarm,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomDropdown(
                  items: subjectController.duration.map((duration) {
                    return DropdownMenuEntry<String>(
                      value: duration['id'].toString() ?? '',
                      label: '${duration['time'] ?? ''} Seconds',
                    );
                  }).toList(),
                  hintText: "Select Duration",
                  label: "Select Duration",
                ),
                SizedBox(height: 10.h),
                AttendanceInfoCard(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonTwo(
                color: ColorPalette.Green,
                textColor: ColorPalette.white,
                radius: 10,
                prefixwidget: Icon(Icons.qr_code, color: ColorPalette.white),
                title: "Generate QR Code",
                callback: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
