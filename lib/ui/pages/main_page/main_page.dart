import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/calendar/calendar.dart';
import 'package:qaz_booking_ui/calendar/src/calendar/appointment_engine/calendar_datasource.dart';
import 'package:qaz_booking_ui/calendar/src/calendar/settings/header_style.dart';
import 'package:qaz_booking_ui/calendar/src/calendar/sfcalendar.dart';
import 'package:qaz_booking_ui/calendar/src/calendar/custom_calendar.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class BookingDataSource extends CalendarDataSource {
  BookingDataSource(List<GuestModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].arrivalDate);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].departureDate);
  }

  @override
  String getSubject(int index) {
    return "${appointments![index].guestFullname} ${appointments![index].payment}";
  }

  @override
  Color getColor(int index) {
    return Color(int.tryParse(appointments![index].color)!);
  }

  @override
  bool isAllDay(int index) {
    return true;
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.routeState});
  final GoRouterState? routeState;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<GuestModel> _getDataSource() {
      final List<GuestModel> meetings = <GuestModel>[];
      final DateTime today = DateTime.now();
      final DateTime startTime =
          DateTime(today.year, today.month, today.day, 9, 0, 0);
      final DateTime endTime = startTime.add(const Duration(days: 2));
      meetings.addAll([
        GuestModel(
            guestFullname: 'Антон Н. Ч.',
            arrivalDate: startTime.toIso8601String(),
            departureDate: endTime.toIso8601String(),
            color: "0xFF9F22EB",
            payment: '77 400 ₸'),
        GuestModel(
            guestFullname: 'Антон Н. Ч.',
            arrivalDate: startTime.toIso8601String(),
            departureDate: endTime.toIso8601String(),
            color: "0xFF9F22EB",
            payment: '77 400 ₸'),
      ]);
      return meetings;
    }

    final globalKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      key: globalKey,
      drawer: DrawerMenu(routeState: widget.routeState),
      appBar: CustomAppBar(title: 'QazBooking', action: (
        SvgPicture.asset(AppImages.days),
        () {}
      ), leading: (
        SvgPicture.asset(AppImages.menu),
        () => globalKey.currentState?.openDrawer(),
      )),
      // body:
      // Row(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       height: 82,
      //       width: 89,
      //       clipBehavior: Clip.hardEdge,
      //       decoration: const BoxDecoration(
      //           border: Border(
      //               bottom: BorderSide(
      //                   color: AppColors.colorLightGray,
      //                   style: BorderStyle.solid,
      //                   strokeAlign: BorderSide.strokeAlignInside))),
      //       child: Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SvgPicture.asset(AppImages.calendar),
      //             kSBH6,
      //             Text(
      //               'Авг. 2023',
      //               style: AppTextStyle.w500s12
      //                   .copyWith(color: AppColors.colorDarkGray),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     // ],
      //     // ),
      //     Expanded(
      //       child:
      // SfCalendar(
      // monthViewSettings: MonthViewSettings(
      //     showAgenda: true,
      //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      // showDatePickerButton: true,
      // showTodayButton: true,
      // showNavigationArrow: true,
      // allowViewNavigation: true,

      // allowAppointmentResize: true,

      // headerHeight: 0,
      // viewHeaderStyle: ViewHeaderStyle(),
      // loadMoreWidgetBuilder: (context, loadMoreAppointments) =>
      //     Text('loadMoreWidgetBuilder'),
      // monthViewSettings: MonthViewSettings(showAgenda: true),
      // appointmentBuilder: (context, calendarAppointmentDetails) =>
      //     Text('appointmentBuilder'),
      // timeRegionBuilder: (context, timeRegionDetails) =>
      //     Text('timeRegionBuilder'),
      // resourceViewHeaderBuilder: (context, details) =>
      //     Text('resourceViewHeaderBuilder'),
      // monthCellBuilder: (context, details) => Text('monthCellBuilder'),
      // scheduleViewMonthHeaderBuilder: (context, details) =>
      //     Text('scheduleViewMonthHeaderBuilder'),
      // viewHeaderHeight: 82,
      // dataSource: BookingDataSource(_getDataSource()),
      // view: CalendarView.timelineDay,
      // ),
      //     ),
      //   ],
      // ),
      // CustomScrollView(
      //   slivers: [
      //     SliverToBoxAdapter(
      //         child: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Column(
      //           children: [
      //             Container(
      //               height: 82,
      //               width: 89,
      //               clipBehavior: Clip.hardEdge,
      //               decoration: const BoxDecoration(
      //                   border: Border(
      //                       bottom: BorderSide(
      //                           color: AppColors.colorLightGray,
      //                           style: BorderStyle.solid,
      //                           strokeAlign: BorderSide.strokeAlignInside))),
      //               child: Center(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     SvgPicture.asset(AppImages.calendar),
      //                     kSBH6,
      //                     Text(
      //                       'Авг. 2023',
      //                       style: AppTextStyle.w500s12
      //                           .copyWith(color: AppColors.colorDarkGray),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         Expanded(
      //             child: SizedBox(
      //           height: 82,
      //           child: ListView.separated(
      //               itemCount: 8,
      //               scrollDirection: Axis.horizontal,
      //               shrinkWrap: true,
      //               separatorBuilder: (context, index) => kSBW6,
      //               padding: const EdgeInsets.symmetric(vertical: 18),
      //               itemBuilder: (context, index) => Container(
      //                     height: 46,
      //                     width: 46,
      //                     decoration: BoxDecoration(
      //                         color: index == 1
      //                             ? AppColors.colorBlue
      //                             : AppColors.colorLightGray,
      //                         borderRadius: BorderRadius.circular(12)),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Text(
      //                           'ПТ',
      //                           style: AppTextStyle.w600s9.copyWith(
      //                             color: index == 1
      //                                 ? AppColors.colorWhite
      //                                 : AppColors.colorDarkGray,
      //                             height: 6.0.toFigmaHeight(9),
      //                           ),
      //                         ),
      //                         const SizedBox(height: 3),
      //                         Text(
      //                           '19',
      //                           style: AppTextStyle.w500s12.copyWith(
      //                             color: index == 1
      //                                 ? AppColors.colorWhite
      //                                 : AppColors.colorDarkGray,
      //                             height: 8.0.toFigmaHeight(12),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   )),
      //         )),
      //       ],
      //     )),
      //     SliverToBoxAdapter(
      //       child: ListView(
      //         shrinkWrap: true,
      //         children:

      //             // delegate: SliverChildListDelegate(
      //             [
      //           ...List.generate(
      //             10,
      //             (index) => Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Container(
      //                   height: 82,
      //                   width: 89,
      //                   clipBehavior: Clip.hardEdge,
      //                   decoration: const BoxDecoration(
      //                       border: Border(
      //                           bottom: BorderSide(
      //                               color: AppColors.colorLightGray,
      //                               style: BorderStyle.solid,
      //                               strokeAlign:
      //                                   BorderSide.strokeAlignInside))),
      //                   child: Center(
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         SvgPicture.asset(
      //                           AppImages.car,
      //                           color: AppColors.colorDarkGray,
      //                         ),
      //                         kSBH6,
      //                         Text(
      //                           'Авг. 2023',
      //                           style: AppTextStyle.w500s12
      //                               .copyWith(color: AppColors.colorDarkGray),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                     child: SizedBox(
      //                   height: 82,
      //                   child: ListView.separated(
      //                       itemCount: 8,
      //                       scrollDirection: Axis.horizontal,
      //                       shrinkWrap: true,
      //                       separatorBuilder: (context, index) => kSBW6,
      //                       padding: const EdgeInsets.symmetric(vertical: 18),
      //                       itemBuilder: (context, index) => Container(
      //                             height: 46,
      //                             width: 46,
      //                             decoration: BoxDecoration(
      //                                 color: index == 1
      //                                     ? AppColors.colorBlue
      //                                     : AppColors.colorLightGray,
      //                                 borderRadius: BorderRadius.circular(12)),
      //                             child: Column(
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               children: [
      //                                 Text(
      //                                   'ПТ',
      //                                   style: AppTextStyle.w600s9.copyWith(
      //                                     color: index == 1
      //                                         ? AppColors.colorWhite
      //                                         : AppColors.colorDarkGray,
      //                                     height: 6.0.toFigmaHeight(9),
      //                                   ),
      //                                 ),
      //                                 const SizedBox(height: 3),
      //                                 Text(
      //                                   '19',
      //                                   style: AppTextStyle.w500s12.copyWith(
      //                                     color: index == 1
      //                                         ? AppColors.colorWhite
      //                                         : AppColors.colorDarkGray,
      //                                     height: 8.0.toFigmaHeight(12),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           )),
      //                 )),
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),

      //   ],
      // ),
    );
  }
}
