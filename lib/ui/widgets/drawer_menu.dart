import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, this.routeState});
  final GoRouterState? routeState;
  @override
  Widget build(BuildContext context) {
    void goToPage(String pageName) {
      if (routeState?.path == '/$pageName') {
        context.pop();
      } else {
        context.go('/$pageName');
      }
    }

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
                      textAlign: TextAlign.center,
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
          Flexible(
            child: ListView.custom(
              childrenDelegate: SliverChildBuilderDelegate(
                  childCount: menuButtons.length,
                  (context, index) => SplashButton(
                        onTap: () => switch (index) {
                          0 => {
                              goToPage('main')

                              ///
                              ///TODO: Сделать правильную анимацию перехода в профиль через Drawer меню
                            },
                          1 => {goToPage('objects_for_booking')},
                          2 => {goToPage('objects_for_rent')},
                          3 => {goToPage('objects_for_rent')},
                          4 => {goToPage('objects_for_rent')},
                          _ => null,
                        },
                        child: Container(
                          padding: kPH20,
                          height: 60,
                          child: Row(
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
                      )),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: kPH20V12.copyWith(bottom: 0),
              child: Text(
                'Версия 4.11.7',
                style: AppTextStyle.w500s14.copyWith(
                    height: 10.0.toFigmaHeight(14), color: AppColors.colorGray),
              ),
            ),
          ),
          kSBH50
        ],
      )),
    );
  }
}
