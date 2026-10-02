import 'package:als/home/add_subject/custom_widgets/custom_subject_tile.dart';
import 'package:als/viewmodel/home_controller.dart';
import 'package:als/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubjectTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      builder: (subjectController) {
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await subjectController.fetchAllSubject();
            },
            child: subjectController.subject.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: subjectController.subject.length,
                    itemBuilder: (context, index) {
                      final subject = subjectController.subject[index];
                      return CustomSubjectTile(
                        subjectName: subject["subject_name"],
                        index: index,
                        credits: subject["credits"],
                        icon: Icons.school_sharp,
                        onTap: () {},
                      );
                    },
                  )
                : Center(
                    child: Image.asset(
                      "assets/nosubjectfound.png",
                      height: 250.h,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
