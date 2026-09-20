import 'package:als/auth/custom_widgets/custom_circle_button.dart';
import 'package:als/core/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leadingwidget;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.showBackButton = true,
    this.leadingwidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40.h,
      backgroundColor: ColorPalette.background,
      elevation: 0,
      centerTitle: true,

      leading: showBackButton
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomCircleButton(
                icon: Icons.arrow_back_ios_new_rounded,
                iconsize: 16,
                onPressed: onBack ?? () => Navigator.pop(context),
              ),
            )
          : leadingwidget,

      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
