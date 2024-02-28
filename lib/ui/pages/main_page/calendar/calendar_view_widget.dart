import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/saved_guest_card.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/time_view_card.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_calendar_dialog.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/appointment_view_card.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/data/data.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/date_view_card.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/resource_view_card.dart';
import 'package:qaz_booking_ui/ui/widgets/lib/src/calendar/common/date_time_engine.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

///
///TODO: Вынести часто используемые числовые значения в ui constants
///
enum CalendarViewEnum {
  day,
  hour,
}

enum BookedGuesEntryViewEnum {
  start,
  startEnd,
  center,
  end,
  none,
  date,
}

class CalendarViewWidget extends StatefulWidget {
  const CalendarViewWidget({super.key, required this.calendarViewEnum});
  final ValueNotifier<CalendarViewEnum> calendarViewEnum;

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
  List<int> getHours() {
    List<int> hours = [];
    for (int i = 0; i < 24; i++) {
      hours.add(i);
    }
    return hours;
  }

  late final List<int> visibleTimes = getHours();

  late List<DateTime> _visibleDates,
      _previousViewVisibleDates,
      _nextViewVisibleDates,
      _currentViewVisibleDates;
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
    final todayDateIndex = widget.calendarViewEnum.value == CalendarViewEnum.day
        ? _visibleDates.indexWhere((e) =>
            e.year == now.year && e.month == now.month && e.day == now.day)
        : visibleTimes.indexWhere((e) =>
            selectedDay.value.year == now.year &&
            selectedDay.value.month == now.month &&
            selectedDay.value.day == now.day &&
            e == selectedDay.value.hour);
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
    appointmentsHorController.dispose();
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

  List<DateTime> getDateHours(DateTime startDate_, DateTime endDate_) {
    List<DateTime> dates = [];

    for (int i = 1;
        startDate_.add(Duration(hours: i)).isBefore(endDate_) ||
            startDate_.add(Duration(hours: i)).isAtSameMomentAs(endDate_);
        i++) {
      dates.add(startDate_.add(Duration(hours: i)));
    }

    return dates;
  }

  ///appointmentIndex Индекс карточки записи гостя
  int appointmentIndex = 0;

  ///startEndDiffDates Даты после дня заезда до дня выезда
  List<DateTime> startEndDiffDates = [];

  ///startEndDiffTimes Время в часах после дня заезда до дня выезда
  List<DateTime> startEndDiffTimes = [];

  ///startDate Дата заезда гостя
  DateTime? startDate;

  ///startDate Дата заезда гостя
  // DateTime? _startDate;

  ///visibleDate День из месяца для отображения
  DateTime? visibleDate;

  ///visibleTime Час из дня для отображения
  int? visibleTime;

  ValueNotifier<DateTime> selectedDay = ValueNotifier(DateTime.now());

  // List<GuestModel> selectedDayAppointments = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ValueListenableBuilder(
            valueListenable: widget.calendarViewEnum,
            builder: (context, v, child) {
              bool isCalendarDayView =
                  widget.calendarViewEnum.value == CalendarViewEnum.day;
              return ValueListenableBuilder(
                  valueListenable: selectedDay,
                  builder: (context, v, child) {
                    return Stack(
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
                            // key: PageStorageKey('myListView'),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          decoration: const BoxDecoration(
                                              color: AppColors.colorWhite,
                                              border: bottomBorder),
                                          child: Row(
                                              children: List.generate(
                                                  math.max(
                                                      0,
                                                      (isCalendarDayView == true
                                                                  ? _visibleDates
                                                                      .length
                                                                  : visibleTimes
                                                                      .length) *
                                                              2 -
                                                          1), (index) {
                                            if (index.isEven) {
                                              final int itemIndex = index ~/ 2;
                                              final now = DateTime.now();
                                              if (isCalendarDayView == true) {
                                                visibleDate =
                                                    _visibleDates[itemIndex];
                                                final isToday =
                                                    visibleDate?.day ==
                                                            now.day &&
                                                        visibleDate?.month ==
                                                            now.month &&
                                                        visibleDate?.year ==
                                                            now.year;

                                                return DateViewCard(
                                                  bgColor: isToday
                                                      ? AppColors.colorBlue
                                                      : AppColors
                                                          .colorLightGray,
                                                  day: visibleDate!.day
                                                      .toString(),
                                                  textColor: isToday
                                                      ? AppColors.colorWhite
                                                      : AppColors.colorDarkGray,
                                                  weekDay: shortWeekDays[
                                                      visibleDate!.weekday - 1],
                                                );
                                              } else if (isCalendarDayView ==
                                                  false) {
                                                // final int itemIndex =
                                                //     index ~/ 2;
                                                // final now = DateTime.now();
                                                final isCurrenTime =
                                                    visibleTimes[itemIndex] ==
                                                            now.hour &&
                                                        isSameDate(now,
                                                            selectedDay.value);

                                                return TimeViewCard(
                                                  bgColor: isCurrenTime
                                                      ? AppColors.colorBlue
                                                      : AppColors
                                                          .colorLightGray,
                                                  hour:
                                                      "${visibleTimes[itemIndex]}:00",
                                                  textColor: isCurrenTime
                                                      ? AppColors.colorWhite
                                                      : AppColors.colorDarkGray,
                                                );
                                              }
                                            }
                                            return kSBW6;
                                          })),
                                        ),

                                        ///
                                        ///Нижние даты с записями
                                        ///
                                        NotificationListener<
                                                ScrollNotification>(
                                            child: Flexible(
                                              child: NotificationListener<
                                                  OverscrollIndicatorNotification>(
                                                onNotification:
                                                    (OverscrollIndicatorNotification
                                                        overscroll) {
                                                  overscroll
                                                      .disallowIndicator();
                                                  return false;
                                                },
                                                child: SizedBox(
                                                  height:
                                                      (listResources.length *
                                                              92) +
                                                          82,
                                                  width: (isCalendarDayView ==
                                                              true
                                                          ? _visibleDates.length
                                                          : visibleTimes
                                                              .length) *
                                                      52,
                                                  child: CustomScrollView(
                                                      controller:
                                                          appointmentsVertController,
                                                      slivers: [
                                                        SliverList(
                                                            delegate:
                                                                SliverChildListDelegate(
                                                          [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children:
                                                                  List.generate(
                                                                listResources
                                                                    .length,
                                                                (columnIndex) {
                                                                  appointmentIndex =
                                                                      0;

                                                                  ///resource Текущий ряд
                                                                  ObjectToBook?
                                                                      resource =
                                                                      listResources[
                                                                          columnIndex];

                                                                  ///allResourcesDates Список дат для каждого ряда
                                                                  List<List<DateTime>>
                                                                      allResourcesDates =
                                                                      [];

                                                                  ///allResourcesTimes Список дат для каждого ряда
                                                                  List<List<int>>
                                                                      allResourcesTimes =
                                                                      [];
                                                                  if (isCalendarDayView ==
                                                                      true) {
                                                                    allResourcesDates = List.filled(
                                                                        (listResources.isNotEmpty
                                                                            ? listResources.length
                                                                            : 0),
                                                                        [
                                                                          ..._visibleDates
                                                                        ]);
                                                                  } else {
                                                                    allResourcesTimes = List.filled(
                                                                        (listResources.isNotEmpty
                                                                            ? listResources.length
                                                                            : 0),
                                                                        [
                                                                          ...visibleTimes
                                                                        ]);
                                                                  }

                                                                  ///currentResourceDates Даты для текущего ряда
                                                                  List<DateTime>
                                                                      currentResourceDates =
                                                                      [];

                                                                  ///currentResourceTimes Время для текущего ряда
                                                                  List<int>
                                                                      currentResourceTimes =
                                                                      [];
                                                                  if (isCalendarDayView ==
                                                                      true) {
                                                                    currentResourceDates =
                                                                        allResourcesDates[
                                                                            columnIndex];
                                                                  } else {
                                                                    currentResourceTimes =
                                                                        allResourcesTimes[
                                                                            columnIndex];
                                                                  }

                                                                  ///currentResourceApointments Записи гостей у текущего ряда
                                                                  List<GuestModel>
                                                                      currentResourceApointments =
                                                                      [];

                                                                  ///Добавляем записи гостей в список
                                                                  currentResourceApointments.addAll(
                                                                      listAppointment
                                                                          .where(
                                                                              (a) {
                                                                    if (isCalendarDayView ==
                                                                        true) {
                                                                      return a.resourceId ==
                                                                          resource
                                                                              .id;
                                                                    } else {
                                                                      final diffDates = getDatesAfterStartDateBeforeEnd(
                                                                          a.startDate!
                                                                              .subtract(const Duration(days: 1)),
                                                                          a.endDate!);

                                                                      final selectedDateContainsInStartEnd = diffDates.contains(DateTime(
                                                                          selectedDay
                                                                              .value
                                                                              .year,
                                                                          selectedDay
                                                                              .value
                                                                              .month,
                                                                          selectedDay
                                                                              .value
                                                                              .day));
                                                                      return selectedDateContainsInStartEnd &&
                                                                          a.resourceId ==
                                                                              resource.id;
                                                                    }
                                                                  }));

                                                                  ///Сортируем по дате
                                                                  if (currentResourceApointments
                                                                          .length >
                                                                      1) {
                                                                    currentResourceApointments.sort((a, b) => a
                                                                        .startDate!
                                                                        .compareTo(
                                                                            b.startDate!));
                                                                  }

                                                                  print(currentResourceApointments
                                                                      .length);

                                                                  if (isCalendarDayView ==
                                                                      true) {
                                                                    ///Делаем цикл для получения индекса дат для текущего ряда
                                                                    for (int i =
                                                                            0;
                                                                        i < currentResourceDates.length;
                                                                        i++) {
                                                                      // ///Помечаем пустым чтобы они не складывались
                                                                      startEndDiffDates =
                                                                          [];
                                                                      visibleDate =
                                                                          currentResourceDates[
                                                                              i];

                                                                      ///Если записи гостей в текущем ряду не пусты
                                                                      if (currentResourceApointments
                                                                          .isNotEmpty) {
                                                                        ///Делаем цикл для получения записи гостя
                                                                        for (var appointment
                                                                            in currentResourceApointments) {
                                                                          ///Если дата заезда гостя и текущая дата совпадают
                                                                          if (isSameDate(appointment.startDate, visibleDate) &&
                                                                              appointment.isSaved != true) {
                                                                            startEndDiffDates = currentResourceApointments.isEmpty
                                                                                ? []
                                                                                : getDatesAfterStartDateBeforeEnd(
                                                                                    appointment.startDate!,
                                                                                    appointment.endDate!,
                                                                                  );

                                                                            ///Если даты после дня заезда до дня выезда не пусты
                                                                            if (startEndDiffDates.isNotEmpty) {
                                                                              ///Если в списке дат после дня заезда до дня выезда
                                                                              ///содержутся даты для отображения в текущем ряду
                                                                              currentResourceDates.removeWhere((e) {
                                                                                if (startEndDiffDates.contains(e)) {
                                                                                  return true;
                                                                                }
                                                                                return false;
                                                                              });
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  } else {
                                                                    ///Делаем цикл для получения индекса час для текущего ряда
                                                                    for (int i =
                                                                            0;
                                                                        i < currentResourceTimes.length;
                                                                        i++) {
                                                                      ///Помечаем пустым чтобы они не складывались
                                                                      startEndDiffTimes =
                                                                          [];
                                                                      visibleTime =
                                                                          currentResourceTimes[
                                                                              i];

                                                                      ///Если записи гостей в текущем ряду не пусты
                                                                      if (currentResourceApointments
                                                                          .isNotEmpty) {
                                                                        ///Делаем цикл для получения записи гостя
                                                                        for (var appointment
                                                                            in currentResourceApointments) {
                                                                          final isStartSelectedDatesSame =
                                                                              isSameDate(appointment.startDate!, selectedDay.value) && appointment.isSaved != true;

                                                                          ///Если выбранная дата есть в списке дат между датой заезда и выезда
                                                                          final appointmentStartEndDiff = getDatesAfterStartDateBeforeEnd(
                                                                              appointment.startDate!,
                                                                              appointment.endDate!);
                                                                          final isStartEndDatesSame = isSameDate(appointment.startDate!, appointment.endDate!) &&
                                                                              isStartSelectedDatesSame == true &&
                                                                              appointment.isSaved != true;

                                                                          final isEndSelectedDatesSame =
                                                                              isSameDate(appointment.endDate!, selectedDay.value) && appointment.isSaved != true;
                                                                          final isSelectedDateContainsInStartEnd =
                                                                              appointmentStartEndDiff.contains(DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day)) && appointment.isSaved != true;
                                                                          if (isStartEndDatesSame) {
                                                                            ///Если дата заезда гостя и текущая дата совпадают
                                                                            startEndDiffTimes =
                                                                                getDateHours(
                                                                              appointment.startDate!,
                                                                              appointment.endDate!,
                                                                            );

                                                                            ///Если даты после дня заезда до дня выезда не пусты
                                                                            if (startEndDiffTimes.isNotEmpty) {
                                                                              ///Если в списке дат после дня заезда до дня выезда
                                                                              ///содержутся даты для отображения в текущем ряду
                                                                              currentResourceTimes.removeWhere((a) {
                                                                                return startEndDiffTimes.any((b) {
                                                                                  if (a == b.hour && selectedDay.value.day == b.day) {
                                                                                    return true;
                                                                                  }
                                                                                  return false;
                                                                                });
                                                                              });
                                                                            }
                                                                          } else if (isStartSelectedDatesSame) {
                                                                            if (appointment.startDate?.hour ==
                                                                                visibleTime) {
                                                                              startEndDiffTimes = getDateHours(
                                                                                // isEndSelectedDatesSame && !isStartEndDatesSame ? DateTime(apointment.endDate!.year, apointment.endDate!.month, apointment.endDate!.day, 23).subtract(const Duration(days: 1)) :
                                                                                appointment.startDate!,
                                                                                // isEndSelectedDatesSame && !isStartEndDatesSame ? apointment.endDate! :
                                                                                DateTime(appointment.startDate!.year, appointment.startDate!.month, appointment.startDate!.day, 0).add(const Duration(days: 1)),
                                                                              );

                                                                              ///Если даты после дня заезда до дня выезда не пусты
                                                                              if (startEndDiffTimes.isNotEmpty) {
                                                                                ///Если в списке дат после дня заезда до дня выезда
                                                                                ///содержутся даты для отображения в текущем ряду
                                                                                currentResourceTimes.removeWhere((a) {
                                                                                  return startEndDiffTimes.any((b) {
                                                                                    if (a == b.hour && selectedDay.value.day == b.day) {
                                                                                      return true;
                                                                                    }
                                                                                    return false;
                                                                                  });
                                                                                });
                                                                              }
                                                                            }
                                                                          } else if (isEndSelectedDatesSame &&
                                                                              !isStartEndDatesSame) {
                                                                            startEndDiffTimes =
                                                                                getDateHours(
                                                                              DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 0),
                                                                              appointment.endDate!,
                                                                            );

                                                                            ///Если даты после дня заезда до дня выезда не пусты
                                                                            if (startEndDiffTimes.isNotEmpty) {
                                                                              ///Если в списке дат после дня заезда до дня выезда
                                                                              ///содержутся даты для отображения в текущем ряду
                                                                              currentResourceTimes.removeWhere((a) {
                                                                                return startEndDiffTimes.any((b) {
                                                                                  if (a != 0 && a == b.hour && selectedDay.value.day == b.day) {
                                                                                    return true;
                                                                                  }
                                                                                  return false;
                                                                                });
                                                                              });
                                                                            }
                                                                            print(currentResourceTimes.length);
                                                                          } else if (isSelectedDateContainsInStartEnd) {
                                                                            if (appointment.startDate?.hour ==
                                                                                visibleTime) {
                                                                              startEndDiffTimes = getDateHours(
                                                                                DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 1),
                                                                                DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 23),
                                                                              );

                                                                              ///Если даты после дня заезда до дня выезда не пусты
                                                                              if (startEndDiffTimes.isNotEmpty) {
                                                                                currentResourceTimes.removeRange(1, currentResourceTimes.length);
                                                                                print(currentResourceTimes.length);
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }

                                                                  return Container(
                                                                    height: 92,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            3),
                                                                    decoration: const BoxDecoration(
                                                                        color: AppColors
                                                                            .colorWhite,
                                                                        border:
                                                                            bottomBorder),
                                                                    child: Row(
                                                                        children: List.generate(
                                                                            math.max(0,
                                                                                (isCalendarDayView == true ? currentResourceDates.length : currentResourceTimes.length) * 2 - 1),
                                                                            (index) {
                                                                      final itemIndex =
                                                                          index ~/
                                                                              2;
                                                                      if (index
                                                                          .isEven) {
                                                                        int reducedAppointmentIndex =
                                                                            0;

                                                                        ///isSameStartVisibleDate true ЕСЛИ ДАТА ЗАЕЗДА ГОСТЯ И ДАТА НА ЗАДНЕМ ФОНЕ РАВНЫ
                                                                        bool
                                                                            isSameStartVisibleDate =
                                                                            false;

                                                                        ///isStartSelectedDatesSame проверка если дата заезда и выбранная дата равны
                                                                        bool
                                                                            isStartSelectedDatesSame =
                                                                            false;

                                                                        ///isStartEndDatesSame проверка если дата заезда и выезда равны
                                                                        bool
                                                                            isStartEndDatesSame =
                                                                            false;

                                                                        ///isEndSelectedDatesSame проверка если дата выезда и выбранная дата равны
                                                                        bool
                                                                            isEndSelectedDatesSame =
                                                                            false;
                                                                        bool
                                                                            isSelectedDateContainsInStartEnd =
                                                                            false;
                                                                        BookedGuesEntryViewEnum?
                                                                            bookedGuesEntryView =
                                                                            BookedGuesEntryViewEnum.none;

                                                                        if (isCalendarDayView ==
                                                                            true) {
                                                                          visibleDate =
                                                                              currentResourceDates[itemIndex];

                                                                          if (currentResourceApointments.isNotEmpty &&
                                                                              appointmentIndex < currentResourceApointments.length) {
                                                                            startDate =
                                                                                currentResourceApointments[appointmentIndex].startDate!;

                                                                            if (isSameDate(currentResourceApointments[appointmentIndex].startDate, visibleDate) == true &&
                                                                                appointmentIndex < currentResourceApointments.length) {
                                                                              appointmentIndex++;
                                                                            }
                                                                            reducedAppointmentIndex = appointmentIndex == 0
                                                                                ? appointmentIndex
                                                                                : appointmentIndex - 1;
                                                                            startEndDiffDates =
                                                                                getDatesAfterStartDateBeforeEnd(
                                                                              currentResourceApointments[reducedAppointmentIndex].startDate!,
                                                                              currentResourceApointments[reducedAppointmentIndex].endDate!,
                                                                            );
                                                                            if (isSameDate(currentResourceApointments[reducedAppointmentIndex].startDate, visibleDate) ==
                                                                                true) {
                                                                              bookedGuesEntryView = BookedGuesEntryViewEnum.startEnd;
                                                                            } else {
                                                                              bookedGuesEntryView = BookedGuesEntryViewEnum.date;
                                                                            }
                                                                          } else {
                                                                            bookedGuesEntryView =
                                                                                BookedGuesEntryViewEnum.date;
                                                                          }
                                                                        } else {
                                                                          visibleTime =
                                                                              currentResourceTimes[itemIndex];

                                                                          if (currentResourceApointments
                                                                              .isNotEmpty) {
                                                                            for (var appointment
                                                                                in currentResourceApointments) {
//  isSameStartVisibleDate =
                                                                              isStartSelectedDatesSame = isSameDate(appointment.startDate!, selectedDay.value) && appointment.isSaved != true;

                                                                              ///Если выбранная дата есть в списке дат между датой заезда и выезда
                                                                              final appointmentStartEndDiff = getDatesAfterStartDateBeforeEnd(appointment.startDate!, appointment.endDate!);
                                                                              isSelectedDateContainsInStartEnd = appointmentStartEndDiff.contains(DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day)) && appointment.isSaved != true;
                                                                              isStartEndDatesSame = isSameDate(appointment.startDate!, appointment.endDate!) && isStartSelectedDatesSame == true && appointment.isSaved != true;

                                                                              isEndSelectedDatesSame = isSameDate(appointment.endDate!, selectedDay.value) && appointment.isSaved != true;
                                                                              if (isStartEndDatesSame && appointment.startDate?.hour == visibleTime && bookedGuesEntryView == BookedGuesEntryViewEnum.none) {
                                                                                ///Если дата заезда гостя и текущая дата совпадают
                                                                                startEndDiffTimes = getDateHours(
                                                                                  appointment.startDate!,
                                                                                  appointment.endDate!,
                                                                                );
                                                                                bookedGuesEntryView = BookedGuesEntryViewEnum.startEnd;
                                                                              } else if (isStartSelectedDatesSame && !isEndSelectedDatesSame && bookedGuesEntryView == BookedGuesEntryViewEnum.none && appointment.startDate?.hour == visibleTime) {
                                                                                startEndDiffTimes = getDateHours(appointment.startDate!, DateTime(appointment.startDate!.year, appointment.startDate!.month, appointment.startDate!.day + 2, 0));
                                                                                bookedGuesEntryView = BookedGuesEntryViewEnum.start;
                                                                              } else if (isEndSelectedDatesSame && !isStartEndDatesSame && visibleTime == 0 && bookedGuesEntryView == BookedGuesEntryViewEnum.none) {
                                                                                startEndDiffTimes = getDateHours(DateTime(appointment.endDate!.year, appointment.endDate!.month, appointment.endDate!.day, 23).subtract(const Duration(days: 1)), appointment.endDate!);
                                                                                bookedGuesEntryView = BookedGuesEntryViewEnum.end;
                                                                                // }
                                                                              } else if (isSelectedDateContainsInStartEnd && !isStartSelectedDatesSame && !isEndSelectedDatesSame && bookedGuesEntryView == BookedGuesEntryViewEnum.none) {
                                                                                startEndDiffTimes = getDateHours(
                                                                                  DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 0),
                                                                                  DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 23),
                                                                                );

                                                                                ///Если даты после дня заезда до дня выезда не пусты
                                                                                if (startEndDiffTimes.isNotEmpty) {
                                                                                  bookedGuesEntryView = BookedGuesEntryViewEnum.center;
                                                                                }
                                                                              } else {
                                                                                bookedGuesEntryView = BookedGuesEntryViewEnum.date;
                                                                              }
                                                                            }
                                                                          } else {
                                                                            bookedGuesEntryView =
                                                                                BookedGuesEntryViewEnum.date;
                                                                          }
                                                                        }

                                                                        if (bookedGuesEntryView ==
                                                                            BookedGuesEntryViewEnum
                                                                                .date) {
                                                                          if (isCalendarDayView ==
                                                                              false) {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                context.pushNamed('guest_info', extra: {
                                                                                  'is_register_guest': true
                                                                                });
                                                                              },
                                                                              child: TimeViewCard(
                                                                                bgColor: AppColors.colorLightGray,
                                                                                hour: "$visibleTime:00",
                                                                                textColor: AppColors.colorGray,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                context.pushNamed('guest_info', extra: {
                                                                                  'is_register_guest': true
                                                                                });
                                                                              },
                                                                              child: DateViewCard(
                                                                                bgColor: AppColors.colorLightGray,
                                                                                day: visibleDate!.day.toString(),
                                                                                textColor: AppColors.colorGray,
                                                                                weekDay: shortWeekDays[visibleDate!.weekday - 1],
                                                                              ),
                                                                            );
                                                                          }
                                                                        } else if (bookedGuesEntryView ==
                                                                            BookedGuesEntryViewEnum.end) {
                                                                          // bookedGuesEntryView =
                                                                          //     null;
                                                                          // isAppointmentEnd =
                                                                          //     null;
                                                                          // bool
                                                                          //     isSelectedDayAfter =
                                                                          // selectedDay.value.add(const Duration(days: 1)).isAfter(selectedDay.value);
                                                                          // bool isContinue = isCalendarDayView == true
                                                                          //     ? (startEndDiffDates.isNotEmpty ? startEndDiffDates.last.isAfter(_visibleDates.last) : false)
                                                                          //     : (startEndDiffTimes.isNotEmpty ? DateTime(startEndDiffTimes.last.year, startEndDiffTimes.last.month, startEndDiffTimes.last.day).isAfter(selectedDay.value) : false);
                                                                          // final diffLastTime = startEndDiffTimes.isNotEmpty
                                                                          //     ? startEndDiffTimes.last
                                                                          //     : null;
                                                                          bool isBefore = isCalendarDayView == true
                                                                              ? (startEndDiffDates.isNotEmpty ? startEndDiffDates.last.isAfter(_visibleDates.last) : false)
                                                                              : isEndSelectedDatesSame
                                                                                  ? true
                                                                                  : false;
                                                                          // (startEndDiffTimes.isNotEmpty ? DateTime(diffLastTime!.year, diffLastTime.month, diffLastTime.day).subtract(const Duration(days: 1)).isBefore(selectedDay.value) : false);
                                                                          double
                                                                              getAppointmentWidth() {
                                                                            List<DateTime> _startEndDiff = isCalendarDayView == true
                                                                                ? startEndDiffDates
                                                                                : startEndDiffTimes;

                                                                            double
                                                                                width =
                                                                                appointmentSize;

                                                                            width = width + (_startEndDiff.isNotEmpty ? (appointmentSize * (_startEndDiff.length - 1)) + (_startEndDiff.length - 1) * 6 : 0)
                                                                                // -
                                                                                // (isContinue == true ? (diffDatesAfterLastDate.length * 46) + (diffDatesAfterLastDate.length * 6) : 0)
                                                                                ;
                                                                            return width;
                                                                          }

                                                                          return SizedBox(
                                                                            width:
                                                                                getAppointmentWidth(),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                context.pushNamed('guest_info', extra: {
                                                                                  'info':
                                                                                      //  currentResourceApointments.isEmpty ? lastAppointment :
                                                                                      currentResourceApointments[reducedAppointmentIndex].toMap()
                                                                                });
                                                                              },
                                                                              child: AppointmentViewCard(
                                                                                borderRadius: allCircularRadius12.copyWith(bottomLeft: Radius.circular(isBefore ? 0 : 12), topLeft: Radius.circular(isBefore ? 0 : 12)),
                                                                                appointment:
                                                                                    //  currentResourceApointments.isEmpty ? lastAppointment! :
                                                                                    currentResourceApointments[reducedAppointmentIndex],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        } else
                                                                        // if (bookedGuesEntryView == BookedGuesEntryViewEnum.start ||
                                                                        //     bookedGuesEntryView ==
                                                                        //         BookedGuesEntryViewEnum.center)
                                                                        {
                                                                          if (currentResourceApointments.isNotEmpty &&
                                                                              currentResourceApointments[reducedAppointmentIndex].isSaved == true) {
                                                                            return const SavedGuestCard();
                                                                          } else {
                                                                            bool
                                                                                isBefore =
                                                                                false;
                                                                            // isCalendarDayView == true
                                                                            //   ? (startEndDiffDates.isNotEmpty ? startEndDiffDates.last.isAfter(_visibleDates.last) : false)
                                                                            //   :
                                                                            if (isCalendarDayView ==
                                                                                true) {
                                                                              isBefore = (startEndDiffDates.isNotEmpty ? startEndDiffDates.first.subtract(const Duration(days: 1)).isBefore(_visibleDates.first) : false);
                                                                            } else {
                                                                              isBefore = bookedGuesEntryView == BookedGuesEntryViewEnum.center ? true : false;
                                                                            }
                                                                            bool
                                                                                isContinue =
                                                                                false;
                                                                            if (isCalendarDayView ==
                                                                                true) {
                                                                              isContinue = (startEndDiffDates.isNotEmpty ? startEndDiffDates.last.isAfter(_visibleDates.last) : false);
                                                                            } else {
                                                                              if (bookedGuesEntryView == BookedGuesEntryViewEnum.start) {
                                                                                isContinue = DateTime(startEndDiffTimes.last.year, startEndDiffTimes.last.month, startEndDiffTimes.last.day)
                                                                                    // .add(const Duration(days: 1))
                                                                                    .isAfter(selectedDay.value);
                                                                                // (startEndDiffTimes.isNotEmpty ? startEndDiffTimes.last.isAfter(_visibleDates.last) : false);
                                                                              } else if (bookedGuesEntryView == BookedGuesEntryViewEnum.center) {
                                                                                isContinue = true;
                                                                              }
                                                                            }

                                                                            // (startEndDiffTimes.isNotEmpty
                                                                            //     ? isSameDate(diffLastTime, selectedDay.value)
                                                                            //         ? false
                                                                            //         : DateTime(diffLastTime!.year, diffLastTime.month, diffLastTime.day).add(const Duration(days: 1)).isAfter(selectedDay.value)
                                                                            //     : false);
                                                                            double
                                                                                getAppointmentWidth() {
                                                                              List<DateTime> _startEndDiff = isCalendarDayView == true ? startEndDiffDates : startEndDiffTimes;
                                                                              final diffDatesAfterLastDate = _startEndDiff.where((e) {
                                                                                if (isCalendarDayView == true) {
                                                                                  return e.isAfter(_visibleDates.last);
                                                                                } else {
                                                                                  return e.isAfter(selectedDay.value.add(const Duration(hours: 24)));
                                                                                }
                                                                              });
                                                                              double width = appointmentSize;

                                                                              width = width + (_startEndDiff.isNotEmpty ? (appointmentSize * _startEndDiff.length) + (_startEndDiff.length) * 6 : 0) - (isContinue == true ? (diffDatesAfterLastDate.length * 46) + (diffDatesAfterLastDate.length * 6) : 0);
                                                                              return width;
                                                                            }

                                                                            // bookedGuesEntryView =
                                                                            //     null;

                                                                            return SizedBox(
                                                                              width: getAppointmentWidth(),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  context.pushNamed('guest_info', extra: {
                                                                                    'info': currentResourceApointments[reducedAppointmentIndex].toMap()
                                                                                  });
                                                                                },
                                                                                child: AppointmentViewCard(
                                                                                  borderRadius: allCircularRadius12.copyWith(bottomLeft: Radius.circular(isBefore ? 0 : 12), topLeft: Radius.circular(isBefore ? 0 : 12), bottomRight: Radius.circular(isContinue ? 0 : 12), topRight: Radius.circular(isContinue ? 0 : 12)),
                                                                                  appointment: currentResourceApointments[reducedAppointmentIndex],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        }
                                                                      }
                                                                      return kSBW6;
                                                                    })),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 82)
                                                          ],
                                                        ))
                                                      ]),
                                                ),
                                              ),
                                            ),
                                            onNotification: (ScrollNotification
                                                scrollInfo) {
                                              _syncScroller?.processNotification(
                                                  scrollInfo,
                                                  appointmentsVertController);
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
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification:
                                  (OverscrollIndicatorNotification overscroll) {
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
                                                (index) => SplashButton(
                                                      onTap: () {
                                                        context.pushNamed(
                                                            'booking_object',
                                                            extra: {
                                                              'info':
                                                                  listResources[
                                                                          index]
                                                                      .toMap()
                                                            });
                                                      },
                                                      child: ResourceViewCard(
                                                          resource:
                                                              listResources[
                                                                  index]),
                                                    )),
                                          ),
                                          SplashButton(
                                            onTap: () {
                                              context.pushNamed(
                                                  'booking_object',
                                                  extra: {
                                                    'is_new_object': true
                                                  });
                                            },
                                            child: SizedBox(
                                                height: 82,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    height: 14,
                                                    AppImages.plus,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            AppColors
                                                                .colorDarkGray,
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
                                        strokeAlign:
                                            BorderSide.strokeAlignInside))),
                            child: SplashButton(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          insetPadding: kPAll20,
                                          backgroundColor: AppColors.colorWhite,
                                          surfaceTintColor:
                                              AppColors.colorWhite,
                                          child: CustomCalendarDialog(
                                            firstDate: DateTime(1900),
                                            initialDate: selectedDay.value,
                                            //  widget.guestM,
                                            lastDate: DateTime(now.year + 10),
                                            onDateChanged: (value) {
                                              // startDate.text = DateFormat("dd.MM.y").format(value);
                                              // initStartSelectedDate

                                              selectedDay.value = value;
                                              widget.calendarViewEnum.value =
                                                  CalendarViewEnum.hour;
                                              setState(() {});

                                              // startDate.text = value.toIso8601String();
                                              //  /,
                                            },
                                          ),
                                        ));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(AppImages.calendar),
                                    kSBH6,
                                    Text(
                                      "${middleMonth[selectedDay.value.month - 1]}. ${selectedDay.value.year}",
                                      style: AppTextStyle.w500s12.copyWith(
                                          color: AppColors.colorDarkGray),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }));
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
