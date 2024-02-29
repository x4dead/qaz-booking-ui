import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/data/data.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key, this.routeState});
  final GoRouterState? routeState;

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

final globalKey = GlobalKey<ScaffoldState>();

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    final priceStyle = AppTextStyle.w500s14.copyWith(
        fontFamily: 'Gilroy',
        color: AppColors.colorBlue,
        overflow: TextOverflow.ellipsis);
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(
        title: 'Архив',
        leading: (
          SvgPicture.asset(AppImages.menu),
          () => globalKey.currentState?.openDrawer(),
        ),
      ),
      drawer: DrawerMenu(routeState: widget.routeState),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: kPV15,
            sliver: SliverList.separated(
              itemCount: listBookedGuests.length,
              itemBuilder: (ctx, index) {
                return SplashButton(
                  onTap: () {
                    context.pushNamed('guest_info',
                        extra: {"info": listBookedGuests[index].toMap()});
                  },
                  child: SizedBox(
                    height: 98,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 155,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listBookedGuests[index].guestFullname ?? '',
                                  style: AppTextStyle.w500s20.copyWith(
                                      color: AppColors.colorBlack,
                                      height: 24.0.toFigmaHeight(20),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                kSBH16,
                                Text(
                                  'Анатолий',
                                  style: priceStyle.copyWith(
                                      color: AppColors.colorDarkGray),
                                ),
                                SizedBox(
                                  width: 113,
                                  child: Text(
                                    'sdfsdgdaa@gmail.com',
                                    style: priceStyle.copyWith(
                                        color: AppColors.colorDarkGray),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '> 02 дек. (13:00)',
                                  style: priceStyle.copyWith(
                                      color: AppColors.colorDarkGray),
                                ),
                                Text(
                                  '< 03 дек. (12:00)',
                                  style: AppTextStyle.w500s14
                                      .copyWith(color: AppColors.colorDarkGray),
                                ),
                                RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        style: priceStyle,
                                        text: '13 050',
                                        children: [
                                          TextSpan(
                                              text: '₸',
                                              style: priceStyle.copyWith(
                                                  fontFamily: 'Inter')),
                                          TextSpan(
                                              text: '/13 050',
                                              style: priceStyle),
                                          TextSpan(
                                              text: '₸',
                                              style: priceStyle.copyWith(
                                                  fontFamily: 'Inter'))
                                        ]))
                              ],
                            ),
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
    );
  }
}
