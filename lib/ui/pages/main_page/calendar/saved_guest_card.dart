import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class SavedGuestCard extends StatelessWidget {
  const SavedGuestCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: const BoxDecoration(
          borderRadius: allCircularRadius12, color: AppColors.colorLightGray),
      child: Center(
          child: SvgPicture.asset(
        AppImages.save,
        colorFilter:
            const ColorFilter.mode(AppColors.colorGray, BlendMode.srcIn),
      )),
    );
  }
}
