import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.colorWhite,
      label: Text(
        title,
        style: AppTextStyle.w400s15SFProDisplay,
      ),
      labelPadding: kPZero,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: const RoundedRectangleBorder(
        borderRadius: allCircularRadius12,
        side: BorderSide(
            color: AppColors.colorGray,
            strokeAlign: BorderSide.strokeAlignInside),
      ),
    );
  }
}
