import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/appointment_view.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/calendar_view_widget.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/date_view.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/lib/calendar.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

// class BookingDataSource extends CalendarDataSource {
//   late final List<GuestModel> _appointments;
//   BookingDataSource(List<GuestModel> source) {
//     _appointments = source;
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return DateTime.parse(_appointments![index].arrivalDate!);
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return DateTime.parse(_appointments![index].departureDate!);
//   }

//   @override
//   String getSubject(int index) {
//     return "${_appointments![index].guestFullname} ${_appointments![index].payment}";
//   }

//   @override
//   Color getColor(int index) {
//     return _appointments[index].color!;
//   }

//   @override
//   bool isAllDay(int index) {
//     return false;
//   }
// }

// List<GuestModel> getDataSource() {
//   final List<GuestModel> meetings = <GuestModel>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(days: 2));
//   meetings.addAll([
//     GuestModel(
//         guestFullname: 'Антон Н. Ч.',
//         arrivalDate:
//             startTime.add(const Duration(days: 1, hours: 3)).toIso8601String(),
//         departureDate: endTime.toIso8601String(),
//         color: AppColors.colorOrange,
//         payment: '77 400 ₸'),
//     GuestModel(
//         guestFullname: 'Антон Н. Ч.',
//         arrivalDate: startTime.toIso8601String(),
//         departureDate: endTime.toIso8601String(),
//         color: AppColors.colorBlue,
//         payment: '77 400 ₸'),
//     GuestModel(
//         guestFullname: 'Антон Н. Ч.',
//         arrivalDate:
//             startTime.add(const Duration(days: 3, hours: 3)).toIso8601String(),
//         departureDate:
//             endTime.add(const Duration(days: 1, hours: 3)).toIso8601String(),
//         color: AppColors.colorBlue,
//         payment: '77 400 ₸'),
//   ]);
//   return meetings;
// }

// Color getAppointmentPaymentColor(Color color) => switch (color) {
//       AppColors.colorBlue => AppColors.colorSecondaryBlue,
//       AppColors.colorOrange => AppColors.colorSecondaryOrange,
//       AppColors.colorViolet => AppColors.colorSecondaryViolet,
//       _ => AppColors.colorSecondaryGreen
//     };

/// Widget class of shift scheduler calendar
// class MeetingRoomCalendar extends StatefulWidget {
//   /// Creates calendar of shift scheduler
//   const MeetingRoomCalendar({Key? key}) : super(key: key);

//   @override
//   _MeetingRoomCalendarState createState() => _MeetingRoomCalendarState();
// }

// class _MeetingRoomCalendarState extends State<MeetingRoomCalendar> {
//   // final List<String> _subjectCollection = <String>[];
//   // final List<Color> _colorCollection = <Color>[];
//   final List<Appointment> _meetingCollection = <Appointment>[];
//   final List<CalendarResource> _meetingRoomCollection = <CalendarResource>[];
//   final List<TimeRegion> _specialTimeRegions = <TimeRegion>[];
//   // final List<String> _nameCollection = <String>[];
//   // final List<String> _colorNames = <String>[];
//   // final List<String> icons = <String>[];
//   final List<ObjectToBook> _objectsToBook = <ObjectToBook>[
//     ObjectToBook(
//       object: 'Гостиница',
//       objectName: "Номер 1",
//       roomsCount: 2,
//     ),
//     ObjectToBook(
//       object: 'Хостел',
//       objectName: "Номер 12",
//       roomsCount: 4,
//     ),
//     ObjectToBook(
//       object: 'Гостиница',
//       objectName: "Номер 33",
//       roomsCount: 1,
//     ),
//     ObjectToBook(
//       object: 'Гостиница',
//       objectName: "Номер 33",
//       roomsCount: 1,
//     ),
//     ObjectToBook(
//       object: 'Гостиница',
//       objectName: "Номер 33",
//       roomsCount: 1,
//     ),
//     ObjectToBook(
//       object: 'Гостиница',
//       objectName: "Номер 1",
//       roomsCount: 2,
//     ),
//     ObjectToBook(
//       object: 'Хостел',
//       objectName: "Номер 12",
//       roomsCount: 4,
//     ),
//     // ObjectToBook(
//     //   object: 'Гостиница',
//     //   objectName: "Номер 33",
//     //   roomsCount: 1,
//     // ),
//     // ObjectToBook(
//     //   object: 'Гостиница',
//     //   objectName: "Номер 33",
//     //   roomsCount: 1,
//     // ),
//     // ObjectToBook(
//     //   object: 'Гостиница',
//     //   objectName: "Номер 33",
//     //   roomsCount: 1,
//     // ),
//   ];

//   final CalendarController _calendarController = CalendarController();

//   final List<CalendarView> _allowedViews = <CalendarView>[
//     CalendarView.timelineMonth,
//     CalendarView.timelineDay,
//     // CalendarView.timelineWeek,
//     // CalendarView.timelineWorkWeek,
//   ];

//   late _MeetingDataSource _events;
//   late DateTime _minDate;
//   DateTime? _visibleStartDate, _visibleEndDate;
//   List<Appointment> _visibleAppointments = <Appointment>[];

//   @override
//   void initState() {
//     _minDate = DateTime.now();
//     _calendarController.view = CalendarView.timelineMonth;

// icons.add(AppImages.bed);
// icons.add(AppImages.doubleBed);
// icons.add(AppImages.bed);
// icons.add(const Icon(
//   Icons.people_outline,
//   color: Colors.white,
// ));
// icons.add(const Icon(
//   Icons.people_alt_rounded,
//   color: Colors.white,
// ));

// _addAppointmentDetails();
// _addResourceDetails();
//   _addResources();
//   _addSpecialRegions();

//   _addAppointments();
//   _events = _MeetingDataSource(_meetingCollection, _meetingRoomCollection);
//   super.initState();
// }

// void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
//   if (_visibleStartDate != null && _visibleEndDate != null) {
//     SchedulerBinding.instance!.addPostFrameCallback((_) {
//       setState(() {});
//     });
//   }
//   _visibleStartDate = visibleDatesChangedDetails.visibleDates[0];
//   _visibleEndDate = visibleDatesChangedDetails
//       .visibleDates[visibleDatesChangedDetails.visibleDates.length - 1];
//   _visibleAppointments = _events.getVisibleAppointments(
//       _visibleStartDate!, '', _visibleEndDate!);
// }

// @override
// Widget build(BuildContext context) {
//   return SafeArea(
//     child: Container(
//       child: _getMeetingRoomCalendar(_events, _onViewChanged),
//     ),
//   );
// }

/// Creates the required resource details as list
// void _addResourceDetails() {
// _nameCollection.add('Jammy');
// _nameCollection.add('Tweety');
// _nameCollection.add('Nestle');
// _nameCollection.add('Phoenix');
// _nameCollection.add('Mission');
// _nameCollection.add('Emilia');
// _nameCollection.add('Phoenix');
// _nameCollection.add('Mission');
// _nameCollection.add('Emilia');
// }

//   void _addResources() {
//     // final Random random = Random();
//     for (int i = 0; i < _objectsToBook.length; i++) {
//       _meetingRoomCollection.add(CalendarResource(
//           displayName: _objectsToBook[i].objectName!,
//           id: '000' + i.toString(),
//           color: AppColors.colorWhite,
//           object: _objectsToBook[i].object,
//           personsCount: '${_objectsToBook[i].roomsCount} персоны'));
//     }
//   }

//   /// Method that creates the collection the time region for calendar, with
//   /// required information.
//   void _addSpecialRegions() {
//     final DateTime date = DateTime.now();
//     final Random random = Random();
//     for (int i = 0; i < _meetingRoomCollection.length; i++) {
//       _specialTimeRegions.add(TimeRegion(
//           startTime: DateTime(date.year, date.month, date.day, 13, 0, 0),
//           endTime: DateTime(date.year, date.month, date.day, 14, 0, 0),
//           text: 'Lunch',
//           color: Colors.grey.withOpacity(0.2),
//           resourceIds: <Object>[_meetingRoomCollection[i].id],
//           recurrenceRule: 'FREQ=DAILY;INTERVAL=1'));

//       if (i.isEven) {
//         continue;
//       }

//       final DateTime startDate = DateTime(
//         date.year,
//         date.month,
//         date.day,
//       );

//       _specialTimeRegions.add(TimeRegion(
//         startTime: startDate,
//         endTime: startDate.add(const Duration(hours: 1)),
//         text: 'Not Available',
//         color: Colors.grey.withOpacity(0.2),
//         enablePointerInteraction: false,
//         resourceIds: <Object>[_meetingRoomCollection[i].id],
//       ));
//     }
//   }

//   /// Method that creates the collection the data source for calendar, with
//   /// required information.
//   void _addAppointments() {
//     // final Random random = Random();
//     for (int i = 0; i < _meetingRoomCollection.length; i++) {
//       final List<Object> _roomId = <Object>[_meetingRoomCollection[i].id];
//       if (i == _meetingRoomCollection.length - 1 || i.isEven) {
//         // int index = random.nextInt(i);
//         // index = index == i ? index + 1 : index;
//         final Object roomId = _meetingRoomCollection[i].id;
//         if (roomId is String) {
//           _roomId.add(roomId);
//         }
//       }

//       // for (int k = 0; k < 365; k++) {
//       // if (_roomId.length > 1 && k.isEven) {
//       //   continue;
//       // }
//       // for (int j = 0; j < 10; j++) {
//       final DateTime date = DateTime.now().add(Duration(days: 1 + 5));
//       int startHour = 9 + (6);
//       startHour =
//           startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
//       final DateTime _startTime =
//           DateTime(date.year, date.month, date.day, startHour, 0, 0);
//       if (_startTime.isBefore(_minDate)) {
//         continue;
//       }

//       _meetingCollection.add(Appointment(
//         startTime: _startTime,
//         resourceIds: _roomId,
//         endTime: _startTime.add(const Duration(days: 1)),
//         color: AppColors.colorBlue,
//         payment: '6 300 ₸',
//         guestFullname: 'Эдуард Б. М. ',
//       )
//           // GuestModel(
//           //   arrivalDate: _startTime.toIso8601String(),
//           //   departureDate:
//           //       _startTime.add(const Duration(hours: 1)).toIso8601String(),
//           //   payment: '6 300 ₸',
//           //   guestFullname: 'Эдуард Б. М. ',
//           //   color: _meetingRoomCollection[i].color,
//           //   resourceIds: _roomId)
//           );
//       // }
//       // }
//     }
//   }

//   /// Returns the widget for special time regions in the calendar.
//   Widget _getSpecialRegionWidget(
//       BuildContext context, TimeRegionDetails details) {
//     if (details.region.text == 'Lunch') {
//       return Container(
//         color: details.region.color,
//         alignment: Alignment.center,
//         child: Icon(
//           Icons.restaurant_menu,
//           color: Colors.grey.withOpacity(0.5),
//         ),
//       );
//     } else if (details.region.text == 'Not Available') {
//       return Container(
//         color: details.region.color,
//         alignment: Alignment.center,
//         child: Icon(
//           Icons.block,
//           color: Colors.grey.withOpacity(0.5),
//         ),
//       );
//     }

//     return Container(
//       color: details.region.color,
//       height: 30,
//       width: 30,
//     );
//   }

//   /// Returns the calendar widget based on the properties passed
//   SfCalendar _getMeetingRoomCalendar(
//       [CalendarDataSource? _calendarDataSource, dynamic viewChangedCallback]) {
//     return SfCalendar(
//       firstDayOfWeek: 6,
//       backgroundColor: AppColors.colorWhite,
//       // appointmentBuilder: (context, calendarAppointmentDetails) =>
//       //     AppointmentViewWidget(
//       //         calendarAppointmentDetails: calendarAppointmentDetails),
//       // allowAppointmentResize: true,
//       allowViewNavigation: true,

//       headerHeight: 0,
//       viewHeaderHeight: 82,
//       // showDatePickerButton: true,
//       controller: _calendarController,
//       // allowDragAndDrop: true,
//       allowedViews: _allowedViews,
//       minDate: _minDate,
//       timeRegionBuilder: _getSpecialRegionWidget,
//       specialRegions: _specialTimeRegions,

//       // showNavigationArrow: true,
//       dataSource: _calendarDataSource,
//       onViewChanged: viewChangedCallback,
//       resourceViewSettings:
//           const ResourceViewSettings(size: 89, visibleResourceCount: -1),
//       resourceViewHeaderBuilder: _resourceHeaderBuilder,
//     );
//   }

//   /// Returns the widget for resource header.
//   Widget _resourceHeaderBuilder(
//       BuildContext context, ResourceViewHeaderDetails details) {
//     // final Random random = Random();

//     // int capacity = 0;
//     if (_visibleAppointments.isNotEmpty) {
//       // capacity = 0;
//       for (int i = 0; i < _visibleAppointments.length; i++) {
//         final Appointment visibleApp = _visibleAppointments[i];
//         if (visibleApp.resourceIds != null &&
//             visibleApp.resourceIds!.isNotEmpty &&
//             visibleApp.resourceIds!.contains(details.resource.id)) {
//           // capacity++;
//         }
//       }
//     }

//     // String capacityString = 'Events';
//     // if (capacity >= 5) {
//     // capacityString = 'Conference';
//     // }
//     final resourceStyle = AppTextStyle.w500s10.copyWith(
//         height: 12.0.toFigmaHeight(10), color: AppColors.colorDarkGray);

//     return Container(
//       constraints: const BoxConstraints(minHeight: 92),
//       decoration: BoxDecoration(
//           color: details.resource.color,
//           border: const Border(
//               bottom: BorderSide(
//                   color: AppColors.colorLightGray,
//                   width: 1,
//                   strokeAlign: BorderSide.strokeAlignInside))),
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SvgPicture.asset(
//             AppImages.bed,
//             colorFilter: const ColorFilter.mode(
//                 AppColors.colorDarkGray, BlendMode.srcIn),
//           ),
//           kSBH4,
//           Text(details.resource.displayName, style: resourceStyle),
//           kSBH2,
//           Text(details.resource.object!, style: resourceStyle),
//           kSBH2,
//           Text(details.resource.personsCount!, style: resourceStyle),
//         ],
//       ),
//     );
//   }
// }

// /// An object to set the appointment collection data source to collection, which
// /// used to map the custom appointment data to the calendar appointment, and
// /// allows to add, remove or reset the appointment collection.
// class _MeetingDataSource extends CalendarDataSource {
//   _MeetingDataSource(
//       List<Appointment> source, List<CalendarResource> resourceColl) {
//     appointments = source;
//     resources = resourceColl;
//   }
// }

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.routeState});
  final GoRouterState? routeState;
  @override
  State<MainPage> createState() => _MainPageState();
}

final timeline = ValueNotifier(CalendarViewEnum.hour);

class _MainPageState extends State<MainPage> {
  final calendarController = CalendarController();
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();
    // return Scaffold(body: MeetingRoomCalendar());
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
              // calendarController.view = CalendarViewEnum.timelineDay;
            } else {
              timeline.value = CalendarViewEnum.day;
              // calendarController.view = CalendarViewEnum.timelineMonth;
            }
          }
        ), leading: (
          SvgPicture.asset(AppImages.menu),
          () => globalKey.currentState?.openDrawer(),
        )),
        body:
            //  MeetingRoomCalendar(),
            CalendarViewWidget(
          calendarViewEnum: timeline,
        ));
    // Row(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Container(
    //       //   height: 82,
    //       //   width: 89,
    //       //   clipBehavior: Clip.hardEdge,
    //       //   decoration: const BoxDecoration(
    //       //       border: Border(
    //       //           bottom: BorderSide(
    //       //               color: AppColors.colorLightGray,
    //       //               style: BorderStyle.solid,
    //       //               strokeAlign: BorderSide.strokeAlignInside))),
    //       //   child: Center(
    //       //     child: Column(
    //       //       mainAxisAlignment: MainAxisAlignment.center,
    //       //       crossAxisAlignment: CrossAxisAlignment.start,
    //       //       children: [
    //       //         SvgPicture.asset(AppImages.calendar),
    //       //         kSBH6,
    //       //         Text(
    //       //           'Авг. 2023',
    //       //           style: AppTextStyle.w500s12
    //       //               .copyWith(color: AppColors.colorDarkGray),
    //       //         )
    //       //       ],
    //       //     ),
    //       //   ),
    //       // ),
    //       //   ],
    //       // ),
    //       Expanded(
    //         child: SfCalendar(
    //             // key: _widgetKey,
    //             // initialDisplayDate: DateTime.now(),
    //             // initialSelectedDate: DateTime.now(),

    //             // monthViewSettings: MonthViewSettings(
    //             //     showAgenda: true,
    //             //     appointmentDisplayMode:
    //             //         MonthAppointmentDisplayMode.appointment),
    //             // showDatePickerButton: true,
    //             // showTodayButton: true,
    //             // showNavigationArrow: true,
    //             // allowViewNavigation: true,
    //             // allowAppointmentResize: true,
    //             re
    //             resourceViewHeaderBuilder:(context, details) => ,
    //             monthViewSettings: MonthViewSettings(
    //                 appointmentDisplayMode:
    //                     MonthAppointmentDisplayMode.appointment),
    //             headerHeight: 0,
    //             timeRegionBuilder: (context, timeRegionDetails) =>
    //                 ResourceViewHeader(
    //                     weekDay: 'ПТ',
    //                     bgColor: AppColors.colorLightGray,
    //                     day: timeRegionDetails.date.day.toString(),
    //                     textColor: AppColors.colorDarkGray),
    //             // viewHeaderStyle: ViewHeaderStyle(),
    //             scheduleViewMonthHeaderBuilder: (context, details) =>
    //                 ResourceViewHeader(
    //                     weekDay: 'ПТ',
    //                     bgColor: AppColors.colorLightGray,
    //                     day: details.date.day.toString(),
    //                     textColor: AppColors.colorDarkGray),
    //             // loadMoreWidgetBuilder: (context, loadMoreAppointments) =>
    //             //     Text('loadMoreWidgetBuilder'),
    //             // // monthViewSettings: MonthViewSettings(showAgenda: true),
    //             // appointmentBuilder: (context, calendarAppointmentDetails) =>
    //             //     Text('appointmentBuilder'),
    //             // timeRegionBuilder: (context, timeRegionDetails) =>
    //             //     Text('timeRegionBuilder'),
    //             // resourceViewHeaderBuilder: (context, details) =>
    //             //     Text('resourceViewHeaderBuilder'),
    //             // monthCellBuilder: (context, details) => Text('monthCellBuilder'),
    //             // scheduleViewMonthHeaderBuilder: (context, details) =>
    //             //     Text('scheduleViewMonthHeaderBuilder'),
    //             viewHeaderHeight: 82,
    //             dataSource: BookingDataSource(getDataSource()),
    //             view: timeline.value,
    //             monthCellBuilder: (context, details) => ResourceViewHeader(
    //                 weekDay: 'ПТ',
    //                 bgColor: AppColors.colorLightGray,
    //                 day: details.visibleDates[0].day.toString(),
    //                 textColor: AppColors.colorDarkGray),
    //             // resourceViewHeaderBuilder: (context, details) =>
    //             // ResourceViewHeader(
    //             //     weekDay: 'ПТ',
    //             //     bgColor: AppColors.colorLightGray,
    //             //     day: details.resource.displayName,
    //             //     textColor: AppColors.colorDarkGray),

    //             ///TODO: Получилось отобразить запись гостя,
    //             ///теперь надо переписать виджет, думаю совмещение
    //             ///CalendarView.week и CalendarView.timelineMonth надо сделать
    //             ///
    //             // allowDragAndDrop: true,
    //             // allowAppointmentResize: true,
    //             // app
    //             // headerStyle:
    //             // CalendarHeaderStyle(backgroundColor: AppColors.color344B53),
    //             // style
    //             controller: calendarController,
    //             appointmentBuilder: (context, calendarAppointmentDetails) {
    // final appointment =
    //     calendarAppointmentDetails.appointments.first
    //     // as GuestModel;
    //     ;
    // return Container(
    //     height: 46,
    //     padding: const EdgeInsets.symmetric(
    //         horizontal: 15, vertical: 8),
    //     decoration: BoxDecoration(
    //         color: appointment.color,
    //         borderRadius: BorderRadius.circular(12)),
    //     child: Flexible(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(appointment.guestFullname!,
    //               style: AppTextStyle.w500s12.copyWith(
    //                 color: AppColors.colorWhite,
    //                 height: 15.0.toFigmaHeight(12),
    //               )),
    //           Text(appointment.payment!,
    //               style: AppTextStyle.w500s12.copyWith(
    //                   height: 15.0.toFigmaHeight(12),
    //                   color: getAppointmentPaymentColor(
    //                       appointment.color!))),
    //         ],
    //       ),
    //                   ));
    //             }),
    //       ),
    //     ],
    //   ),
    //   // CustomScrollView(
    //   //   slivers: [
    //   //     SliverToBoxAdapter(
    //   //         child: Row(
    //   //       mainAxisSize: MainAxisSize.min,
    //   //       children: [
    //   //         Column(
    //   //           children: [
    //   //             Container(
    //   //               height: 82,
    //   //               width: 89,
    //   //               clipBehavior: Clip.hardEdge,
    //   //               decoration: const BoxDecoration(
    //   //                   border: Border(
    //   //                       bottom: BorderSide(
    //   //                           color: AppColors.colorLightGray,
    //   //                           style: BorderStyle.solid,
    //   //                           strokeAlign: BorderSide.strokeAlignInside))),
    //   //               child: Center(
    //   //                 child: Column(
    //   //                   mainAxisAlignment: MainAxisAlignment.center,
    //   //                   crossAxisAlignment: CrossAxisAlignment.start,
    //   //                   children: [
    //   //                     SvgPicture.asset(AppImages.calendar),
    //   //                     kSBH6,
    //   //                     Text(
    //   //                       'Авг. 2023',
    //   //                       style: AppTextStyle.w500s12
    //   //                           .copyWith(color: AppColors.colorDarkGray),
    //   //                     )
    //   //                   ],
    //   //                 ),
    //   //               ),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //         Expanded(
    //   //             child: SizedBox(
    //   //           height: 82,
    //   //           child: ListView.separated(
    //   //               itemCount: 8,
    //   //               scrollDirection: Axis.horizontal,
    //   //               shrinkWrap: true,
    //   //               separatorBuilder: (context, index) => kSBW6,
    //   //               padding: const EdgeInsets.symmetric(vertical: 18),
    //   //               itemBuilder: (context, index) => Container(
    //   //                     height: 46,
    //   //                     width: 46,
    //   //                     decoration: BoxDecoration(
    //   //                         color: index == 1
    //   //                             ? AppColors.colorBlue
    //   //                             : AppColors.colorLightGray,
    //   //                         borderRadius: BorderRadius.circular(12)),
    //   //                     child: Column(
    //   //                       mainAxisAlignment: MainAxisAlignment.center,
    //   //                       children: [
    //   //                         Text(
    //   //                           'ПТ',
    //   //                           style: AppTextStyle.w600s9.copyWith(
    //   //                             color: index == 1
    //   //                                 ? AppColors.colorWhite
    //   //                                 : AppColors.colorDarkGray,
    //   //                             height: 6.0.toFigmaHeight(9),
    //   //                           ),
    //   //                         ),
    //   //                         const SizedBox(height: 3),
    //   //                         Text(
    //   //                           '19',
    //   //                           style: AppTextStyle.w500s12.copyWith(
    //   //                             color: index == 1
    //   //                                 ? AppColors.colorWhite
    //   //                                 : AppColors.colorDarkGray,
    //   //                             height: 8.0.toFigmaHeight(12),
    //   //                           ),
    //   //                         ),
    //   //                       ],
    //   //                     ),
    //   //                   )),
    //   //         )),
    //   //       ],
    //   //     )),
    //   //     SliverToBoxAdapter(
    //   //       child: ListView(
    //   //         shrinkWrap: true,
    //   //         children:

    //   //             // delegate: SliverChildListDelegate(
    //   //             [
    //   //           ...List.generate(
    //   //             10,
    //   //             (index) => Row(
    //   //               mainAxisSize: MainAxisSize.min,
    //   //               children: [
    //   //                 Container(
    //   //                   height: 82,
    //   //                   width: 89,
    //   //                   clipBehavior: Clip.hardEdge,
    //   //                   decoration: const BoxDecoration(
    //   //                       border: Border(
    //   //                           bottom: BorderSide(
    //   //                               color: AppColors.colorLightGray,
    //   //                               style: BorderStyle.solid,
    //   //                               strokeAlign:
    //   //                                   BorderSide.strokeAlignInside))),
    //   //                   child: Center(
    //   //                     child: Column(
    //   //                       mainAxisAlignment: MainAxisAlignment.center,
    //   //                       crossAxisAlignment: CrossAxisAlignment.start,
    //   //                       children: [
    //   //                         SvgPicture.asset(
    //   //                           AppImages.car,
    //   //                           color: AppColors.colorDarkGray,
    //   //                         ),
    //   //                         kSBH6,
    //   //                         Text(
    //   //                           'Авг. 2023',
    //   //                           style: AppTextStyle.w500s12
    //   //                               .copyWith(color: AppColors.colorDarkGray),
    //   //                         )
    //   //                       ],
    //   //                     ),
    //   //                   ),
    //   //                 ),
    //   //                 Expanded(
    //   //                     child: SizedBox(
    //   //                   height: 82,
    //   //                   child: ListView.separated(
    //   //                       itemCount: 8,
    //   //                       scrollDirection: Axis.horizontal,
    //   //                       shrinkWrap: true,
    //   //                       separatorBuilder: (context, index) => kSBW6,
    //   //                       padding: const EdgeInsets.symmetric(vertical: 18),
    //   //                       itemBuilder: (context, index) => Container(
    //   //                             height: 46,
    //   //                             width: 46,
    //   //                             decoration: BoxDecoration(
    //   //                                 color: index == 1
    //   //                                     ? AppColors.colorBlue
    //   //                                     : AppColors.colorLightGray,
    //   //                                 borderRadius: BorderRadius.circular(12)),
    //   //                             child: Column(
    //   //                               mainAxisAlignment: MainAxisAlignment.center,
    //   //                               children: [
    //   //                                 Text(
    //   //                                   'ПТ',
    //   //                                   style: AppTextStyle.w600s9.copyWith(
    //   //                                     color: index == 1
    //   //                                         ? AppColors.colorWhite
    //   //                                         : AppColors.colorDarkGray,
    //   //                                     height: 6.0.toFigmaHeight(9),
    //   //                                   ),
    //   //                                 ),
    //   //                                 const SizedBox(height: 3),
    //   //                                 Text(
    //   //                                   '19',
    //   //                                   style: AppTextStyle.w500s12.copyWith(
    //   //                                     color: index == 1
    //   //                                         ? AppColors.colorWhite
    //   //                                         : AppColors.colorDarkGray,
    //   //                                     height: 8.0.toFigmaHeight(12),
    //   //                                   ),
    //   //                                 ),
    //   //                               ],
    //   //                             ),
    //   //                           )),
    //   //                 )),
    //   //               ],
    //   //             ),
    //   //           )
    //   //         ],
    //   //       ),
    //   //     ),

    //   //   ],
    //   // ),
    // );
  }
}
