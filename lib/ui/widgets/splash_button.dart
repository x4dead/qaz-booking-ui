import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';

class SplashButton extends StatelessWidget {
  const SplashButton({super.key, this.onTap, this.child});
  final VoidCallback? onTap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.colorTransparent,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
