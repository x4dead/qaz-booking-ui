import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      color: AppColors.colorWhite,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: kPAll20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.colorBlue,
                  radius: 30,
                  child: Center(
                    child: Text(
                      'П',
                      style: AppTextStyle.w600s24
                          .copyWith(color: AppColors.colorWhite),
                    ),
                  ),
                ),
                kSBH15,
                Text('Пётр',
                    style: AppTextStyle.w500s18Ellipsis
                        .copyWith(color: AppColors.colorBlack)),
                kSBH15,
                Text(
                  'Petr12@gmail.com',
                  style: AppTextStyle.w500s14.copyWith(
                      height: 10.0.toFigmaHeight(14),
                      color: AppColors.colorDarkGray),
                ),
                kSBH8,
                Row(
                  children: [
                    Text(
                      '12 чел.',
                      style: AppTextStyle.w500s14.copyWith(
                          height: 10.0.toFigmaHeight(14),
                          color: AppColors.colorDarkGray),
                    ),
                    kSBW10,
                    Text(
                      '750 000 тнг.',
                      style: AppTextStyle.w500s14.copyWith(
                          height: 10.0.toFigmaHeight(14),
                          color: AppColors.colorDarkGray),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kSBH25,
          ...List.generate(
              menuButtons.length,
              (index) => Material(
                    color: AppColors.colorTransparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: kPH20,
                        height: 60,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(menuButtons[index].$1),
                            kSBW10,
                            Text(
                              menuButtons[index].$2,
                              style: AppTextStyle.w500s18.copyWith(
                                  color: AppColors.colorBlack,
                                  height: 13.0.toFigmaHeight(18)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
          const Spacer(),
          Padding(
            padding: kPH20,
            child: Text(
              'Версия 4.11.7',
              style: AppTextStyle.w500s14.copyWith(
                  height: 10.0.toFigmaHeight(14), color: AppColors.colorGray),
            ),
          ),
          kSBH50
        ],
      )),
    );
  }
}
