// import 'package:flutter/cupertino.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/appointment_engine/appointment_helper.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/appointment_engine/calendar_datasource.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/common/calendar_controller.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/common/calendar_view_helper.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/common/date_time_engine.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/common/enums.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/common/event_args.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/resource_view/calendar_resource.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/resource_view/resource_view.dart';
// import 'package:qaz_booking_ui/calendar/src/calendar/views/calendar_view.dart';
// import 'package:syncfusion_flutter_core/core.dart';

// class CustomCalendar extends StatefulWidget {
//   const CustomCalendar({super.key, this.dataSource});
//   final CalendarDataSource? dataSource;
//   @override
//   State<CustomCalendar> createState() => CustomCalendarState();
// }

// class CustomCalendarState extends State<CustomCalendar>
//     with TickerProviderStateMixin {
//   late double _minWidth, _minHeight;
//   Animation<double>? _fadeIn;
//   final ValueNotifier<double> _opacity = ValueNotifier<double>(1);
//   late double _agendaDateViewWidth;
//   ScrollController? _agendaScrollController, _resourcePanelScrollController;
//   AnimationController? _fadeInController;
//   List<CalendarResource>? _resourceCollection;
//   late bool _timeZoneLoaded = false;
//   late DateTime _currentDate;
//   bool _isLoadMoreLoaded = false;
//   bool _isNeedLoadMore = false;
//   bool _isScheduleStartLoadMore = false;
//   List<CalendarAppointment> _appointments = <CalendarAppointment>[];
//   late CalendarController _controller;
//   // late ValueNotifier<Offset?> _headerHoverNotifier, _resourceHoverNotifier;
//   // late ValueNotifier<ScheduleViewHoveringDetails?> _agendaDateNotifier,
//   // _agendaViewNotifier;
//   List<CalendarAppointment> _visibleAppointments = <CalendarAppointment>[];
//   late CalendarView _view;
//   final GlobalKey _customScrollViewKey = GlobalKey();

//   @override
//   void initState() {
//     // _textScaleFactor = 1;
//     _timeZoneLoaded = false;
//     // _showHeader = false;
//     // _calendarViewWidth = 0;
//     // initializeDateFormatting();
//     // _loadDataBase().then((bool value) => _getAppointment());
//     // _agendaDateNotifier = ValueNotifier<ScheduleViewHoveringDetails?>(null);
//     // _agendaViewNotifier = ValueNotifier<ScheduleViewHoveringDetails?>(null);
//     // _resourceImageNotifier = ValueNotifier<bool>(false);
//     // _headerHoverNotifier = ValueNotifier<Offset?>(null)
//     //   ..addListener(_updateViewHeaderHover);
//     // _resourceHoverNotifier = ValueNotifier<Offset?>(null)
//     //   ..addListener(_updateViewHeaderHover);
//     _controller = CalendarController();
//     _controller.getCalendarDetailsAtOffset = _getCalendarDetails;
//     // _controller.selectedDate ??= widget.initialSelectedDate;
//     // _selectedDate = _controller.selectedDate;
//     // _agendaSelectedDate = ValueNotifier<DateTime?>(_selectedDate);
//     // _agendaSelectedDate.addListener(_agendaSelectedDateListener);
//     _currentDate = DateTimeHelper.getDateTimeValue(getValidDate(
//       DateTime(01),
//       DateTime(9999, 12, 31),
//       _controller.displayDate ??
//           DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day, 08, 45),
//     ));
//     _controller.displayDate = _currentDate;
//     // _scheduleDisplayDate = _controller.displayDate!;
//     _controller.view ??= CalendarView.timelineMonth;
//     _view = _controller.view!;
//     // _timelineMonthWeekNumberNotifier =
//     //     ValueNotifier<DateTime?>(_controller.displayDate);
//     // if (_selectedDate != null) {
//     //   _updateSelectionChangedCallback();
//     // }
//     // _updateCurrentVisibleDates();
//     widget.dataSource?.addListener(_dataSourceChangedListener);
//     _resourceCollection =
//         CalendarViewHelperV2.cloneList(widget.dataSource?.resources);
//     // if (_view == CalendarView.month && widget.monthViewSettings.showAgenda) {
//     //   _agendaScrollController = ScrollController();
//     // }

//     if (CalendarViewHelperV2.isResourceEnabled(widget.dataSource, _view)) {
//       _resourcePanelScrollController = ScrollController();
//     }

//     // _controller.addPropertyChangedListener(_calendarValueChangedListener);
//     // if (_view == CalendarView.schedule &&
//     //     CalendarViewHelper.shouldRaiseViewChangedCallback(
//     //         widget.onViewChanged)) {
//     //   CalendarViewHelper.raiseViewChangedCallback(
//     //       widget, <DateTime>[_controller.displayDate!]);
//     // }

//     // _initScheduleViewProperties();
//     // _blackoutDates = CalendarViewHelperV2.cloneList(widget.blackoutDates);
//     // _viewChangeNotifier = ValueNotifier<bool>(false)
//     //   ..addListener(_updateViewChangePopup);

//     _isLoadMoreLoaded = false;
//     super.initState();
//   }

//   CalendarDetails? _getCalendarDetails(Offset position) {
//     final Offset updatedPosition = Offset(position.dx, position.dy
//         // - widget.headerHeight
//         );

//     final bool isResourceEnabled =
//         CalendarViewHelperV2.isResourceEnabled(widget.dataSource, _view);
//     final double resourceViewSize =
//         // isResourceEnabled ? widget.resourceViewSettings.size :
//         0;
//     if ((updatedPosition.dx < resourceViewSize) ||
//         (updatedPosition.dx > _minWidth - resourceViewSize)) {
//       final double viewHeaderHeight =
//           CalendarViewHelperV2.getViewHeaderHeight(82, _view);
//       final double timeLabelSize = 46;
//       //  CalendarViewHelperV2.getTimeLabelWidth(
//       // widget.timeSlotViewSettings.timeRulerSize, _view);
//       final double top = viewHeaderHeight + timeLabelSize;
//       // Return null value when the position placed on empty space
//       // on view header above the resource view.
//       if (updatedPosition.dy < top) {
//         return null;
//       }
//       final double resourceItemHeight = 80
//           // CalendarViewHelperV2.getResourceItemHeight(
//           // resourceViewSize,
//           // _minHeight - top,
//           // widget.resourceViewSettings,
//           // _resourceCollection!.length)
//           ;

//       final CalendarResource resource =
//           _getTappedResource(updatedPosition.dy - top, resourceItemHeight);
//       final List<dynamic> resourceAppointments =
//           _getSelectedResourceAppointments(resource);

//       /// Return calendar details while the [getCalendarDetailsAtOffset]
//       /// position placed on resource header in timeline views.
//       return CalendarDetails(
//           resourceAppointments, null, CalendarElement.resourceHeader, resource);
//     }

//     return (_customScrollViewKey.currentWidget! as CustomCalendarScrollView)
//         .getCalendarDetails(Offset(
//             // _isRTL
//             //     ? updatedPosition.dx
//             // :
//             updatedPosition.dx - resourceViewSize,
//             updatedPosition.dy));

//     // case CalendarView.schedule:
//     //   return _getScheduleViewDetails(updatedPosition);
//     // }
//   }

//   List<dynamic> _getSelectedResourceAppointments(CalendarResource resource) {
//     final List<dynamic> selectedResourceAppointments = <dynamic>[];
//     // if (_visibleAppointments.isEmpty) {
//     //   return selectedResourceAppointments;
//     // }

//     for (int i = 0; i < _visibleAppointments.length; i++) {
//       final CalendarAppointment app = _visibleAppointments[i];
//       if (app.resourceIds != null &&
//           app.resourceIds!.isNotEmpty &&
//           app.resourceIds!.contains(resource.id)) {
//         selectedResourceAppointments.add(
//             CalendarViewHelperV2.getAppointmentDetail(app, widget.dataSource));
//       }
//     }

//     return selectedResourceAppointments;
//   }

//   CalendarResource _getTappedResource(
//       double tappedPosition, double resourceItemHeight) {
//     final int index =
//         (_resourcePanelScrollController!.offset + tappedPosition) ~/
//             resourceItemHeight;
//     return _resourceCollection![index];
//   }

//   void _updateFadeAnimation() {
//     if (!mounted) {
//       return;
//     }

//     _opacity.value = _fadeIn!.value;
//   }

//   void _dataSourceChangedListener(
//       CalendarDataSourceAction type, List<dynamic> data) {
//     if (!_timeZoneLoaded || !mounted) {
//       return;
//     }

//     final List<CalendarAppointment> visibleAppointmentCollection =
//         <CalendarAppointment>[];
//     //// Clone the visible appointments because if we add visible appointment directly then
//     //// calendar view visible appointment also updated so it does not perform to paint, So
//     //// clone the visible appointment and added newly added appointment and set the value.
//     for (int i = 0; i < _visibleAppointments.length; i++) {
//       visibleAppointmentCollection.add(_visibleAppointments[i]);
//     }

//     if (_isNeedLoadMore || _isScheduleStartLoadMore) {
//       SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
//         setState(() {
//           _isNeedLoadMore = false;
//           _isScheduleStartLoadMore = false;
//         });
//       });
//     }

//     // switch (type) {
//     //   case CalendarDataSourceAction.reset:
//     //     {
//     //       _getAppointment();
//     //       _removeScheduleViewAppointmentDates();
//     //       _loadScheduleViewAppointmentDates(_appointments);
//     //     }
//     //     break;
//     //   case CalendarDataSourceAction.add:
//     //     {
//     //       final List<CalendarAppointment> collection =
//     //           AppointmentHelper.generateCalendarAppointments(
//     //               widget.dataSource, widget.timeZone, data);
//     //       _loadScheduleViewAppointmentDates(collection);

//     //       // if (_view != CalendarView.schedule) {
//     //       //   final int visibleDatesCount = _currentViewVisibleDates.length;
//     //       //   DateTime viewStartDate = _currentViewVisibleDates[0];
//     //       //   DateTime viewEndDate =
//     //       //       _currentViewVisibleDates[visibleDatesCount - 1];
//     //       //   if (_view == CalendarView.month &&
//     //       //       !CalendarViewHelper.isLeadingAndTrailingDatesVisible(
//     //       //           widget.monthViewSettings.numberOfWeeksInView,
//     //       //           widget.monthViewSettings.showTrailingAndLeadingDates)) {
//     //       //     final DateTime currentMonthDate =
//     //       //         _currentViewVisibleDates[visibleDatesCount ~/ 2];
//     //       //     viewStartDate =
//     //       //         AppointmentHelper.getMonthStartDate(currentMonthDate);
//     //       //     viewEndDate = AppointmentHelper.getMonthEndDate(currentMonthDate);
//     //       //   }

//     //       //   visibleAppointmentCollection.addAll(
//     //       //       AppointmentHelper.getVisibleAppointments(
//     //       //           viewStartDate,
//     //       //           viewEndDate,
//     //       //           collection,
//     //       //           widget.timeZone,
//     //       //           _view == CalendarView.month ||
//     //       //               CalendarViewHelper.isTimelineView(_view)));
//     //       // }

//     //       for (int i = 0; i < collection.length; i++) {
//     //         _appointments.add(collection[i]);
//     //       }

//     //       _updateVisibleAppointmentCollection(visibleAppointmentCollection);
//     //     }
//     //     break;
//     //   case CalendarDataSourceAction.remove:
//     //     {
//     //       for (int i = 0; i < data.length; i++) {
//     //         final dynamic appointment = data[i];
//     //         for (int j = 0; j < _appointments.length; j++) {
//     //           if (_appointments[j].data == appointment) {
//     //             _appointments.removeAt(j);
//     //             j--;
//     //           }
//     //         }
//     //       }

//     //       _removeScheduleViewAppointmentDates();

//     //       for (int i = 0; i < data.length; i++) {
//     //         final dynamic appointment = data[i];
//     //         for (int j = 0; j < visibleAppointmentCollection.length; j++) {
//     //           if (visibleAppointmentCollection[j].data == appointment) {
//     //             visibleAppointmentCollection.removeAt(j);
//     //             j--;
//     //           }
//     //         }
//     //       }
//     //       _updateVisibleAppointmentCollection(visibleAppointmentCollection);
//     //     }
//     //     break;
//     //   case CalendarDataSourceAction.addResource:
//     //   case CalendarDataSourceAction.removeResource:
//     //   case CalendarDataSourceAction.resetResource:
//     //     {
//     //       if (data is! List<CalendarResource>) {
//     //         return;
//     //       }

//     //       final List<CalendarResource> resourceCollection = data;
//     //       if (resourceCollection.isNotEmpty) {
//     //         _disposeResourceImagePainter();
//     //         setState(() {
//     //           _resourceCollection =
//     //               CalendarViewHelperV2.cloneList(widget.dataSource?.resources);
//     //           /* To render the modified resource collection  */
//     //           if (CalendarViewHelperV2.isTimelineView(_view)) {
//     //             _isNeedLoadMore = true;
//     //           }
//     //         });
//     //       }
//     //     }
//     //     break;
//     // }
//   }

//   void _getAppointment() {
//     _appointments =
//         AppointmentHelper.generateCalendarAppointments(widget.dataSource, null);
//     _updateVisibleAppointments();
//   }

//   /// Updates the visible appointments for the calendar
//   // ignore: avoid_void_async
//   void _updateVisibleAppointments() async {
//     if (!_timeZoneLoaded) {
//       return;
//     }
//     // if (_view != CalendarView.schedule) {
//     //   final int visibleDatesCount = _currentViewVisibleDates.length;
//     //   DateTime viewStartDate = _currentViewVisibleDates[0];
//     //   DateTime viewEndDate = _currentViewVisibleDates[visibleDatesCount - 1];
//     //   if (_view == CalendarView.month &&
//     //       !CalendarViewHelper.isLeadingAndTrailingDatesVisible(
//     //           widget.monthViewSettings.numberOfWeeksInView,
//     //           widget.monthViewSettings.showTrailingAndLeadingDates)) {
//     //     final DateTime currentMonthDate =
//     //         _currentViewVisibleDates[visibleDatesCount ~/ 2];
//     //     viewStartDate = AppointmentHelper.getMonthStartDate(currentMonthDate);
//     //     viewEndDate = AppointmentHelper.getMonthEndDate(currentMonthDate);
//     //   }

//     //   final List<CalendarAppointment> tempVisibleAppointment =
//     //       // ignore: await_only_futures
//     //       await AppointmentHelper.getVisibleAppointments(
//     //           viewStartDate,
//     //           viewEndDate,
//     //           _appointments,
//     //           widget.timeZone,
//     //           _view == CalendarView.month ||
//     //               CalendarViewHelper.isTimelineView(_view));
//     //   if (CalendarViewHelper.isCollectionEqual(
//     //       _visibleAppointments, tempVisibleAppointment)) {
//     //     if (mounted) {
//     //       setState(() {
//     //         // Updates the calendar widget because it trigger to change the
//     //         // header view text.
//     //       });
//     //     }

//     //     return;
//     //   }

//     //   _visibleAppointments = tempVisibleAppointment;

//     //   /// Update all day appointment related implementation in calendar,
//     //   /// because time label view needs the top position.
//     //   _updateAllDayAppointment();
//     // }

//     //// mounted property in state return false when the state disposed,
//     //// restrict the async method set state after the state disposed.
//     if (mounted) {
//       setState(() {
//         /* Updates the visible appointment collection */
//       });
//     }
//   }

//   @override
//   void dispose() {
//     // if (_agendaScrollController != null) {
//     //   _agendaScrollController!.removeListener(_handleScheduleViewScrolled);
//     //   _agendaScrollController!.dispose();
//     //   _agendaScrollController = null;
//     // }

//     if (_resourcePanelScrollController != null) {
//       _resourcePanelScrollController!.dispose();
//       _resourcePanelScrollController = null;
//     }

//     // _headerHoverNotifier.removeListener(_updateViewHeaderHover);
//     // _agendaDateNotifier.removeListener(_agendaSelectedDateListener);
//     // _resourceHoverNotifier.removeListener(_updateViewHeaderHover);

//     // _disposeResourceImagePainter();

//     if (widget.dataSource != null) {
//       widget.dataSource!.removeListener(_dataSourceChangedListener);
//     }

//     if (_fadeInController != null) {
//       _fadeInController!.removeListener(_updateFadeAnimation);
//       _fadeInController!.dispose();
//       _fadeInController = null;
//     }

//     if (_fadeIn != null) {
//       _fadeIn = null;
//     }

//     // _controller.removePropertyChangedListener(_calendarValueChangedListener);
//     // _viewChangeNotifier.removeListener(_updateViewChangePopup);
//     // _viewChangeNotifier.dispose();
//     // _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height;
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       _minWidth = constraints.maxWidth == double.infinity
//           ? _minWidth
//           : constraints.maxWidth;
//       _minHeight = constraints.maxHeight == double.infinity
//           ? _minHeight
//           : constraints.maxHeight;

//       // _isMobilePlatform =
//       //     CalendarViewHelperV2.isMobileLayout(Theme.of(context).platform);
//       // _useMobilePlatformUI =
//       //     CalendarViewHelperV2.isMobileLayoutUI(_minWidth, _isMobilePlatform);

//       _fadeInController ??= AnimationController(
//           duration: const Duration(milliseconds: 500), vsync: this)
//         ..addListener(_updateFadeAnimation);
//       _fadeIn ??= Tween<double>(
//         begin: 0.1,
//         end: 1,
//       ).animate(CurvedAnimation(
//         parent: _fadeInController!,
//         curve: Curves.easeIn,
//       ));

//       /// Check the schedule view changes from mobile view to web view or
//       /// web view to mobile view.
//       // if (_view == CalendarView.schedule &&
//       //     _actualWidth != null &&
//       //     _useMobilePlatformUI !=
//       //         CalendarViewHelper.isMobileLayoutUI(
//       //             _actualWidth!, _isMobilePlatform) &&
//       //     _nextDates.isNotEmpty) {
//       //   _agendaScrollController?.removeListener(_handleScheduleViewScrolled);
//       //   _initScheduleViewProperties();
//       // }

//       // _actualWidth = _minWidth;
//       height = _minHeight;

//       _agendaDateViewWidth = _minWidth * 0.15;

//       /// Restrict the maximum agenda date view width to 60 on web view.
//       // if (_agendaDateViewWidth > 60 && !_isMobilePlatform) {
//       //   _agendaDateViewWidth = 60;
//       // }

//       // height -= widget.headerHeight;
//       final double agendaHeight = 0;
//       // _view == CalendarView.month &&
//       // widget.monthViewSettings.showAgenda ? _getMonthAgendaHeight() : 0;

//       return GestureDetector(
//         child: SizedBox(
//           width: _minWidth,
//           height: _minHeight,
//           // color: widget.backgroundColor ?? _calendarTheme.backgroundColor,
//           child:
//               // _view == CalendarView.schedule
//               // ?
//               //  widget.loadMoreWidgetBuilder == null
//               // ? addAgenda(height, _isRTL)
//               // :
//               // addAgendaWithLoadMore(height, _isRTL)
//               // :
//               _addChildren(agendaHeight, height, _minWidth),
//         ),
//         // onTap: () {
//         //   _removeDatePicker();
//         // },
//       );
//     });
//   }

//   Widget _addChildren(
//     double agendaHeight,
//     double height,
//     double width,
//   ) {
//     // final bool isResourceEnabled =
//     //     CalendarViewHelperV2.isResourceEnabled(widget.dataSource, _view);
//     // final double resourceViewSize =
//     //     isResourceEnabled ? widget.resourceViewSettings.size : 0;
//     // final DateTime currentViewDate = _currentViewVisibleDates[
//     //     (_currentViewVisibleDates.length / 2).truncate()];

//     final List<Widget> children = <Widget>[
//       // Positioned(
//       //   top: 0,
//       //   right: 0,
//       //   left: 0,
//       //   height: widget.headerHeight,
//       //   child: Container(
//       //       color: widget.headerStyle.backgroundColor ??
//       //           _calendarTheme.headerBackgroundColor,
//       //       child: _CalendarHeaderView(
//       //           _currentViewVisibleDates,
//       //           widget.headerStyle,
//       //           currentViewDate,
//       //           _view,
//       //           widget.monthViewSettings.numberOfWeeksInView,
//       //           _calendarTheme,
//       //           isRTL,
//       //           _locale,
//       //           widget.showNavigationArrow,
//       //           _controller,
//       //           widget.maxDate,
//       //           widget.minDate,
//       //           width,
//       //           widget.headerHeight,
//       //           widget.timeSlotViewSettings.nonWorkingDays,
//       //           widget.monthViewSettings.navigationDirection,
//       //           widget.showDatePickerButton,
//       //           widget.showTodayButton,
//       //           _showHeader,
//       //           widget.allowedViews,
//       //           widget.allowViewNavigation,
//       //           _localizations,
//       //           _removeDatePicker,
//       //           _headerUpdateNotifier,
//       //           _viewChangeNotifier,
//       //           _handleOnTapForHeader,
//       //           _handleOnLongPressForHeader,
//       //           widget.todayHighlightColor,
//       //           _textScaleFactor,
//       //           _isMobilePlatform,
//       //           widget.headerDateFormat,
//       //           !_isNeedLoadMore,
//       //           widget.todayTextStyle,
//       //           widget.showWeekNumber,
//       //           widget.weekNumberStyle,
//       //           _timelineMonthWeekNumberNotifier,
//       //           widget.cellBorderColor,
//       //           widget.timeSlotViewSettings.numberOfDaysInView)),
//       // ),

//       _addResourcePanel(
//         // isResourceEnabled,
//         0,
//         height,
//       ),
//       // _addCustomScrollView(
//       //     // widget.headerHeight
//       //     0,
//       //     resourceViewSize,
//       //     isRTL,
//       //     isResourceEnabled,
//       //     width,
//       //     height,
//       //     agendaHeight),
//       // _addAgendaView(
//       //     agendaHeight,
//       //     // widget.headerHeight +
//       //     height - agendaHeight,
//       //     width,
//       //     isRTL),
//       // _addDatePicker(
//       //     0,
//       //     // widget.headerHeight
//       //     // ,
//       //     isRTL),
//       // _getCalendarViewPopup(),
//     ];
//     // if (_isNeedLoadMore && widget.loadMoreWidgetBuilder != null) {
//     //   children.add(Container(
//     //       color: Colors.transparent,
//     //       child: widget.loadMoreWidgetBuilder!(context, () async {
//     //         await loadMoreAppointments(_currentViewVisibleDates[0],
//     //             _currentViewVisibleDates[_currentViewVisibleDates.length - 1]);
//     //       })));
//     // }
//     return Stack(children: children);
//   }

//   Widget _addResourcePanel(
//       // bool isResourceEnabled,
//       double resourceViewSize,
//       double height) {
//     // if (!isResourceEnabled) {
//     //   return Positioned(
//     //     left: 0,
//     //     right: 0,
//     //     top: 0,
//     //     bottom: 0,
//     //     child: Container(),
//     //   );
//     // }

//     final double viewHeaderHeight = 82;
//     //  CalendarViewHelperV2.getViewHeaderHeight(
//     //     widget.viewHeaderHeight, _view);
//     final double timeLabelSize = 46;
//     //  CalendarViewHelperV2.getTimeLabelWidth(
//     //     widget.timeSlotViewSettings.timeRulerSize, _view);
//     final double top = viewHeaderHeight + timeLabelSize;
//     final double resourceItemHeight =
//         // CalendarViewHelperV2.getResourceItemHeight(
//         //     resourceViewSize,
//         //     height - top,
//         //     widget.resourceViewSettings,
//         //     _resourceCollection!.length)
//         46;
//     final double panelHeight = resourceItemHeight *
//         //  _resourceCollection?.length
//         // ??
//         2;

//     // final Widget verticalDivider = VerticalDivider(
//     //   width: 0.5,
//     //   thickness: 0.5,
//     //   color: widget.cellBorderColor ?? _calendarTheme.cellBorderColor,
//     // );

//     return Positioned(
//         left: 0,
//         width: resourceViewSize,
//         top: 0,
//         bottom: 0,
//         child: Stack(children: <Widget>[
//           // Positioned(
//           //   left: resourceViewSize - 0.5,
//           //   width: 0.5,
//           //   top:
//           //       // _controller.view == CalendarView.timelineMonth
//           //       //     ?
//           //       //  widget.headerHeight
//           //       0
//           //   // :
//           //   //  widget.headerHeight +
//           //   // viewHeaderHeight
//           //   ,
//           //   height:
//           //       // _controller.view == CalendarView.timelineMonth

//           //       // ?
//           //       viewHeaderHeight
//           //   // : timeLabelSize
//           //   ,
//           //   child: verticalDivider,
//           // ),
//           Positioned(
//             left: 0,
//             width: resourceViewSize,
//             top:
//                 // widget.headerHeight
//                 // +
//                 top,
//             bottom: 0,
//             child:
//                 // MouseRegion(
//                 //     onEnter: (PointerEnterEvent event) {
//                 //       _pointerEnterEvent(
//                 //           event,
//                 //           false,
//                 //           isRTL,
//                 //           null,
//                 //           top
//                 //           // + widget.headerHeight
//                 //           ,
//                 //           0,
//                 //           isResourceEnabled);
//                 //     },
//                 //     onExit: _pointerExitEvent,
//                 //     onHover: (PointerHoverEvent event) {
//                 //       _pointerHoverEvent(
//                 //           event,
//                 //           false,
//                 //           isRTL,
//                 //           null,
//                 //           top
//                 //           //  + widget.headerHeight
//                 //           ,
//                 //           0,
//                 //           isResourceEnabled);
//                 //     },
//                 //     child: GestureDetector(
//                 //       child:
//                 ScrollConfiguration(
//               behavior:
//                   ScrollConfiguration.of(context).copyWith(scrollbars: false),
//               child: ListView(
//                   padding: EdgeInsets.zero,
//                   physics: const ClampingScrollPhysics(),
//                   controller: _resourcePanelScrollController,
//                   children: <Widget>[
//                     // Text("ResourceViewWidget"),
//                     ResourceViewWidget(
//                         _resourceCollection,
//                         widget.resourceViewSettings,
//                         resourceItemHeight,
//                         widget.cellBorderColor,
//                         _calendarTheme,
//                         _themeData,
//                         _resourceImageNotifier,
//                         isRTL,
//                         _textScaleFactor,
//                         _resourceHoverNotifier.value,
//                         _imagePainterCollection,
//                         resourceViewSize,
//                         panelHeight,
//                         widget.resourceViewHeaderBuilder),
//                   ]),
//             ),
//             // onTapUp: (TapUpDetails details) {
//             //   _handleOnTapForResourcePanel(details, resourceItemHeight);
//             // },
//             // onLongPressStart: (LongPressStartDetails details) {
//             //   _handleOnLongPressForResourcePanel(
//             //       details, resourceItemHeight);
//             // },
//             // )))
//           )
//         ]));
//   }
// }
