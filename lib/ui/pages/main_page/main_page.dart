import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/calendar_view_widget.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/common/enums.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.routeState});
  final GoRouterState? routeState;
  @override
  State<MainPage> createState() => _MainPageState();
}

final timeline = ValueNotifier(CalendarViewEnum.hour);

class _MainPageState extends State<MainPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        key: globalKey,
        drawer: DrawerMenu(routeState: widget.routeState),
        appBar: CustomAppBar(title: 'QazBooking', action: (
          ValueListenableBuilder(
            valueListenable: timeline,
            builder: (context, value, child) {
              if (timeline.value == CalendarViewEnum.day) {
                return SvgPicture.asset(AppImages.days);
              } else {
                return SvgPicture.asset(AppImages.hours);
              }
            },
          ),
          () {
            if (timeline.value == CalendarViewEnum.day) {
              timeline.value = CalendarViewEnum.hour;
            } else {
              timeline.value = CalendarViewEnum.day;
            }
          }
        ), leading: (
          SvgPicture.asset(AppImages.menu),
          () => globalKey.currentState?.openDrawer(),
        )),
        body: CalendarViewWidget(
          calendarViewEnum: timeline,
        ));
  }
}
