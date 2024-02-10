import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key, this.routeState});
  final GoRouterState? routeState;

  @override
  State<InformationPage> createState() => _InformationPageState();
}

final globalKey = GlobalKey<ScaffoldState>();

class _InformationPageState extends State<InformationPage> {
  infoColumn(
      {required String todayResult,
      required String currentMonthResult,
      required String title}) {
    profit({bool isToday = true}) => RichText(
          text: TextSpan(
              text: '${isToday == true ? "Сегодня" : "Этот месяц"} - ',
              style: AppTextStyle.w500s14.copyWith(
                  color: AppColors.colorDarkGray, fontFamily: 'Gilroy'),
              children: [
                TextSpan(
                  text: isToday == true ? todayResult : currentMonthResult,
                  style: AppTextStyle.w500s18.copyWith(
                    color: AppColors.colorBlack,
                  ),
                )
              ]),
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      width: double.infinity,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.w500s14.copyWith(color: AppColors.colorBlack),
            ),
            kSBH12,
            profit(),
            profit(isToday: false)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(
        title: 'Информация',
        leading: (
          SvgPicture.asset(AppImages.menu),
          () => globalKey.currentState?.openDrawer(),
        ),
      ),
      drawer: DrawerMenu(routeState: widget.routeState),
      body: ListView(
        padding: kPH20,
        children: [
          infoColumn(
            currentMonthResult: '223',
            title: 'Кол-во взрослых жильцов:',
            todayResult: '8',
          ),
          kSBH16,
          infoColumn(
            title: 'Кол-во детей:',
            currentMonthResult: '66',
            todayResult: '4',
          ),
          kSBH16,
          infoColumn(
            title: 'Общее кол-во жильцов:',
            currentMonthResult: '289',
            todayResult: '12',
          ),
          kSBH16,
          infoColumn(
            title: 'Сумма:',
            todayResult: '50 000 тнг.',
            currentMonthResult: '750 000 тнг.',
          ),
        ],
      ),
    );
  }
}
