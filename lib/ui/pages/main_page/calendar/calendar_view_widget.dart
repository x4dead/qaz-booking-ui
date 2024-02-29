import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/common/calendar_view_helper.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/common/enums.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/saved_guest_card.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/time_view_card.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_calendar_dialog.dart';
// import 'package:syncfusion_flutter_core/core.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/booked_guest_view_card.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/data/data.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/date_view_card.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/resource_view_card.dart';
// import 'package:qaz_booking_ui/ui/widgets/lib/src/calendar/common/date_time_engine.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class CalendarViewWidget extends StatefulWidget {
  const CalendarViewWidget({super.key, required this.calendarViewEnum});
  final ValueNotifier<CalendarViewEnum> calendarViewEnum;

  @override
  State<CalendarViewWidget> createState() => _CalendarViewWidgetState();
}

class _CalendarViewWidgetState extends State<CalendarViewWidget> {
  //_resourcesVertController Контроллер для скролла карточек объектов для бронирования по ВЕРТИКАЛИ
  late final ScrollController _resourcesVertController = ScrollController(),
      //bookedGuestsVertController Контроллер для скролла карточек записи гостей по ВЕРТИКАЛИ
      bookedGuestsVertController = ScrollController(),
      //bookedGuestsHorController Контроллер для скролла карточек записи гостей по ГОРИЗОНТАЛИ
      bookedGuestsHorController;

  ///Контроллер синхронного скролла
  SyncScrollController? _syncScroller = SyncScrollController([]);

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
    _previousViewVisibleDates =
        getMonthDates(year: previousMonth.year, month: previousMonth.month);
    _currentViewVisibleDates =
        getMonthDates(year: currentMonth.year, month: currentMonth.month);

    _nextViewVisibleDates =
        getMonthDates(year: nextMonth.year, month: nextMonth.month);
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
    bookedGuestsHorController = ScrollController(
        initialScrollOffset: todayDateIndex * (bookedGuestSize + 6));
    _syncScroller = SyncScrollController(
        [bookedGuestsVertController, _resourcesVertController]);
  }

  @override
  void dispose() {
    super.dispose();
    bookedGuestsHorController.dispose();
    bookedGuestsVertController.dispose();
    _resourcesVertController.dispose();
    _syncScroller?._scrollingController?.dispose();
  }

  ///bookedGuestIndex Индекс карточки записи гостя
  int bookedGuestIndex = 0;

  ///startEndDiffDates Даты после дня заезда до дня выезда
  List<DateTime> startEndDiffDates = [];

  ///startEndDiffTimes Время в часах после дня заезда до дня выезда
  List<DateTime> startEndDiffTimes = [];

  ///startDate Дата заезда гостя
  DateTime? startDate;

  ///visibleDate День из месяца для отображения
  DateTime? visibleDate;

  ///visibleTime Час из дня для отображения
  int? visibleTime;

  ValueNotifier<DateTime> selectedDay = ValueNotifier(DateTime.now());

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
                            scrollDirection: Axis.horizontal,
                            controller: bookedGuestsHorController,
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
                                                          bookedGuestsVertController,
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
                                                                  bookedGuestIndex =
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

                                                                  ///currentResourceBookedGuests Записи гостей у текущего ряда
                                                                  List<GuestModel>
                                                                      currentResourceBookedGuests =
                                                                      [];

                                                                  ///Добавляем записи гостей в список
                                                                  currentResourceBookedGuests.addAll(
                                                                      listBookedGuests
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
                                                                  if (currentResourceBookedGuests
                                                                          .length >
                                                                      1) {
                                                                    currentResourceBookedGuests.sort((a, b) => a
                                                                        .startDate!
                                                                        .compareTo(
                                                                            b.startDate!));
                                                                  }

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
                                                                      if (currentResourceBookedGuests
                                                                          .isNotEmpty) {
                                                                        ///Делаем цикл для получения записи гостя
                                                                        for (var bookedGuest
                                                                            in currentResourceBookedGuests) {
                                                                          ///Если дата заезда гостя и текущая дата совпадают
                                                                          if (isSameDate(bookedGuest.startDate, visibleDate) &&
                                                                              bookedGuest.isSaved != true) {
                                                                            startEndDiffDates = currentResourceBookedGuests.isEmpty
                                                                                ? []
                                                                                : getDatesAfterStartDateBeforeEnd(
                                                                                    bookedGuest.startDate!,
                                                                                    bookedGuest.endDate!,
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
                                                                      if (currentResourceBookedGuests
                                                                          .isNotEmpty) {
                                                                        ///Делаем цикл для получения записи гостя
                                                                        for (var bookedGuest
                                                                            in currentResourceBookedGuests) {
                                                                          final isStartSelectedDatesSame =
                                                                              isSameDate(bookedGuest.startDate!, selectedDay.value) && bookedGuest.isSaved != true;

                                                                          ///bookedGuestStartEndDiff Дни между датой заезда и выезда
                                                                          final bookedGuestStartEndDiff = getDatesAfterStartDateBeforeEnd(
                                                                              bookedGuest.startDate!,
                                                                              bookedGuest.endDate!);

                                                                          ///isStartEndDatesSame Дни у даты заезда и выезда равны, дата заезда равна выбранному дню и запись не сохранена
                                                                          final isStartEndDatesSame = isSameDate(bookedGuest.startDate!, bookedGuest.endDate!) &&
                                                                              isStartSelectedDatesSame == true &&
                                                                              bookedGuest.isSaved != true;

                                                                          ///isEndSelectedDatesSame Дата выезда и выбранная дата равны и запись не сохранена
                                                                          final isEndSelectedDatesSame =
                                                                              isSameDate(bookedGuest.endDate!, selectedDay.value) && bookedGuest.isSaved != true;

                                                                          ///isSelectedDateContainsInStartEnd Выбранная дата содержится в списке дат между днем заезда и выезда и запись не сохранена
                                                                          final isSelectedDateContainsInStartEnd =
                                                                              bookedGuestStartEndDiff.contains(DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day)) && bookedGuest.isSaved != true;
                                                                          if (isStartEndDatesSame) {
                                                                            ///Если дата заезда гостя и текущая дата совпадают
                                                                            startEndDiffTimes =
                                                                                getDateHours(
                                                                              bookedGuest.startDate!,
                                                                              bookedGuest.endDate!,
                                                                            );

                                                                            ///Если даты после дня заезда до дня выезда не пусты
                                                                            if (startEndDiffTimes.isNotEmpty) {
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
                                                                            if (bookedGuest.startDate?.hour ==
                                                                                visibleTime) {
                                                                              startEndDiffTimes = getDateHours(
                                                                                bookedGuest.startDate!,
                                                                                DateTime(bookedGuest.startDate!.year, bookedGuest.startDate!.month, bookedGuest.startDate!.day, 0).add(const Duration(days: 1)),
                                                                              );

                                                                              if (startEndDiffTimes.isNotEmpty) {
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
                                                                              bookedGuest.endDate!,
                                                                            );

                                                                            if (startEndDiffTimes.isNotEmpty) {
                                                                              currentResourceTimes.removeWhere((a) {
                                                                                return startEndDiffTimes.any((b) {
                                                                                  if (a != 0 && a == b.hour && selectedDay.value.day == b.day) {
                                                                                    return true;
                                                                                  }
                                                                                  return false;
                                                                                });
                                                                              });
                                                                            }
                                                                          } else if (isSelectedDateContainsInStartEnd) {
                                                                            if (bookedGuest.startDate?.hour ==
                                                                                visibleTime) {
                                                                              startEndDiffTimes = getDateHours(
                                                                                DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 1),
                                                                                DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 23),
                                                                              );

                                                                              if (startEndDiffTimes.isNotEmpty) {
                                                                                currentResourceTimes.removeRange(1, currentResourceTimes.length);
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
                                                                        int reducedBookedGuestIndex =
                                                                            0;

                                                                        ///isSameStartVisibleDate true ЕСЛИ ДАТА ЗАЕЗДА ГОСТЯ И ДАТА НА ЗАДНЕМ ФОНЕ РАВНЫ
                                                                        // bool
                                                                        //     isSameStartVisibleDate =
                                                                        //     false;

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
                                                                        BookedGuestEntryViewEnum?
                                                                            bookedGuesEntryView =
                                                                            BookedGuestEntryViewEnum.none;

                                                                        if (isCalendarDayView ==
                                                                            true) {
                                                                          visibleDate =
                                                                              currentResourceDates[itemIndex];

                                                                          if (currentResourceBookedGuests.isNotEmpty &&
                                                                              bookedGuestIndex < currentResourceBookedGuests.length) {
                                                                            startDate =
                                                                                currentResourceBookedGuests[bookedGuestIndex].startDate!;

                                                                            if (isSameDate(currentResourceBookedGuests[bookedGuestIndex].startDate, visibleDate) == true &&
                                                                                bookedGuestIndex < currentResourceBookedGuests.length) {
                                                                              bookedGuestIndex++;
                                                                            }
                                                                            reducedBookedGuestIndex = bookedGuestIndex == 0
                                                                                ? bookedGuestIndex
                                                                                : bookedGuestIndex - 1;
                                                                            startEndDiffDates =
                                                                                getDatesAfterStartDateBeforeEnd(
                                                                              currentResourceBookedGuests[reducedBookedGuestIndex].startDate!,
                                                                              currentResourceBookedGuests[reducedBookedGuestIndex].endDate!,
                                                                            );
                                                                            if (isSameDate(currentResourceBookedGuests[reducedBookedGuestIndex].startDate, visibleDate) ==
                                                                                true) {
                                                                              bookedGuesEntryView = BookedGuestEntryViewEnum.startEnd;
                                                                            } else {
                                                                              bookedGuesEntryView = BookedGuestEntryViewEnum.date;
                                                                            }
                                                                          } else {
                                                                            bookedGuesEntryView =
                                                                                BookedGuestEntryViewEnum.date;
                                                                          }
                                                                        } else {
                                                                          visibleTime =
                                                                              currentResourceTimes[itemIndex];

                                                                          if (currentResourceBookedGuests
                                                                              .isNotEmpty) {
                                                                            for (var bookedGuest
                                                                                in currentResourceBookedGuests) {
//  isSameStartVisibleDate =
                                                                              isStartSelectedDatesSame = isSameDate(bookedGuest.startDate!, selectedDay.value) && bookedGuest.isSaved != true;

                                                                              final bookedGuestStartEndDiff = getDatesAfterStartDateBeforeEnd(bookedGuest.startDate!, bookedGuest.endDate!);
                                                                              isSelectedDateContainsInStartEnd = bookedGuestStartEndDiff.contains(DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day)) && bookedGuest.isSaved != true;
                                                                              isStartEndDatesSame = isSameDate(bookedGuest.startDate!, bookedGuest.endDate!) && isStartSelectedDatesSame == true && bookedGuest.isSaved != true;

                                                                              isEndSelectedDatesSame = isSameDate(bookedGuest.endDate!, selectedDay.value) && bookedGuest.isSaved != true;
                                                                              if (isStartEndDatesSame && bookedGuest.startDate?.hour == visibleTime && bookedGuesEntryView == BookedGuestEntryViewEnum.none) {
                                                                                startEndDiffTimes = getDateHours(
                                                                                  bookedGuest.startDate!,
                                                                                  bookedGuest.endDate!,
                                                                                );
                                                                                bookedGuesEntryView = BookedGuestEntryViewEnum.startEnd;
                                                                              } else if (isStartSelectedDatesSame && !isEndSelectedDatesSame && bookedGuesEntryView == BookedGuestEntryViewEnum.none && bookedGuest.startDate?.hour == visibleTime) {
                                                                                startEndDiffTimes = getDateHours(bookedGuest.startDate!, DateTime(bookedGuest.startDate!.year, bookedGuest.startDate!.month, bookedGuest.startDate!.day + 2, 0));
                                                                                bookedGuesEntryView = BookedGuestEntryViewEnum.start;
                                                                              } else if (isEndSelectedDatesSame && !isStartEndDatesSame && visibleTime == 0 && bookedGuesEntryView == BookedGuestEntryViewEnum.none) {
                                                                                startEndDiffTimes = getDateHours(DateTime(bookedGuest.endDate!.year, bookedGuest.endDate!.month, bookedGuest.endDate!.day, 23).subtract(const Duration(days: 1)), bookedGuest.endDate!);
                                                                                bookedGuesEntryView = BookedGuestEntryViewEnum.end;
                                                                                // }
                                                                              } else if (isSelectedDateContainsInStartEnd && !isStartSelectedDatesSame && !isEndSelectedDatesSame && bookedGuesEntryView == BookedGuestEntryViewEnum.none) {
                                                                                startEndDiffTimes = getDateHours(
                                                                                  DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 0),
                                                                                  DateTime(selectedDay.value.year, selectedDay.value.month, selectedDay.value.day, 23),
                                                                                );

                                                                                if (startEndDiffTimes.isNotEmpty) {
                                                                                  bookedGuesEntryView = BookedGuestEntryViewEnum.center;
                                                                                }
                                                                              } else {
                                                                                bookedGuesEntryView = BookedGuestEntryViewEnum.date;
                                                                              }
                                                                            }
                                                                          } else {
                                                                            bookedGuesEntryView =
                                                                                BookedGuestEntryViewEnum.date;
                                                                          }
                                                                        }

                                                                        if (bookedGuesEntryView ==
                                                                            BookedGuestEntryViewEnum
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
                                                                            BookedGuestEntryViewEnum.end) {
                                                                          bool isBefore = isCalendarDayView == true
                                                                              ? (startEndDiffDates.isNotEmpty ? startEndDiffDates.last.isAfter(_visibleDates.last) : false)
                                                                              : isEndSelectedDatesSame
                                                                                  ? true
                                                                                  : false;

                                                                          double
                                                                              getBookedGuestWidth() {
                                                                            List<DateTime> _startEndDiff = isCalendarDayView == true
                                                                                ? startEndDiffDates
                                                                                : startEndDiffTimes;

                                                                            double
                                                                                width =
                                                                                bookedGuestSize;

                                                                            width =
                                                                                width + (_startEndDiff.isNotEmpty ? (bookedGuestSize * (_startEndDiff.length - 1)) + (_startEndDiff.length - 1) * 6 : 0);
                                                                            return width;
                                                                          }

                                                                          return SizedBox(
                                                                            width:
                                                                                getBookedGuestWidth(),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                context.pushNamed('guest_info', extra: {
                                                                                  'info': currentResourceBookedGuests[reducedBookedGuestIndex].toMap()
                                                                                });
                                                                              },
                                                                              child: BookedGuestViewCard(
                                                                                borderRadius: allCircularRadius12.copyWith(bottomLeft: Radius.circular(isBefore ? 0 : 12), topLeft: Radius.circular(isBefore ? 0 : 12)),
                                                                                bookedGuest: currentResourceBookedGuests[reducedBookedGuestIndex],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          if (currentResourceBookedGuests.isNotEmpty &&
                                                                              currentResourceBookedGuests[reducedBookedGuestIndex].isSaved == true) {
                                                                            return const SavedGuestCard();
                                                                          } else {
                                                                            bool
                                                                                isBefore =
                                                                                false;
                                                                            if (isCalendarDayView ==
                                                                                true) {
                                                                              isBefore = (startEndDiffDates.isNotEmpty ? startEndDiffDates.first.subtract(const Duration(days: 1)).isBefore(_visibleDates.first) : false);
                                                                            } else {
                                                                              isBefore = bookedGuesEntryView == BookedGuestEntryViewEnum.center ? true : false;
                                                                            }
                                                                            bool
                                                                                isContinue =
                                                                                false;
                                                                            if (isCalendarDayView ==
                                                                                true) {
                                                                              isContinue = (startEndDiffDates.isNotEmpty ? startEndDiffDates.last.isAfter(_visibleDates.last) : false);
                                                                            } else {
                                                                              if (bookedGuesEntryView == BookedGuestEntryViewEnum.start) {
                                                                                isContinue = DateTime(startEndDiffTimes.last.year, startEndDiffTimes.last.month, startEndDiffTimes.last.day).isAfter(selectedDay.value);
                                                                              } else if (bookedGuesEntryView == BookedGuestEntryViewEnum.center) {
                                                                                isContinue = true;
                                                                              }
                                                                            }

                                                                            double
                                                                                getBookedGuestWidth() {
                                                                              List<DateTime> _startEndDiff = isCalendarDayView == true ? startEndDiffDates : startEndDiffTimes;
                                                                              final diffDatesAfterLastDate = _startEndDiff.where((e) {
                                                                                if (isCalendarDayView == true) {
                                                                                  return e.isAfter(_visibleDates.last);
                                                                                } else {
                                                                                  return e.isAfter(selectedDay.value.add(const Duration(hours: 24)));
                                                                                }
                                                                              });
                                                                              double width = bookedGuestSize;

                                                                              width = width + (_startEndDiff.isNotEmpty ? (bookedGuestSize * _startEndDiff.length) + (_startEndDiff.length) * 6 : 0) - (isContinue == true ? (diffDatesAfterLastDate.length * 46) + (diffDatesAfterLastDate.length * 6) : 0);
                                                                              return width;
                                                                            }

                                                                            return SizedBox(
                                                                              width: getBookedGuestWidth(),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  context.pushNamed('guest_info', extra: {
                                                                                    'info': currentResourceBookedGuests[reducedBookedGuestIndex].toMap()
                                                                                  });
                                                                                },
                                                                                child: BookedGuestViewCard(
                                                                                  borderRadius: allCircularRadius12.copyWith(bottomLeft: Radius.circular(isBefore ? 0 : 12), topLeft: Radius.circular(isBefore ? 0 : 12), bottomRight: Radius.circular(isContinue ? 0 : 12), topRight: Radius.circular(isContinue ? 0 : 12)),
                                                                                  bookedGuest: currentResourceBookedGuests[reducedBookedGuestIndex],
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
                                                  bookedGuestsVertController);
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
