// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/ui/pages/guest_info_page/custom_calendar_dialog.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_chip.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_button.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_dropdown_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/floating_label_text_field.dart';
import 'package:qaz_booking_ui/ui/widgets/image_attach_widget.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'dart:math' as math;

import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class GuestInfoPage extends StatefulWidget {
  const GuestInfoPage({super.key, this.isRegisterGuset = false});
  final bool isRegisterGuset;

  @override
  State<GuestInfoPage> createState() => _GuestInfoPageState();
}

class _GuestInfoPageState extends State<GuestInfoPage> {
  final selectedColorIndex = ValueNotifier<int>(1);
  final bookingStatus = TextEditingController();
  final guestChildren = TextEditingController();
  final guestAdults = TextEditingController();
  final guestFullName = TextEditingController();
  final objectName = TextEditingController();

  final guestPhone = TextEditingController();
  final prepayment = TextEditingController();
  final payment = TextEditingController();
  final comment = TextEditingController();
  final arrivalDate = TextEditingController();
  final arrivalTime = TextEditingController();
  final departureDate = TextEditingController();
  final departureTime = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    bookingStatus.dispose();
    guestChildren.dispose();
    guestAdults.dispose();
    guestFullName.dispose();
    objectName.dispose();
    guestPhone.dispose();
    prepayment.dispose();
    payment.dispose();
    comment.dispose();
    arrivalDate.dispose();
    arrivalTime.dispose();
    departureDate.dispose();
    departureTime.dispose();
  }

  ValueNotifier<List<String>> listImgs = ValueNotifier(['', '', '']);
  void addObjecImage(int index, String url) {
    final oldList = listImgs.value;

    ///Обновление листа для перерисовки виджета
    listImgs.value = [];
    listImgs.value = oldList;

    listImgs.value[index] = url;
  }

  DateTime? initArrivalSelectedDate;

  DateTime? initDepartureSelectedDate;
  _showCalendarDialog(BuildContext ctx,
      {required DateTime firstDate,
      required DateTime initialDate,
      required DateTime lastDate,
      required void Function(DateTime) onDateChanged}) {
    showDialog(
        context: ctx,
        builder: (ctx) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding: kPAll20,
              backgroundColor: AppColors.colorWhite,
              surfaceTintColor: AppColors.colorWhite,
              child: CustomCalendarDialog(
                  firstDate: firstDate,
                  initialDate: initialDate,
                  lastDate: lastDate,
                  onDateChanged: onDateChanged),
            ));
  }

  @override
  Widget build(BuildContext context) {
    const colorsToSelect = [
      AppColors.colorBlue,
      AppColors.colorGreen,
      AppColors.colorOrange,
      AppColors.colorViolet,
    ];
    getSuffix(String svg) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          kSBW12,
          SvgPicture.asset(
            svg,
            color: AppColors.colorGray,
          ),
          kSBW20,
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(
        title: 'Галина П. А.',
        action: (
          SvgPicture.asset(
            AppImages.save,
            color: AppColors.colorBlack,
          ),
          () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kPH20,
          child: Column(
            children: [
              kSBH20,
              FloatingLabelTextField(
                onTap: () {
                  _showCalendarDialog(
                    context,
                    firstDate: DateTime(1900),
                    initialDate: initArrivalSelectedDate ?? DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                    onDateChanged: (value) {
                      arrivalDate.text = DateFormat("dd.MM.y").format(value);
                      initArrivalSelectedDate = value;
                    },
                  );
                },
                readOnly: true,
                suffix: getSuffix(AppImages.calendar),
                controller: arrivalDate,
                floatingLabelText: 'Дата заезда',
                hintText: '01.01.0001',
              ),
              kSBH25,
              FloatingLabelTextField(
                suffix: getSuffix(AppImages.time),
                controller: arrivalTime,
                floatingLabelText: 'Время заезда',
                hintText: '00:00',
              ),
              kSBH25,
              FloatingLabelTextField(
                onTap: () {
                  _showCalendarDialog(
                    context,
                    firstDate: DateTime(1900),
                    initialDate: initDepartureSelectedDate ?? DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                    onDateChanged: (value) {
                      departureDate.text = DateFormat("dd.MM.y").format(value);
                      initDepartureSelectedDate = value;
                    },
                  );
                },
                readOnly: true,
                suffix: getSuffix(AppImages.calendar),
                controller: departureDate,
                floatingLabelText: 'Дата выезда',
                hintText: '01.01.0001',
              ),
              kSBH25,
              FloatingLabelTextField(
                suffix: getSuffix(AppImages.time),
                controller: departureTime,
                floatingLabelText: 'Время выезда',
                hintText: '00:00',
              ),
              kSBH25,
              Row(
                children: [
                  Flexible(
                    child: FloatingLabelTextField(
                      controller: guestAdults,
                      floatingLabelText: 'Взрослые',
                      hintText: '0',
                    ),
                  ),
                  kSBW12,
                  Flexible(
                    child: FloatingLabelTextField(
                      controller: guestChildren,
                      floatingLabelText: 'Дети',
                      hintText: '0',
                    ),
                  ),
                ],
              ),
              kSBH25,
              kSBH10,
              CustomDropdownMenu(
                textEditingController: objectName,
                initialSelectedObject: 'Комната 1',
                onSelected: (p0) {},
                floatingLabelText: 'Объект',
                hintText: "Введите текст",
                menuObjects: const [
                  'Комната 1',
                  'Комната 2',
                  'Комната 3',
                  'Комната 4',
                  'Комната 5',
                  'Комната 6',
                ],
              ),
              kSBH25,
              CustomDropdownMenu(
                textEditingController: bookingStatus,
                initialSelectedObject: 'Предоплата',
                onSelected: (p0) {},
                floatingLabelText: 'Статус бронирования',
                hintText: "Статус",
                menuObjects: const [
                  'Отмена бронирования',
                  'Оплата отсутствует',
                  'Предоплата',
                  'Оплачено',
                ],
              ),
              kSBH25,
              FloatingLabelTextField(
                controller: guestFullName,
                floatingLabelText: 'Ф.И.О. Гостя',
                hintText: 'Введите Фамилию и Имя',
              ),
              kSBH25,
              FloatingLabelTextField(
                controller: guestPhone,
                floatingLabelText: 'Телефон',
                hintText: 'Введите номер телефона',
              ),
              kSBH25,
              Row(
                children: [
                  Flexible(
                    child: FloatingLabelTextField(
                      controller: prepayment,
                      floatingLabelText: 'Предоплата',
                      hintText: '0',
                    ),
                  ),
                  kSBW12,
                  Flexible(
                    child: FloatingLabelTextField(
                      controller: payment,
                      floatingLabelText: 'Оплата',
                      hintText: '0',
                    ),
                  ),
                ],
              ),
              kSBH25,
              const CustomChip(title: 'Фото документов'),
              kSBH15,
              Row(
                  children: List.generate(math.max(0, 3 * 2 - 1), (index) {
                if (index.isEven) {
                  final int itemIndex = index ~/ 2;
                  List localImgs = [
                    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/92/c8/fb/rio-tigre-hotel.jpg?w=700&h=-1&s=1',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH1MaELC2i0QAMgbY5ODNGI_BZusJEfZBmPQ&usqp=CAU',
                    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/59/a6/e0/rez-apart-hotel.jpg?w=700&h=-1&s=1"
                  ];
                  return ValueListenableBuilder(
                      valueListenable: listImgs,
                      builder: (context, v, child) {
                        return ImageAttachWidget(
                          onTap: () {
                            addObjecImage(itemIndex, localImgs[itemIndex]);
                          },
                          centerText: '${itemIndex + 1}',
                          image: v.every((val) => val == '')
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(v[itemIndex])),
                        );
                      });
                }
                return const Spacer();
              })),
              kSBH25,
              const CustomChip(title: 'Цвет'),
              kSBH15,
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(math.max(0, 4 * 2 - 1), (index) {
                    if (index.isEven) {
                      final int itemIndex = index ~/ 2;

                      return ValueListenableBuilder(
                          valueListenable: selectedColorIndex,
                          builder: (context, v, child) {
                            return GestureDetector(
                              onTap: () {
                                if (selectedColorIndex.value != itemIndex) {
                                  selectedColorIndex.value = itemIndex;
                                }
                              },
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (selectedColorIndex.value == itemIndex)
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color:
                                                    colorsToSelect[itemIndex],
                                                width: 2,
                                              )),
                                        ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: colorsToSelect[itemIndex],
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          });
                    }
                    return kSBW16;
                  })),
              kSBH25,
              kSBH10,
              FloatingLabelTextField(
                controller: comment,
                floatingLabelText: 'Комментарий',
                hintText: 'Разбудить в 8:30',
              ),
              kSBH50,
              kSBH10,
              Padding(
                padding: kPH20,
                child: CustomButton(buttonText: 'Готово', onTap: () {}
                    // context.go('/objects_for_booking'),
                    ),
              ),
              const SizedBox(height: 81)
            ],
          ),
        ),
      ),
    );
  }
}
