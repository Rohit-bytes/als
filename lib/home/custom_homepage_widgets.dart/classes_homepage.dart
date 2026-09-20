import 'package:als/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassesHomepage extends StatelessWidget {
  final String? title;
  final VoidCallback onpress;
  final String? subtitle;
  const new({super.key, this.title, required this.onpress, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpress();
      },
      child: Container(
        height: 30.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: ColorPalette.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 80,
                    height: 80,
                    child: Icon(Icons.group, color: ColorPalette.background),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$title",
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: ColorPalette.white),
                  ),
                  Icon(Icons.arrow_right, color: ColorPalette.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "$subtitle students",
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: ColorPalette.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
