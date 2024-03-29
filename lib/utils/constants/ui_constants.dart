import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

///SizedBox const

const kSBW15 = SizedBox(width: 15);
const kSBH25 = SizedBox(height: 25);
const kSBH100 = SizedBox(height: 100);
const kSBH50 = SizedBox(height: 50);
const kSBH45 = SizedBox(height: 45);
const kSBH10 = SizedBox(height: 10);
const kSBH12 = SizedBox(height: 12);
const kSBW10 = SizedBox(width: 10);
const kSBW12 = SizedBox(width: 12);
const kSBW20 = SizedBox(width: 20);
const kSBH20 = SizedBox(height: 20);
const kSBH15 = SizedBox(height: 15);
const kSBH16 = SizedBox(height: 16);
const kSBW16 = SizedBox(width: 16);
const kSBW6 = SizedBox(width: 6);
const kSBH6 = SizedBox(height: 6);
const kSBH5 = SizedBox(height: 5);
const kSBH4 = SizedBox(height: 4);
const kSBH2 = SizedBox(height: 2);
const kSBH8 = SizedBox(height: 8);
const kNothing = SizedBox.shrink();

///Padding
const kPH20V12 = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
const kPZero = EdgeInsets.zero;
const kPAll6 = EdgeInsets.all(6);
const kPAll20 = EdgeInsets.all(20);
const kPV15 = EdgeInsets.symmetric(vertical: 15);
const kPH45V25 = EdgeInsets.symmetric(horizontal: 45, vertical: 25);
const kPH20 = EdgeInsets.symmetric(horizontal: 20);
const kPH20V18Dot5 = EdgeInsets.symmetric(horizontal: 20, vertical: 18.5);

///BorderRadius
const Radius buttonRadius = Radius.circular(12);

///Size
const double bookedGuestSize = 46;
const kS36 = Size(36, 36);

const bottomBorder = Border(
    bottom: BorderSide(
        color: AppColors.colorLightGray,
        width: 1,
        strokeAlign: BorderSide.strokeAlignInside));
const allCircularRadius12 = BorderRadius.all(Radius.circular(12));

const List<(String, String)> menuButtons = [
  (AppImages.main, 'Главная'),
  (AppImages.home, 'Сдаваемые объекты'),
  (AppImages.list, 'Доп. услуги'),
  (AppImages.person, 'Профиль'),
  (AppImages.archive, 'Архив'),
  (AppImages.attachDocument, 'Информация'),
];
const List<String> shortWeekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
const List<String> weekDays = [
  "Понедельник",
  "Вторник",
  "Среда",
  "Четверг",
  "Пятница",
  "Суббота",
  "Воскресенье",
];
const List<String> months = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];
const List<String> middleMonth = [
  "Янв",
  "Фев",
  "Мар",
  "Апр",
  "Май",
  "Июн",
  "Июл",
  "Авг",
  "Сен",
  "Окт",
  "Ноя",
  "Дек",
];
