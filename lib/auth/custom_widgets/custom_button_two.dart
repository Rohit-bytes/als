import 'package:als/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonTwo extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const new({super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: ColorPalette.black,
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
