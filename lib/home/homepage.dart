import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/auth/custom_widgets/custom_text.dart';
import 'package:als/core/color_pallete.dart';
import 'package:als/home/custom_homepage_widgets.dart/classes_homepage.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_appbar.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_color_button.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_title_anchor.dart';
import 'package:als/home/custom_homepage_widgets.dart/custom_trackers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Homepage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Column(
        children: [
          Row(children: [CustomText("Hello,\n${"Mr. "}${"John Doe"} 👋")]),
          Row(children: [Text("Let's Make Today Productive!")]),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTrackers(
                color: ColorPalette.primaryLight,
                title: "4",
                subtitle: "Classes".tr,
              ),
              CustomTrackers(
                color: ColorPalette.Green,
                title: "128",
                subtitle: 'Students'.tr,
              ),
              CustomTrackers(
                color: ColorPalette.creme,
                title: "92%",
                subtitle: "Avg. Attendance",
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomTitleAnchor(
            title: "Classes".tr,
            widget: Row(
              children: [
                CustomColorButton(title: "+ Add Class", onpress: () {}),
                SizedBox(width: 5.w),
                CustomColorButton(title: "Show All", onpress: () {}),
              ],
            ),
          ),
          Container(
            height: 300.h,
            // color: Colors.amber,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 20.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.05,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ClassesHomepage(
                  title: "MCA Sem(1)",
                  subtitle: "120",
                  onpress: () {
                    // Open class
                    print(index);
                  },
                );
              },
            ),
          ),
          // SizedBox(height: 10.h),
          CustomTitleAnchor(
            title: "Today's Schedule",
            widget: Row(
              children: [TextButton(child: Text("View All"), onPressed: () {})],
            ),
          ),
        ],
      ),
    );
  }
}
