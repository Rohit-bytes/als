import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceCountCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final Color countColor;

  const AttendanceCountCard({
    super.key,
    required this.title,
    required this.count,
    this.icon = Icons.person,
    this.iconColor = const Color(0xFF009B5A),
    this.iconBackgroundColor = const Color(0xFFDDF8EC),
    this.countColor = const Color(0xFF009B5A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h, // 👈 smaller height
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 25.sp, color: iconColor),
          ),

          SizedBox(width: 14.w),

          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: const Color(0xFF334B73),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Count
          Text(
            count.toString(),
            style: TextStyle(
              color: countColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(width: 4.w),
        ],
      ),
    );
  }
}
