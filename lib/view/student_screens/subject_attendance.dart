import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/view/add_subject/custom_widgets/custom_subject_tile.dart';
import 'package:als/view/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubjectAttendance extends StatefulWidget {
  final int subject_id;

  const SubjectAttendance({super.key, required this.subject_id});

  @override
  State<SubjectAttendance> createState() => _SubjectAttendanceState();
}

class _SubjectAttendanceState extends State<SubjectAttendance> {
  void fetchdetails() async {
    try {
      await Get.find<SubjectController>().fetchsubject(widget.subject_id);
      await Get.find<SubjectController>().fetchupcomingclasses(
        widget.subject_id,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdetails();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (s) {
        if (s.singlesubjectdata!.isEmpty) {
          return Scaffold(
            backgroundColor: ColorPalette.background,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final subject = s.singlesubjectdata!;

        final subjectName = subject['subject_name']?.toString() ?? 'Subject';

        final credits = subject['credits'] ?? 0;

        return Scaffold(
          backgroundColor: ColorPalette.background,
          appBar: CustomAppBar(
            title: subjectName,
            fontsize: 16,
            actions: [
              CustomCircleButton(
                icon: Icons.refresh,
                iconsize: 18,
                onPressed: () {
                  fetchdetails();
                },
                height: 35,
              ),
            ],
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SUBJECT DETAILS
                  CustomSubjectTile(
                    subjectName: subjectName,
                    credits: credits,
                    index: 0,
                    showdeletebutton: false,
                  ),

                  const SizedBox(height: 12),

                  // MY ATTENDANCE
                  _sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'My Attendance',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View Details  ›',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        Row(
                          children: [
                            Expanded(
                              child: Center(child: _attendanceCircle(0)),
                            ),

                            Container(
                              width: 1,
                              height: 105,
                              color: Colors.grey.shade200,
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: Column(
                                children: [
                                  _attendanceInfo(
                                    'Present',
                                    '0',
                                    Colors.green,
                                    Icons.check_circle,
                                  ),
                                  _attendanceInfo(
                                    'Absent',
                                    '0',
                                    Colors.red,
                                    Icons.cancel,
                                  ),
                                  _attendanceInfo(
                                    'Total Classes',
                                    '0',
                                    Colors.blueGrey,
                                    Icons.person,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // // QUICK ACTIONS
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _quickAction(
                  //         'Class Schedule',
                  //         Icons.event_available,
                  //         Colors.blue,
                  //         const Color(0xFFE6F0FF),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 5),
                  //     Expanded(
                  //       child: _quickAction(
                  //         'Study Material',
                  //         Icons.menu_book,
                  //         Colors.deepPurple,
                  //         const Color(0xFFF0E9FF),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 5),
                  //     Expanded(
                  //       child: _quickAction(
                  //         'Assignments',
                  //         Icons.assignment,
                  //         Colors.orange,
                  //         const Color(0xFFFFF2D9),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 5),
                  //     Expanded(
                  //       child: _quickAction(
                  //         'Attendance History',
                  //         Icons.bar_chart,
                  //         Colors.green,
                  //         const Color(0xFFE4FAF0),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 18),

                  // UPCOMING CLASS
                  _sectionHeading('Upcoming Class'),

                  const SizedBox(height: 8),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: s.upcomingclasses.length,
                    itemBuilder: (context, index) {
                      return _classTile(
                        ontap: () {},
                        icon: Icons.event_available,
                        title:
                            "Attendance Id ${s.upcomingclasses[index]["id"]} | ${subjectName}",
                        subtitle:
                            '${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(s.upcomingclasses[index]["created_at"])).toUpperCase()}',
                        status:
                            'Duration ${s.upcomingclasses[index]["duration"]} Sec',
                        isUpcoming: true,
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // RECENT CLASSES
                  _sectionHeading('Recent Classes'),

                  const SizedBox(height: 8),

                  _classTile(
                    icon: Icons.check_circle,
                    title: '17 Sep 2026 • 10:00 AM',
                    subtitle: '',
                    status: 'Present',
                    isUpcoming: false,
                  ),

                  _classTile(
                    icon: Icons.check_circle,
                    title: '15 Sep 2026 • 10:00 AM',
                    subtitle: '',
                    status: 'Present',
                    isUpcoming: false,
                  ),

                  const SizedBox(height: 18),

                  // SCAN QR BUTTON
                ],
              ),
            ),
          ),

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar('Scan Attendance', 'Open QR scanner here');
                  },
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                  label: const Text(
                    'Scan Attendance QR',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2474F5),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // COMMON SECTION CARD
  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // ATTENDANCE CIRCLE
  Widget _attendanceCircle(int percentage) {
    return SizedBox(
      height: 110,
      width: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 92,
            width: 92,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 8,
              strokeCap: StrokeCap.round,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF2474F5)),
            ),
          ),
          Text(
            '$percentage%',
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ATTENDANCE DETAILS
  Widget _attendanceInfo(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // QUICK ACTION TILE
  Widget _quickAction(
    String title,
    IconData icon,
    Color iconColor,
    Color background,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Get.snackbar(title, '$title clicked');
      },
      child: Container(
        height: 84,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 25),
            const SizedBox(height: 7),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // SECTION HEADING
  Widget _sectionHeading(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            Get.snackbar(title, 'View all clicked');
          },
          child: const Text(
            'View All  ›',
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // CLASS TILE
  Widget _classTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    required bool isUpcoming,
    VoidCallback? ontap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: isUpcoming
                      ? const Color(0xFFE5F0FF)
                      : const Color(0xFFE1F9EE),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: isUpcoming ? Colors.blue : Colors.green,
                  size: 21,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isUpcoming
                      ? const Color(0xFFE5F0FF)
                      : const Color(0xFFE1F9EE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isUpcoming ? Colors.blue : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
