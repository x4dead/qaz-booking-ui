import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';


bool isSameDate(DateTime? date1, DateTime? date2) {
  if (date2 == date1) {
    return true;
  }

  if (date1 == null || date2 == null) {
    return false;
  }

  return date1.month == date2.month &&
      date1.year == date2.year &&
      date1.day == date2.day;
}

List<int> getHours() {
  List<int> hours = [];
  for (int i = 0; i < 24; i++) {
    hours.add(i);
  }
  return hours;
}

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

Color getBookedGuestPaymentColor(Color color) => switch (color) {
      AppColors.colorBlue => AppColors.colorSecondaryBlue,
      AppColors.colorOrange => AppColors.colorSecondaryOrange,
      AppColors.colorViolet => AppColors.colorSecondaryViolet,
      _ => AppColors.colorSecondaryGreen
    };

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

List<DateTime> getMonthDates({required int year, required int month}) {
  List<DateTime> listDates = [];
  final dateCount = DateUtils.getDaysInMonth(year, month);
  for (int i = 0; i < dateCount;) {
    i++;
    final DateTime currentDate = DateTime(year, month, i);

    listDates.add(currentDate);
  }

  return listDates;
}