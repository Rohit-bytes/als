import 'package:als/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonTwo extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final Widget? prefixwidget;
  const new({
    super.key,
    required this.title,
    required this.callback,
    this.prefixwidget,
    this.color,
    this.radius,
    this.textColor,
  });

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
          color: color ?? ColorPalette.white,
          borderRadius: BorderRadius.circular(radius ?? 50),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixwidget ?? SizedBox(),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: textColor ?? ColorPalette.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
