import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/appointment_view.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/data/data.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/date_view.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/resource_view.dart';
import 'package:qaz_booking_ui/ui/widgets/lib/src/calendar/common/date_time_engine.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

// class _DragPaintDetails {
//   _DragPaintDetails(
//       // ignore: unused_element
//       {this.appointmentView,
//       required this.position,
//       // ignore: unused_element
//       this.draggingTime,
//       // ignore: unused_element
//       this.timeIntervalHeight});

//   AppointmentView? appointmentView;
//   final ValueNotifier<Offset?> position;
//   DateTime? draggingTime;
//   double? timeIntervalHeight;
// }
///
///TODO: Вынести часто используемые числовые значения в ui constants
///
class CalendarViewWidget extends StatefulWidget {
  const CalendarViewWidget({super.key});

  @override
  State<CalendarViewWidget> createState() => _CalendarViewWidgetState();
}

class _CalendarViewWidgetState extends State<CalendarViewWidget> {
  //_resourcesVertController Контроллер для скролла карточек объектов для бронирования по ВЕРТИКАЛИ
  late final ScrollController _resourcesVertController = ScrollController(),
      //appointmentsVertController Контроллер для скролла карточек записи гостей по ВЕРТИКАЛИ
      appointmentsVertController = ScrollController(),
      //appointmentsHorController Контроллер для скролла карточек записи гостей по ГОРИЗОНТАЛИ
      appointmentsHorController;

  ///Контроллер синхронного скролла
  SyncScrollController? _syncScroller = SyncScrollController([]);
  // ScrollController? _scrollController;
  // ScrollController? _timelineViewHeaderScrollController,
  // _timelineViewVerticalScrollController,
  // _timelineRulerController,
  // _resourcePanelScrollController;
  // Drag? _drag;
  // late double _scrollStartPosition;
  // double _timelineScrollStartPosition = 0;
  // double _timelineStartPosition = 0;
  // late ValueNotifier<_DragPaintDetails> _dragDetails;
  // Offset? _dragDifferenceOffset;
  // Timer? _timer;

  late List<DateTime> _visibleDates,
      _previousViewVisibleDates,
      _nextViewVisibleDates,
      _currentViewVisibleDates;
  // final int visibleDatesCount =
  //     DateTimeHelper.getViewDatesCount(CalendarView.timelineMonth, 6, -1, []);
  DateTime previousMonth = DateTime(now.year, now.month - 1);
  DateTime nextMonth = DateTime(now.year, now.month + 1);
  DateTime currentMonth = DateTime(now.year, now.month, now.day);

  @override
  void initState() {
    super.initState();

    _previousViewVisibleDates = DateTimeHelper.getMonthDates(
        year: previousMonth.year, month: previousMonth.month);
    _currentViewVisibleDates = DateTimeHelper.getMonthDates(
        year: currentMonth.year, month: currentMonth.month);

    _nextViewVisibleDates = DateTimeHelper.getMonthDates(
        year: nextMonth.year, month: nextMonth.month);
    _visibleDates = [
      // ..._previousViewVisibleDates,
      ..._currentViewVisibleDates,
      // ..._nextViewVisibleDates
    ];
    final todayDateIndex = _visibleDates.indexWhere(
        (e) => e.year == now.year && e.month == now.month && e.day == now.day);
    appointmentsHorController = ScrollController(
        initialScrollOffset: todayDateIndex * (appointmentSize + 6));
    _syncScroller = SyncScrollController(
        [appointmentsVertController, _resourcesVertController]);

    // _dragDetails = ValueNotifier<_DragPaintDetails>(
    //     _DragPaintDetails(position: ValueNotifier<Offset?>(null)));
    // _scrollController = ScrollController()..addListener(_scrollListener);
    // _resourcePanelScrollController = ScrollController();
    // _timelineViewHeaderScrollController = ScrollController();
    // _timelineRulerController = ScrollController()
    //   ..addListener(_timeRulerListener);
    // _timelineViewVerticalScrollController = ScrollController()
    //   ..addListener(_updateResourceScroll);
  }

  // void _updateResourceScroll() {
  // if (_updateCalendarStateDetails.currentViewVisibleDates ==
  //     widget.visibleDates) {
  //   widget.removePicker();
  // }

  // if (widget.resourcePanelScrollController == null ||
  //     !CalendarViewHelper.isResourceEnabled(
  //         widget.calendar.dataSource, widget.view)) {
  //   return;
  // }

  // if (widget.resourcePanelScrollController!.offset !=
  //     _timelineViewVerticalScrollController!.offset) {
  //   widget.resourcePanelScrollController!
  //       .jumpTo(_timelineViewVerticalScrollController!.offset);
  // }
  // }
  // void _timeRulerListener() {
  //   if (!CalendarViewHelper.isTimelineView(CalendarView.timelineMonth)) {
  //     return;
  //   }

  //   if (_timelineRulerController!.offset != _scrollController!.offset) {
  //     _scrollController!.jumpTo(_timelineRulerController!.offset);
  //   }
  // }

  // void _scrollListener() {
  // if (_updateCalendarStateDetails.currentViewVisibleDates ==
  //     widget.visibleDates) {
  //   widget.removePicker();
  // }

  // if (CalendarViewHelper.isTimelineView(CalendarView.timelineMonth)) {
  // widget.getCalendarState(_updateCalendarStateDetails);
  // if (widget.view != CalendarView.timelineMonth) {
  //   _timelineViewHeaderNotifier.value = !_timelineViewHeaderNotifier.value;
  // }

  // if (_timelineRulerController!.offset != _scrollController!.offset) {
  //   _timelineRulerController!.jumpTo(_scrollController!.offset);
  // }

  // if (widget.view == CalendarView.timelineMonth &&
  //     widget.calendar.showWeekNumber) {
  //   final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
  //       widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
  //   final DateTime? date =
  //       _getDateFromPosition(_scrollController!.offset, 0, timeLabelWidth);
  //   if (date != null) {
  //     widget.timelineMonthWeekNumberNotifier.value = date;
  //   }
  // }

  //     _timelineViewHeaderScrollController!.jumpTo(_scrollController!.offset);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    // if (_resourcePanelScrollController != null) {
    //   _resourcePanelScrollController!.dispose();
    //   _resourcePanelScrollController = null;
    // }

    // if (_scrollController != null) {
    //   _scrollController!.removeListener(_scrollListener);
    //   _scrollController!.dispose();
    //   _scrollController = null;
    // }
    // if (_timelineViewHeaderScrollController != null) {
    //   _timelineViewHeaderScrollController!.dispose();
    //   _timelineViewHeaderScrollController = null;
    // }

    // if (_timelineRulerController != null) {
    //   _timelineRulerController!.dispose();
    //   _timelineRulerController = null;
    // }

    appointmentsVertController.dispose();
    _resourcesVertController.dispose();
    _syncScroller?._scrollingController?.dispose();
  }

  // Widget _getTimelineViewHeader() {
  //   final now = DateTime.now();

  // final DateTime prevDate = DateTimeHelper.getPreviousViewStartDate(
  // CalendarView.timelineMonth, 6, currentDate, visibleDatesCount, []);
  //   final DateTime nextDate = DateTimeHelper.getNextViewStartDate(
  //       CalendarView.timelineMonth, 6, currentDate, visibleDatesCount, []);
  //   _visibleDates =
  //       getVisibleDates(currentDate, [], 6, visibleDatesCount).cast();
  // _previousViewVisibleDates =
  //     getVisibleDates(prevDate, [], 6, visibleDatesCount).cast();
  //   _nextViewVisibleDates =
  //       getVisibleDates(nextDate, [], 6, visibleDatesCount).cast();
  //   _currentViewVisibleDates = _visibleDates;
  //   return Container(
  //     decoration: const BoxDecoration(border: bottomBorder),
  //     child: ListView.separated(
  //       separatorBuilder: (context, index) => kSBW6,
  //       itemCount: _currentViewVisibleDates.length,
  //       itemBuilder: (context, index) {
  //         final now = DateTime.now();
  //         final visibleDate = _currentViewVisibleDates[index];
  //         final isToday = visibleDate.day == now.day &&
  //             visibleDate.month == now.month &&
  //             visibleDate.year == now.year;
  //         return DateView(
  //           bgColor: isToday ? AppColors.colorBlue : AppColors.colorLightGray,
  //           day: visibleDate.day.toString(),
  //           textColor: isToday ? AppColors.colorWhite : AppColors.colorDarkGray,
  //           weekDay: shortWeekDays[visibleDate.weekday - 1],
  //         );
  //       },
  //       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 3),
  //       controller: _timelineViewHeaderScrollController,
  //       scrollDirection: Axis.horizontal,
  //       physics: const NeverScrollableScrollPhysics(),
  //     ),
  //   );
  // }
  // void _handlePointerSignal(PointerSignalEvent event) {
  //   // final _CalendarViewState? viewKey = _getCurrentViewByVisibleDates();
  //   // if (event is PointerScrollEvent && viewKey != null) {
  //   double scrolledPosition = event.delta.dx;
  //   /// Check the scrolling is vertical and timeline view does not have
  //   /// vertical scroll view then scroll the vertical movement on
  //   /// Horizontal direction.
  //   if (event.delta.dy.abs() > event.delta.dx.abs() &&
  //       _timelineViewVerticalScrollController!.position.maxScrollExtent == 0) {
  //     scrolledPosition = event.delta.dy;
  //   }
  //   final double targetScrollOffset = math.min(
  //       math.max(_scrollController!.position.pixels + scrolledPosition,
  //           _scrollController!.position.minScrollExtent),
  //       _scrollController!.position.maxScrollExtent);
  //   if (targetScrollOffset != _scrollController!.position.pixels) {
  //     _scrollController!.position.jumpTo(targetScrollOffset);
  //   }
  //   // }
  // }
  // void _onHorizontalUpdate(DragUpdateDetails dragUpdateDetails,
  //     [bool isResourceEnabled = false,
  //     bool isMonthView = false,
  //     bool isTimelineView = false,
  //     double viewHeaderHeight = 0,
  //     double timeLabelWidth = 0,
  //     double resourceItemHeight = 0,
  //     double weekNumberPanelWidth = 0,
  //     bool isNeedDragAndDrop = false]) {
  //   // if (_dragDetails.value.appointmentView != null &&
  //   //     !widget.isMobilePlatform &&
  //   //     isNeedDragAndDrop) {
  //   //   _handleLongPressMove(
  //   //       Offset(dragUpdateDetails.localPosition.dx - widget.width,
  //   //           dragUpdateDetails.localPosition.dy),
  //   //       isTimelineView,
  //   //       isResourceEnabled,
  //   //       isMonthView,
  //   //       viewHeaderHeight,
  //   //       timeLabelWidth,
  //   //       resourceItemHeight,
  //   //       weekNumberPanelWidth);
  //   //   return;
  //   // }
  //   // switch (widget.calendar.viewNavigationMode) {
  //   //   case ViewNavigationMode.none:
  //   //     return;
  //   //   case ViewNavigationMode.snap:
  //   // widget.removePicker();
  //   // if (widget.calendar.monthViewSettings.navigationDirection ==
  //   //         MonthNavigationDirection.horizontal ||
  //   //     widget.view != CalendarView.month) {
  //   final double difference =
  //       dragUpdateDetails.globalPosition.dx - _scrollStartPosition;
  //   if (difference < 0 &&
  //       !DateTimeHelper.canMoveToNextView(
  //           CalendarView.timelineMonth,
  //           6,
  //           DateTime.now().subtract(const Duration(days: 1))
  //           // widget.calendar.minDate,
  //           ,
  //           DateTime(9999),
  //           _currentViewVisibleDates,
  //           [],
  //           false)) {
  //     // _position = 0;
  //     return;
  //   } else if (difference > 0 &&
  //       !DateTimeHelper.canMoveToPreviousView(
  //           CalendarView.timelineMonth,
  //           61,
  //           DateTime.now().subtract(const Duration(days: 1)),
  //           DateTime(9999),
  //           _currentViewVisibleDates,
  //           [],
  //           false)) {
  //     // _position = 0;
  //     return;
  //   }
  //   // _position = difference;
  //   // _clearSelection();
  //   setState(() {
  //     /* Updates the widget navigated distance and moves the widget
  //      in the custom scroll view */
  //   });
  //   // }
  //   // }
  // }
  // void _disposeDrag() {
  //   _drag = null;
  // }
  // void _handleDragUpdate(
  //     DragUpdateDetails details,
  //     bool isTimelineView,
  //     bool isResourceEnabled,
  //     bool isMonthView,
  //     double viewHeaderHeight,
  //     double timeLabelWidth,
  //     double resourceItemHeight,
  //     double weekNumberPanelWidth,
  //     bool isNeedDragAndDrop,
  //     double resourceViewSize) {
  //   // if (!CalendarViewHelper.isTimelineView(widget.view)) {
  //   // return;
  //   // }
  //   // final _CalendarViewState viewKey = _getCurrentViewByVisibleDates()!;
  //   // if (_dragDetails.value.appointmentView != null &&
  //   //     !widget.isMobilePlatform &&
  //   //     isNeedDragAndDrop) {
  //   //   _handleLongPressMove(
  //   //       Offset(details.localPosition.dx - widget.width,
  //   //           details.localPosition.dy),
  //   //       isTimelineView,
  //   //       isResourceEnabled,
  //   //       isMonthView,
  //   //       viewHeaderHeight,
  //   //       timeLabelWidth,
  //   //       resourceItemHeight,
  //   //       weekNumberPanelWidth);
  //   //   return;
  //   // }
  //   /// Calculate the scroll difference by current scroll position and start
  //   /// scroll position.
  //   final double difference =
  //       details.globalPosition.dx - _timelineStartPosition;
  //   if (_timelineScrollStartPosition >=
  //           _scrollController!.position.maxScrollExtent &&
  //       (difference < 0)) {
  //     /// Set the scroll position as timeline scroll start position and the
  //     /// value used on horizontal update method.
  //     _scrollStartPosition = _timelineStartPosition;
  //     _drag?.cancel();
  //     /// Move the touch(drag) to custom scroll view.
  //     _onHorizontalUpdate(details);
  //     /// Enable boolean value used to trigger the horizontal end animation on
  //     /// drag end.
  //     // _isNeedTimelineScrollEnd = true;
  //     /// Remove the timeline view drag or scroll.
  //     _disposeDrag();
  //     return;
  //   } else if (_timelineScrollStartPosition <=
  //           _scrollController!.position.minScrollExtent &&
  //       (difference > 0)) {
  //     /// Set the scroll position as timeline scroll start position and the
  //     /// value used on horizontal update method.
  //     _scrollStartPosition = _timelineStartPosition;
  //     _drag?.cancel();
  //     /// Move the touch(drag) to custom scroll view.
  //     _onHorizontalUpdate(details);
  //     /// Enable boolean value used to trigger the horizontal end animation on
  //     /// drag end.
  //     // _isNeedTimelineScrollEnd = true;
  //     /// Remove the timeline view drag or scroll.
  //     _disposeDrag();
  //     return;
  //   }
  //   _drag?.update(details);
  // }
  // void _handleDragStart(
  //     DragStartDetails details,
  //     bool isNeedDragAndDrop,
  //     bool isTimelineView,
  //     bool isResourceEnabled,
  //     double viewHeaderHeight,
  //     double timeLabelWidth,
  //     double resourceViewSize) {
  //   // if (!CalendarViewHelper.isTimelineView(widget.view)) {
  //   //   return;
  //   // }
  //   // final _CalendarViewState viewKey = _getCurrentViewByVisibleDates()!;
  //   // if (viewKey._hoveringAppointmentView != null &&
  //   //     !widget.isMobilePlatform &&
  //   //     isNeedDragAndDrop) {
  //   //   _handleAppointmentDragStart(
  //   //       viewKey._hoveringAppointmentView!.clone(),
  //   //       isTimelineView,
  //   //       Offset(details.localPosition.dx - widget.width,
  //   //           details.localPosition.dy),
  //   //       isResourceEnabled,
  //   //       viewHeaderHeight,
  //   //       timeLabelWidth);
  //   //   return;
  //   // }
  //   _timelineScrollStartPosition = _scrollController!.position.pixels;
  //   _timelineStartPosition = details.globalPosition.dx;
  //   // _isNeedTimelineScrollEnd = false;
  //   /// If the timeline view scroll starts at min or max scroll position then
  //   /// move the previous view to end of the scroll or move the next view to
  //   /// start of the scroll
  //   if (_timelineScrollStartPosition >=
  //       _scrollController!.position.maxScrollExtent) {
  //     // _positionTimelineView();
  //   } else if (_timelineScrollStartPosition <=
  //       _scrollController!.position.minScrollExtent) {
  //     // _positionTimelineView();
  //   }
  //   /// Set the drag as timeline scroll controller drag.
  //   if (_scrollController!.hasClients) {
  //     _drag = _scrollController!.position.drag(details, _disposeDrag);
  //   }
  // }
  int daysAfterStartDate(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    final date = to.difference(from);

    return date.inDays;
  }

  List<DateTime> getDatesAfterStartDateBeforeEnd(
      DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];

    for (int i = 0;
        i <
            daysAfterStartDate(
              startDate,
              endDate,
            );) {
      i++;
      days.add(DateTime(
          startDate.year,
          startDate.month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          startDate.day + i));
    }
    return days;
  }

  // DateTime? startDate;
  // DateTime? previusDate;
  // bool isTail = false;
  // List<DateTime> startEndDiffDates = [];
  // int itemIndex = 0;
  // DateTime? visibleDate;

  ///appointmentIndex Индекс карточки записи гостя
  int appointmentIndex = 0;

  ///startEndDiffDates Даты после дня заезда до дня выезда
  List<DateTime> startEndDiffDates = [];

  ///startDate Дата заезда гостя
  DateTime? startDate;
  // bool? isSameStartVisibleDate;
  ///visibleDate День из месяца для отображения
  DateTime? visibleDate;

  @override
  Widget build(BuildContext context) {
    // _currentViewVisibleDates =
    // DateUtils().getDaysInMonth(currentDate.year,currentDate.month)
    // getVisibleDates(currentDate, [], 6, visibleDatesCount).cast();

    return SafeArea(
        child: Stack(
      fit: StackFit.expand,
      children: [
        ///
        ///Даты с записями гостей
        ///
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          left: 89,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            controller: appointmentsHorController,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///
                        ///Верхние даты
                        ///
                        Container(
                          height: 82,
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: const BoxDecoration(
                              color: AppColors.colorWhite,
                              border: bottomBorder),
                          child: Row(
                              children: List.generate(
                                  math.max(0, _visibleDates.length * 2 - 1),
                                  (index) {
                            if (index.isEven) {
                              final int itemIndex = index ~/ 2;
                              final now = DateTime.now();
                              visibleDate = _visibleDates[itemIndex];
                              final isToday = visibleDate?.day == now.day &&
                                  visibleDate?.month == now.month &&
                                  visibleDate?.year == now.year;

                              return DateView(
                                bgColor: isToday
                                    ? AppColors.colorBlue
                                    : AppColors.colorLightGray,
                                day: visibleDate!.day.toString(),
                                textColor: isToday
                                    ? AppColors.colorWhite
                                    : AppColors.colorDarkGray,
                                weekDay:
                                    shortWeekDays[visibleDate!.weekday - 1],
                              );
                            }
                            return kSBW6;
                          })),
                        ),

                        ///
                        ///Нижние даты с записями
                        ///
                        NotificationListener<ScrollNotification>(
                            child: Flexible(
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification
                                    overscroll) {
                                  overscroll.disallowIndicator();
                                  return false;
                                },
                                child: SizedBox(
                                  height: (listResources.length * 92) + 82,
                                  width: _visibleDates.length * 52,
                                  child: CustomScrollView(
                                      controller: appointmentsVertController,
                                      slivers: [
                                        SliverList(
                                            delegate: SliverChildListDelegate(
                                          [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: List.generate(
                                                listResources.length,
                                                (columnIndex) {
                                                  appointmentIndex = 0;

                                                  ///currentResourceApointments Записи гостей у текущего ряда
                                                  List<GuestModel>
                                                      currentResourceApointments =
                                                      [];

                                                  ///resource Текущий ряд
                                                  ObjectToBook? resource =
                                                      listResources[
                                                          columnIndex];

                                                  ///allResourcesDates Список дат для каждого ряда
                                                  List<List<DateTime>>
                                                      allResourcesDates =
                                                      List.generate(
                                                          (listResources
                                                                  .isNotEmpty
                                                              ? listResources
                                                                  .length
                                                              : 0),
                                                          (index) => [
                                                                ..._visibleDates
                                                              ]);

                                                  ///currentResourceDates Даты для текущего ряда
                                                  List<DateTime>
                                                      currentResourceDates =
                                                      allResourcesDates[
                                                          columnIndex];

                                                  ///Добавляем записи гостей в список
                                                  currentResourceApointments
                                                      .addAll(listAppointment
                                                          .where((a) =>
                                                              a.resourceId ==
                                                              resource.id));

                                                  ///Сортируем по дате
                                                  currentResourceApointments
                                                      .sort((a, b) => a
                                                          .startDate!
                                                          .compareTo(
                                                              b.startDate!));

                                                  // if (currentResourceApointments
                                                  // .isNotEmpty
                                                  // &&
                                                  // appointmentIndex <
                                                  //     currentResourceApointments
                                                  //         .length
                                                  // ) {
                                                  // startDate = currentResourceApointments[
                                                  //         appointmentIndex ==
                                                  //                 0
                                                  //             ? appointmentIndex
                                                  //             : appointmentIndex -
                                                  //                 1]
                                                  //     .startDate!;
                                                  // startEndDiffDates =
                                                  //     currentResourceApointments
                                                  //             .isEmpty
                                                  //         ? []
                                                  //         : getDatesAfterStartDateBeforeEnd(
                                                  //             startDate!,
                                                  //             currentResourceApointments[appointmentIndex ==
                                                  //                         0
                                                  //                     ? appointmentIndex
                                                  //                     : appointmentIndex -
                                                  //                         1]
                                                  //                 .endDate!,
                                                  //           );
                                                  // for (var r
                                                  //     in allResourcesDates) {
                                                  // appointmentIndex = 0;
                                                  // for (int currentResourceDatesIndex =
                                                  //         0;
                                                  //     currentResourceDatesIndex <
                                                  //         allResourcesDates
                                                  //             .length;
                                                  //     currentResourceDatesIndex++) {

                                                  ///Делаем цикл для получения индекса дат для текущего ряда
                                                  for (int i = 0;
                                                      i <
                                                          currentResourceDates
                                                              .length;
                                                      i++) {
                                                    ///Помечаем пустым чтобы они не складывались
                                                    startEndDiffDates = [];
                                                    visibleDate =
                                                        currentResourceDates[i];

                                                    ///Если записи гостей в текущем ряду не пусты
                                                    if (currentResourceApointments
                                                        .isNotEmpty) {
                                                      ///Делаем цикл для получения записи гостя
                                                      for (var apointment
                                                          in currentResourceApointments) {
                                                        ///Если дата заезда гостя и текущая дата совпадают
                                                        if (isSameDate(
                                                            apointment
                                                                .startDate,
                                                            visibleDate)) {
                                                          startEndDiffDates =
                                                              currentResourceApointments
                                                                      .isEmpty
                                                                  ? []
                                                                  : getDatesAfterStartDateBeforeEnd(
                                                                      apointment
                                                                          .startDate!,
                                                                      apointment
                                                                          .endDate!,
                                                                    );
                                                        }

                                                        // }
                                                        // if (currentResourceApointments
                                                        //         .isNotEmpty &&
                                                        //     appointmentIndex <
                                                        //         currentResourceApointments
                                                        //             .length) {
                                                        // startDate = currentResourceApointments[
                                                        //         appointmentIndex ==
                                                        //                 0
                                                        //             ? appointmentIndex
                                                        //             : appointmentIndex]
                                                        //     .startDate!;
                                                        // final isSameStartVisibleDate =
                                                        //     isSameDate(
                                                        //         startDate,
                                                        //         visibleDate);
                                                        // if (isSameStartVisibleDate ==
                                                        //     true) {
                                                        //   // previusDate =
                                                        //   //     visibleDate;
                                                        //   appointmentIndex++;
                                                        // }
                                                        // startEndDiffDates =
                                                        //     currentResourceApointments
                                                        //             .isEmpty
                                                        //         ? []
                                                        //         : getDatesAfterStartDateBeforeEnd(
                                                        //             startDate!,
                                                        //             currentResourceApointments[appointmentIndex ==
                                                        //                         0
                                                        //                     ? appointmentIndex
                                                        //                     : appointmentIndex]
                                                        //                 .endDate!,
                                                        //           );

                                                        // if (startEndDiffDates
                                                        //     .isNotEmpty) {
                                                        //   r.removeWhere((e) {
                                                        //     if (startEndDiffDates
                                                        //         .contains(e)) {
                                                        //       return true;
                                                        //     }
                                                        //     return false;
                                                        //   });
                                                        //   // }
                                                        // }

                                                        // startEndDiffDates =
                                                        //     currentResourceApointments
                                                        //             .isEmpty
                                                        //         ? []
                                                        //         : getDatesAfterStartDateBeforeEnd(
                                                        //             startDate!,
                                                        //             currentResourceApointments[
                                                        //                     appointmentIndex == 0
                                                        //                         ? appointmentIndex
                                                        //                         : appointmentIndex - 1
                                                        //                     // reducedAppointmentIndex
                                                        //                     ]
                                                        //                 .endDate!,
                                                        //           );
                                                      }

                                                      ///Если даты после дня заезда до дня выезда не пусты
                                                      if (startEndDiffDates
                                                          .isNotEmpty) {
                                                        ///Если в списке дат после дня заезда до дня выезда
                                                        ///содержутся даты для отображения в текущем ряду
                                                        allResourcesDates[
                                                                columnIndex]
                                                            .removeWhere((e) {
                                                          if (startEndDiffDates
                                                              .contains(e)) {
                                                            return true;
                                                          }
                                                          return false;
                                                        });
                                                      }
                                                    }
                                                  }

                                                  return Container(
                                                    height: 92,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 3),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .colorWhite,
                                                            border:
                                                                bottomBorder),
                                                    child: Row(
                                                        children: List.generate(
                                                            math.max(
                                                                0,
                                                                currentResourceDates
                                                                            .length *
                                                                        2 -
                                                                    1),
                                                            (index) {
                                                      final itemIndex =
                                                          index ~/ 2;
                                                      if (index.isEven) {
                                                        // final
                                                        visibleDate =
                                                            currentResourceDates[
                                                                itemIndex];
                                                        // bool?
                                                        // isSameStartVisibleDate;
                                                        // final List<DateTime>
                                                        //     listDatesForRow =
                                                        // _visibleDates;
                                                        // final nextVisDate =
                                                        //     _visibleDates[datesIndex ==
                                                        //             _visibleDates
                                                        //                     .length -
                                                        //                 1
                                                        //         ? datesIndex
                                                        //         : datesIndex +
                                                        //             1];
                                                        // final prevVisDate =
                                                        //     _visibleDates[
                                                        //         itemIndex == 0
                                                        //             ? itemIndex
                                                        //             : itemIndex -
                                                        //                 1];

                                                        ///ИНДЕКС ДЛЯ ОТОБРАЖЕНИЯ КАРТОЧЕК ЗАПИСИ С ВЫЧИТАНИЕМ 1 ЭЛЕМЕНТА ДЛЯ КОРРЕКТНОГО ОТБРАЖЕНИЯ
                                                        int reducedAppointmentIndex =
                                                            0;

                                                        ///isSameStartVisibleDate true ЕСЛИ ДАТА ЗАЕЗДА ГОСТЯ И ДАТА НА ЗАДНЕМ ФОНЕ РАВНЫ
                                                        final isSameStartVisibleDate =
                                                            isSameDate(
                                                                startDate,
                                                                visibleDate);
                                                        if (currentResourceApointments
                                                                .isNotEmpty &&
                                                            appointmentIndex <
                                                                currentResourceApointments
                                                                    .length) {
                                                          startDate =
                                                              currentResourceApointments[
                                                                      appointmentIndex]
                                                                  .startDate!;

                                                          if (isSameStartVisibleDate ==
                                                                  true &&
                                                              appointmentIndex <
                                                                  currentResourceApointments
                                                                      .length) {
                                                            appointmentIndex++;
                                                          }
                                                          reducedAppointmentIndex =
                                                              appointmentIndex ==
                                                                      0
                                                                  ? appointmentIndex
                                                                  : appointmentIndex -
                                                                      1;
                                                          startEndDiffDates =
                                                              currentResourceApointments
                                                                      .isEmpty
                                                                  ? []
                                                                  : getDatesAfterStartDateBeforeEnd(
                                                                      startDate!,
                                                                      currentResourceApointments[
                                                                              // appointmentIndex == 0 ? appointmentIndex : appointmentIndex - 1
                                                                              reducedAppointmentIndex]
                                                                          .endDate!,
                                                                    );
                                                        }

                                                        final isAppointment =
                                                            isSameStartVisibleDate ==
                                                                    true &&
                                                                currentResourceApointments
                                                                    .isNotEmpty;

                                                        // int daysBetween(
                                                        //     DateTime from,
                                                        //     DateTime to) {
                                                        //   return (from
                                                        //       .difference(to)
                                                        //       .inDays);
                                                        // }
                                                        ///РАЗНИЦА В ДНЯХ МЕЖДУ ДАТОЙ ЗАЕЗДА И ВЫЕЗДА
                                                        // final endStartDateDiff =
                                                        //     currentResourceApointments
                                                        //             .isEmpty
                                                        //         ? 0
                                                        //         : getDaysInBeteween(
                                                        //             startDate!,
                                                        //             currentResourceApointments[
                                                        //                     reducedAppointmentIndex]
                                                        //                 .endDate!,
                                                        //           ).length;
                                                        // bool
                                                        //     isAppointmentTail() {
                                                        // int i = 0;
                                                        // for (int i = 0;
                                                        //     i > departureArrivalDateDiff;
                                                        //     i++) {
                                                        //   if (departureArrivalDateDiff
                                                        //               .isNegative ==
                                                        //           false &&
                                                        //       departureArrivalDateDiff !=
                                                        //           0) {
                                                        //     _isAppointmentTail =
                                                        //         _visibleDates[
                                                        //                 appointmentIndex +
                                                        //                     i] ==
                                                        //             visibleDate;
                                                        //   }
                                                        // }
                                                        // if (index != 0) {
                                                        // _visibleDates
                                                        //     .removeWhere((a) {
                                                        //   if (startEndDiffDates
                                                        //           .contains(
                                                        //               a) ==
                                                        //       true) {
                                                        //     // var subtractedIndex =
                                                        //     // (datesIndex ==
                                                        //     //         0)
                                                        //     //     ? (datesIndex)
                                                        //     // :
                                                        //     // (itemIndex -
                                                        //     // 2);
                                                        //     // itemIndex =
                                                        //     // subtractedIndex;
                                                        //     return true;
                                                        //   }
                                                        //   return false;
                                                        // });
                                                        // }
                                                        // isTail = startEndDiffDates
                                                        //     .any((e) =>
                                                        //         isSameDate(e,
                                                        //             visibleDate));
                                                        //  isSameDate(
                                                        //       _currentViewVisibleDates[
                                                        //           itemIndex +
                                                        //               i],
                                                        //       visibleDate
                                                        //       // currentResourceApointments[appointmentIndex].
                                                        //       );
                                                        // }//
                                                        // if (isTail == true &&
                                                        //     i < endStartDateDiff) {
                                                        //   i++;
                                                        // }
                                                        // }
                                                        // return isTail;
                                                        // }
                                                        ///

                                                        if (isAppointment ==
                                                            false) {
                                                          return DateView(
                                                            bgColor: AppColors
                                                                .colorLightGray,
                                                            day: visibleDate!
                                                                .day
                                                                .toString(),
                                                            textColor: AppColors
                                                                .colorGray,
                                                            weekDay: shortWeekDays[
                                                                visibleDate!
                                                                        .weekday -
                                                                    1],
                                                          );
                                                        } else {
                                                          final bool
                                                              isContinue =
                                                              startEndDiffDates
                                                                      .isNotEmpty
                                                                  ? startEndDiffDates
                                                                      .last
                                                                      .isAfter(
                                                                          _visibleDates
                                                                              .last)
                                                                  : false;

                                                          return SizedBox(
                                                            width: (appointmentSize +
                                                                    (startEndDiffDates
                                                                            .isNotEmpty
                                                                        ? (appointmentSize * startEndDiffDates.length) +
                                                                            (startEndDiffDates.length) *
                                                                                6
                                                                        : 0)) -
                                                                (isContinue
                                                                    ? (startEndDiffDates.where((e) => e.isAfter(_visibleDates.last)).length *
                                                                            46) +
                                                                        (startEndDiffDates.where((e) => e.isAfter(_visibleDates.last)).length *
                                                                            6)
                                                                    : 0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                print(
                                                                    "CLIP! ${Random().nextInt(99999999)}");
                                                                context.pushNamed(
                                                                    'guest_info',
                                                                    extra: {
                                                                      'info': currentResourceApointments[
                                                                              reducedAppointmentIndex]
                                                                          .toMap()
                                                                    });
                                                              },
                                                              child:
                                                                  AppointmentViewWidget(
                                                                borderRadius: BorderRadius.circular(12).copyWith(
                                                                    bottomRight:
                                                                        Radius.circular(isContinue
                                                                            ? 0
                                                                            : 12),
                                                                    topRight: Radius.circular(
                                                                        isContinue
                                                                            ? 0
                                                                            : 12)),
                                                                appointment: currentResourceApointments[
                                                                    // appointmentIndex !=
                                                                    //         0
                                                                    //     ? appointmentIndex -
                                                                    //         1
                                                                    //     : 0
                                                                    reducedAppointmentIndex],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                      return kSBW6;
                                                    })),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 82)
                                          ],
                                        ))
                                      ]),
                                ),
                              ),
                            ),
                            onNotification: (ScrollNotification scrollInfo) {
                              _syncScroller?.processNotification(
                                  scrollInfo, appointmentsVertController);
                              return true;
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///
        ///RESOURCES BAR
        ///
        Positioned(
          top: 82,
          bottom: 0,
          left: 0,
          width: 89,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              _syncScroller?.processNotification(
                  scrollInfo, _resourcesVertController);
              return true;
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: SizedBox(
                width: 89,
                child: CustomScrollView(
                  controller: _resourcesVertController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: List.generate(
                                listResources.length,
                                (index) => ResourceViewWidget(
                                    resource: listResources[index])),
                          ),
                          SplashButton(
                            onTap: () {},
                            child: SizedBox(
                                height: 82,
                                child: Center(
                                  child: SvgPicture.asset(
                                    height: 14,
                                    AppImages.plus,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.colorDarkGray,
                                        BlendMode.srcIn),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///
        ///Calendar button
        ///
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            height: 82,
            width: 89,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                color: AppColors.colorWhite,
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.colorLightGray,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignInside))),
            child: SplashButton(
              onTap: () {},
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.calendar),
                    kSBH6,
                    Text(
                      'Авг. 2023',
                      style: AppTextStyle.w500s12
                          .copyWith(color: AppColors.colorDarkGray),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));

    // SafeArea(
    //   child: Stack(children: <Widget>[
    //     Positioned(
    //       top: 0,
    //       left: 0,
    //       right: 0,
    //       height: 82,
    //       child: Container(
    //         color: AppColors.colorGray,
    //         child: _getTimelineViewHeader(),
    //       ),
    //     ),
    //     Positioned(
    //       left: 0,
    //       width: 89,
    //       top: 82,
    //       // bottom: 0,
    //       child: MouseRegion(
    //         // onEnter: (PointerEnterEvent event) {
    //         //   _pointerEnterEvent(event, false, isRTL, null,
    //         //       top + widget.headerHeight, 0, isResourceEnabled);
    //         // },
    //         // onExit: _pointerExitEvent,
    //         // onHover: (PointerHoverEvent event) {
    //         //   _pointerHoverEvent(event, false, isRTL, null,
    //         //       top + widget.headerHeight, 0, isResourceEnabled);
    //         // },
    //         child: GestureDetector(
    //           child: ScrollConfiguration(
    //             behavior:
    //                 ScrollConfiguration.of(context).copyWith(scrollbars: false),
    //             child: ListView.builder(
    //               clipBehavior: Clip.hardEdge,
    //               shrinkWrap: true,
    //               itemCount: listResources.length,
    //               itemBuilder: (context, index) {
    //                 final resourceStyle = AppTextStyle.w500s10.copyWith(
    //                     height: 12.0.toFigmaHeight(10),
    //                     color: AppColors.colorDarkGray);
    //                 return Container(
    //                   constraints: const BoxConstraints(minHeight: 92),
    //                   decoration: const BoxDecoration(
    //                       color: AppColors.colorWhite, border: bottomBorder),
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: 18, vertical: 12),
    //                   child: Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       SvgPicture.asset(
    //                         AppImages.bed,
    //                         colorFilter: const ColorFilter.mode(
    //                             AppColors.colorDarkGray, BlendMode.srcIn),
    //                       ),
    //                       kSBH4,
    //                       Text(listResources[index].objectName!,
    //                           style: resourceStyle),
    //                       kSBH2,
    //                       Text(listResources[index].object!,
    //                           style: resourceStyle),
    //                       kSBH2,
    //                       Text("${listResources[index].roomsCount!} персоны",
    //                           style: resourceStyle),
    //                     ],
    //                   ),
    //                 );
    //               },
    //               padding: EdgeInsets.zero,
    //               physics: const ClampingScrollPhysics(),
    //               controller: _resourcePanelScrollController,
    //               // children: <Widget>[
    //               // ResourceViewWidget(
    //               //     _resourceCollection,
    //               //     widget.resourceViewSettings,
    //               //     resourceItemHeight,
    //               //     widget.cellBorderColor,
    //               //     _calendarTheme,
    //               //     _themeData,
    //               //     _resourceImageNotifier,
    //               //     isRTL,
    //               //     _textScaleFactor,
    //               //     _resourceHoverNotifier.value,
    //               //     _imagePainterCollection,
    //               //     resourceViewSize,
    //               //     panelHeight,
    //               //     widget.resourceViewHeaderBuilder),
    //               // ]
    //             ),
    //           ),
    //           // onTapUp: (TapUpDetails details) {
    //           //   _handleOnTapForResourcePanel(details, resourceItemHeight);
    //           // },
    //           // onLongPressStart: (LongPressStartDetails details) {
    //           //   _handleOnLongPressForResourcePanel(details, resourceItemHeight);
    //           // },
    //         ),
    //       ),
    //     ),
    //     // Positioned(
    //     //   top: 82,
    //     //   left: 0,
    //     //   right: 0,
    //     //   height: 82,
    //     //   child: ListView(
    //     //     padding: EdgeInsets.zero,
    //     //     controller: _timelineRulerController,
    //     //     scrollDirection: Axis.horizontal,
    //     //     physics: const _CustomNeverScrollableScrollPhysics(),
    //     //     children: <Widget>[
    //     //       _getTimelineViewHeader(),
    //     //     ],
    //     //   ),
    //     //   // Scrollbar(
    //     //   //   controller: _scrollController,
    //     //   //   thumbVisibility: !true,
    //     //   //   child: Container(
    //     //   //     color: AppColors.colorGray,
    //     //   //     child: _getTimelineViewHeader(),
    //     //   //   ),
    //     //   // ),
    //     // ),
    //     Positioned(
    //       left: 0,
    //       top: 0,
    //       child: Container(
    //         height: 82,
    //         width: 89,
    //         clipBehavior: Clip.hardEdge,
    //         decoration: const BoxDecoration(
    //             color: AppColors.colorWhite, border: bottomBorder),
    //         child: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SvgPicture.asset(AppImages.calendar),
    //               kSBH6,
    //               Text(
    //                 'Авг. 2023',
    //                 style: AppTextStyle.w500s12
    //                     .copyWith(color: AppColors.colorDarkGray),
    //               )
    //             ],
    //           ),
    //         ),
    //         // ),
    //         // ],
    //       ),
    //     ),
    //     Positioned(
    //         top: 82,
    //         left: 0,
    //         right: 0,
    //         height: 18,
    //         child: ListView(
    //           padding: EdgeInsets.zero,
    //           controller: _timelineRulerController,
    //           scrollDirection: Axis.horizontal,
    //           physics: const _CustomNeverScrollableScrollPhysics(),
    //           children: <Widget>[
    //             // RepaintBoundary(
    //             //     child: CustomPaint(
    //             //   painter: _TimeRulerView(
    //             //       _horizontalLinesCount!,
    //             //       _timeIntervalHeight,
    //             //       widget.calendar.timeSlotViewSettings,
    //             //       widget.calendar.cellBorderColor,
    //             //       _isRTL,
    //             //       locale,
    //             //       widget.calendarTheme,
    //             //       CalendarViewHelper.isTimelineView(widget.view),
    //             //       widget.visibleDates,
    //             //       widget.textScaleFactor),
    //             //   size: Size(width, timeLabelSize),
    //             // )),
    //           ],
    //         )),
    //     Positioned(
    //         top: 82,
    //         left: 0,
    //         right: 0,
    //         bottom: 0,
    //         child: Scrollbar(
    //           controller: _scrollController,
    //           thumbVisibility: !true,
    //           child: ListView(
    //               padding: EdgeInsets.zero,
    //               controller: _scrollController,
    //               scrollDirection: Axis.horizontal,
    //               physics: const _CustomNeverScrollableScrollPhysics(),
    //               children: <Widget>[
    //                 SizedBox(
    //                     width: context.width,
    //                     child: Stack(children: <Widget>[
    //                       Scrollbar(
    //                           controller: _timelineViewVerticalScrollController,
    //                           thumbVisibility: !true,
    //                           child: ListView(
    //                               padding: EdgeInsets.zero,
    //                               controller:
    //                                   _timelineViewVerticalScrollController,
    //                               physics: ClampingScrollPhysics(),
    //                               children: <Widget>[
    //                                 Stack(children: <Widget>[
    //                                   Row(
    //                                     children: List.generate(
    //                                         10,
    //                                         (index) => Text(
    //                                             '_getTimelineViewHeader _getTimelineViewHeader _getTimelineViewHeader ')),
    //                                   )
    //                                   // RepaintBoundary(
    //                                   //     child:
    //                                   //      _CalendarMultiChildContainer(
    //                                   //   width: width,
    //                                   //   height: height,
    //                                   //   children: <Widget>[
    //                                   //     RepaintBoundary(
    //                                   //         child: TimelineWidget(
    //                                   //             _horizontalLinesCount!,
    //                                   //             widget.visibleDates,
    //                                   //             widget.calendar
    //                                   //                 .timeSlotViewSettings,
    //                                   //             _timeIntervalHeight,
    //                                   //             widget.calendar.cellBorderColor,
    //                                   //             _isRTL,
    //                                   //             widget.calendarTheme,
    //                                   //             widget.themeData,
    //                                   //             _calendarCellNotifier,
    //                                   //             _scrollController!,
    //                                   //             widget.regions,
    //                                   //             resourceItemHeight,
    //                                   //             widget.resourceCollection,
    //                                   //             widget.textScaleFactor,
    //                                   //             widget.isMobilePlatform,
    //                                   //             widget
    //                                   //                 .calendar.timeRegionBuilder,
    //                                   //             width,
    //                                   //             height,
    //                                   //             widget.minDate,
    //                                   //             widget.maxDate,
    //                                   //             widget.blackoutDates)),
    //                                   // RepaintBoundary(
    //                                   //     child: _addAppointmentPainter(width,
    //                                   //         height, resourceItemHeight)),
    //                                   //   ],
    //                                   // )),
    //                                   // RepaintBoundary(
    //                                   //   child: CustomPaint(
    //                                   //     painter: _addSelectionView(
    //                                   //         resourceItemHeight),
    //                                   //     size: Size(width, height),
    //                                   //   ),
    //                                   // ),
    //                                   // _getCurrentTimeIndicator(
    //                                   // timeLabelSize, width, height, true),
    //                                 ]),
    //                               ])),
    //                     ])),
    //               ]),
    //         )),
    //   ]),
    // );
  }
}

class SyncScrollController {
  List<ScrollController> _registeredScrollControllers = [];

  ScrollController? _scrollingController;
  bool _scrollingActive = false;

  SyncScrollController(List<ScrollController> controllers) {
    for (var controller in controllers) {
      registerScrollController(controller);
    }
  }

  void registerScrollController(ScrollController controller) {
    _registeredScrollControllers.add(controller);
  }

  void processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        for (var controller in _registeredScrollControllers) {
          // _registeredScrollControllers.forEach((controller) => {
          if (!identical(_scrollingController, controller)) {
            controller.jumpTo(_scrollingController!.offset);
          }

          // });
          // return;
        }
      }
    }
  }
}
