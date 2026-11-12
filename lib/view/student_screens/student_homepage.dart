import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/view/add_subject/custom_widgets/custom_subject_tile.dart';
import 'package:als/view/custom_homepage_widgets.dart/custom_title_anchor.dart';
import 'package:als/view/custom_homepage_widgets.dart/custom_trackers.dart';
import 'package:als/view/student_screens/subject_attendance.dart';
import 'package:als/viewmodel/auth_controller.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:als/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentHomepage extends StatefulWidget {
  const new({super.key});

  @override
  State<StudentHomepage> createState() => _StudentHomepageState();
}

class _StudentHomepageState extends State<StudentHomepage> {
  void fetch() {
    final subjectController = Get.find<SubjectController>();
    final authController = Get.find<AuthController>();

    subjectController.fetchClassSubject(authController.userDetails!.classid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (subjectController) {
        return GetBuilder<AuthController>(
          builder: (authController) {
            return Scaffold(
              backgroundColor: ColorPalette.background,

              body: SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: () async {
                    final subjectController = Get.find<SubjectController>();
                    final authController = Get.find<AuthController>();

                    subjectController.fetchClassSubject(
                      authController.userDetails!.classid,
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            "Hello,\n${authController.userDetails?.name ?? "User"} 👋",
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTrackers(
                            color: ColorPalette.primaryLight,
                            title: "0",
                            subtitle: "Total Classes".tr,
                          ),
                          CustomTrackers(
                            color: ColorPalette.Green,
                            title: "0%",
                            subtitle: 'Attendance'.tr,
                          ),
                          CustomTrackers(
                            color: ColorPalette.error,
                            title: "100%",
                            subtitle: "Classes Missed",
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      CustomTitleAnchor(
                        title: "Subjects Schedule",
                        widget: Row(
                          children: [
                            TextButton(
                              child: Text("View All"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      subjectController.isloading == true
                          ? Container(
                              height: 30.h,
                              width: 30.w,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: subjectController.subject.length,
                              itemBuilder: (context, index) {
                                final s = subjectController.subject;
                                return CustomSubjectTile(
                                  showdeletebutton: false,
                                  subjectName: s[index]["subject_name"],
                                  credits: s[index]["credits"],
                                  index: index,
                                  onTap: () {
                                    Get.to(
                                      () => SubjectAttendance(
                                        subject_id: s[index]["id"],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
