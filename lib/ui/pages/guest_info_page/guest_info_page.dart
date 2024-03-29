﻿// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/data/data.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_calendar_dialog.dart';
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
  const GuestInfoPage(
      {super.key,
      this.isRegisterGuest = false,
      this.guestModel,
      this.objectToBook});
  final bool isRegisterGuest;
  final GuestModel? guestModel;
  final ObjectToBook? objectToBook;
  @override
  State<GuestInfoPage> createState() => _GuestInfoPageState();
}

class _GuestInfoPageState extends State<GuestInfoPage> {
  late TextEditingController bookingStatus;
  late TextEditingController guestChildren;
  late TextEditingController guestAdults;
  late TextEditingController guestFullName;
  late TextEditingController objectName;
  late TextEditingController paymentMethod;
  late TextEditingController guestPhone;
  late TextEditingController prepayment;
  late TextEditingController payment;
  late TextEditingController comment;
  late TextEditingController startDate;
  late TextEditingController startTime;
  late TextEditingController endDate;
  late TextEditingController endTime;
  final selectedColorIndex = ValueNotifier<int>(1);
  @override
  void initState() {
    super.initState();
    selectedColorIndex.value = widget.isRegisterGuest == true
        ? 1
        : switch (widget.guestModel?.color) {
            AppColors.colorBlue => 0,
            AppColors.colorGreen => 1,
            AppColors.colorOrange => 2,
            _ => 3
          };
    bookingStatus = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.bookingStatus ?? "");
    guestChildren = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.childrenCount?.toString() ?? '');
    guestAdults = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.adultsCount?.toString() ?? '');
    guestFullName = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.guestFullname ?? "");
    objectName = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.objectName ?? "");
    paymentMethod = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.paymentMethod ?? "");
    guestPhone = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.phoneNumber ?? "");
    prepayment = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.prepayment ?? "");
    payment = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.payment ?? "");
    comment = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.comment ?? "");
    startDate = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : DateFormat("dd.MM.y").format(widget.guestModel!.startDate!));
    startTime = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.startTime ?? "");
    endDate = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : DateFormat("dd.MM.y").format(widget.guestModel!.endDate!));
    endTime = TextEditingController(
        text: widget.isRegisterGuest == true
            ? ""
            : widget.guestModel?.endTime ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    bookingStatus.dispose();
    guestChildren.dispose();
    paymentMethod.dispose();
    guestAdults.dispose();
    guestFullName.dispose();
    objectName.dispose();
    guestPhone.dispose();
    prepayment.dispose();
    payment.dispose();
    comment.dispose();
    startDate.dispose();
    startTime.dispose();
    endDate.dispose();
    endTime.dispose();
  }

  ValueNotifier<List<String>> listImgs = ValueNotifier(['', '', '']);
  void addObjecImage(int index, String url) {
    final oldList = listImgs.value;

    ///Обновление листа для перерисовки виджета
    listImgs.value = [];
    listImgs.value = oldList;

    listImgs.value[index] = url;
  }

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
            colorFilter:
                const ColorFilter.mode(AppColors.colorGray, BlendMode.srcIn),
          ),
          kSBW20,
        ],
      );
    }

    final List<String> listObjects = [];
    for (var element in listResources) {
      listObjects.add(element.objectName ?? '');
    }

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(
        title: widget.isRegisterGuest == true
            ? "Запись гостя"
            : widget.guestModel?.guestFullname ?? '???',
        action: (
          SvgPicture.asset(
            AppImages.save,
            colorFilter:
                const ColorFilter.mode(AppColors.colorBlack, BlendMode.srcIn),
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
                    initialDate: widget.guestModel?.startDate != null
                        ? widget.guestModel!.startDate!
                        // initEndSelectedDate
                        : DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                    onDateChanged: (value) {
                      startDate.text = DateFormat("dd.MM.y").format(value);
                      // initStartSelectedDate
                      // startDate.text = value.toIso8601String();
                    },
                  );
                },
                readOnly: true,
                suffix: getSuffix(AppImages.calendar),
                controller: startDate,
                floatingLabelText: 'Дата заезда',
                hintText: '01.01.0001',
              ),
              kSBH25,
              FloatingLabelTextField(
                suffix: getSuffix(AppImages.time),
                controller: startTime,
                floatingLabelText: 'Время заезда',
                hintText: '00:00',
              ),
              kSBH25,
              FloatingLabelTextField(
                onTap: () {
                  _showCalendarDialog(
                    context,
                    firstDate: DateTime(1900),
                    initialDate: widget.guestModel?.endDate != null
                        ? widget.guestModel!.endDate!
                        // initEndSelectedDate
                        : DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                    onDateChanged: (value) {
                      endDate.text = DateFormat("dd.MM.y").format(value);

                      // initEndSelectedDate = value;
                      // endDate.text = value.toString();
                    },
                  );
                },
                readOnly: true,
                suffix: getSuffix(AppImages.calendar),
                controller: endDate,
                floatingLabelText: 'Дата выезда',
                hintText: '01.01.0001',
              ),
              kSBH25,
              FloatingLabelTextField(
                suffix: getSuffix(AppImages.time),
                controller: endTime,
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
                overlineText: widget.isRegisterGuest == false
                    ? "2"
                    //  widget.objectToBook?.roomsCount?
                    // .toString()
                    : null,
                textEditingController: objectName,
                initialSelectedObject: 'Комната 1',
                onSelected: (p0) {},
                floatingLabelText:
                    widget.isRegisterGuest == true ? 'Объект' : 'Комната',
                hintText: "Введите текст",
                menuObjects: listObjects,
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
              if (widget.isRegisterGuest == false) ...[
                kSBH25,
                CustomDropdownMenu(
                  textEditingController: paymentMethod,
                  initialSelectedObject: 'Наличные',
                  onSelected: (p0) {},
                  floatingLabelText: 'Способ оплаты',
                  hintText: "Введите способ оплаты",
                  menuObjects: const [
                    'Наличные',
                    'Перевод',
                  ],
                ),
              ],
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
