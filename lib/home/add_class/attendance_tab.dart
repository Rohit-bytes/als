import 'package:als/home/add_class/attendance_widgets.dart/today_attendance.dart';
import 'package:flutter/material.dart';

class AttendanceTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [TodayAttendance()]);
  }
}
