import 'package:als/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final List<String> tabs;

  const ClassTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    this.tabs = const ['Students', 'Subjects', 'Attendance'],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorPalette.background,
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE9EEF5), width: 1.h),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          return Expanded(
            child: _ClassTab(
              title: tabs[index],
              isSelected: selectedIndex == index,
              onTap: () => onTabChanged(index),
            ),
          );
        }),
      ),
    );
  }
}

class _ClassTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClassTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(13.r)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF2379ED)
                      : const Color(0xFF667085),
                ),
                child: Text(title),
              ),
            ),

            // Blue selected indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: 3.h,
              width: isSelected ? 105.w : 0,
              decoration: BoxDecoration(
                color: const Color(0xFF2379ED),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
