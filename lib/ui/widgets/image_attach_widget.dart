import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/dashed_rect.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

class ImageAttachWidget extends StatelessWidget {
  const ImageAttachWidget({super.key, this.image, this.onTap, this.centerText});
  final DecorationImage? image;
  final VoidCallback? onTap;
  final String? centerText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 100,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: allCircularRadius12,
        color: AppColors.colorLightGray,
        image: image,
      ),
      child: DashedRect(
        child: SplashButton(
          onTap: onTap,
          child: centerText != null
              ? Center(
                  child: Text(
                    centerText ?? '',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.w500s16.copyWith(
                        color: AppColors.colorDarkGray,
                        height: 11.0.toFigmaHeight(16)),
                  ),
                )
              : kNothing,
        ),
      ),
    );
  }
}
