import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class ObjectsForBookingPage extends StatelessWidget {
  const ObjectsForBookingPage({super.key, this.routeState});
  final GoRouterState? routeState;
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.colorWhite,
      drawer: DrawerMenu(routeState: routeState),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: CustomAppBar(title: 'Сдаваемые объекты (20)', leading: (
          SvgPicture.asset(AppImages.menu),
          () => globalKey.currentState?.openDrawer(),
        )),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: kPV15,
                sliver: SliverList.separated(
                  itemCount: 20,
                  itemBuilder: (ctx, index) {
                    return SplashButton(
                      onTap: () {
                        context.pushNamed('booking_object');
                      },
                      child: SizedBox(
                        height: 97,
                        width: double.infinity,
                        child: Padding(
                          padding: kPH45V25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Комната 2',
                                style: AppTextStyle.w500s20.copyWith(
                                    color: AppColors.colorBlack,
                                    height: 24.0.toFigmaHeight(20),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              kSBH6,
                              Row(
                                children: [
                                  Text(
                                    'Тип:',
                                    style: AppTextStyle.w500s14.copyWith(
                                        color: AppColors.colorDarkGray,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  kSBW10,
                                  Text(
                                    'Квартира',
                                    style: AppTextStyle.w500s14.copyWith(
                                        color: AppColors.colorDarkGray),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) => kSBH16,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  backgroundColor: AppColors.colorBlue,
                  onPressed: () {},
                  child: SvgPicture.asset(AppImages.plus)),
            ),
          ),
        ],
      ),
    );
  }
}
