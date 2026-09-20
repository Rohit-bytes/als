import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? iconsize;

  const CustomCircleButton({
    super.key,
    this.onPressed,
    this.icon,
    this.iconsize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          shape: const CircleBorder(),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: Icon(icon ?? Icons.arrow_forward, size: iconsize ?? 28.w),
        ),
      ),
    );
  }
}
