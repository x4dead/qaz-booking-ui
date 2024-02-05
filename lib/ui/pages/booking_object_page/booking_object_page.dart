import 'package:flutter/material.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_dropdown_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/floating_label_text_field.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';

class BookingObjectPage extends StatefulWidget {
  const BookingObjectPage({super.key});

  @override
  State<BookingObjectPage> createState() => _BookingObjectPageState();
}

class _BookingObjectPageState extends State<BookingObjectPage> {
  final objectDescription = TextEditingController();
  final objectRooms = TextEditingController();
  final objectFloor = TextEditingController();
  final objectName = TextEditingController();
  final objectSleepingPlace = TextEditingController();
  final objectPrice = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    objectDescription.dispose();
    objectRooms.dispose();
    objectFloor.dispose();
    objectName.dispose();
    objectSleepingPlace.dispose();
    objectPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorLightGray,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: CustomAppBar(
          title: 'Комната 2',
        ),
      ),
      body: Padding(
        padding: kPAll20,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CustomDropdownMenu(
                    initialSelectedObject: 'Хостел',
                    onSelected: (p0) {},
                    floatingLabelText: 'Тип объекта',
                    hintText: "Свой вариант",
                    menuObjects: const [
                      'Хостел',
                      'Гостиница',
                    ],
                  ),
                  kSBH25,
                  CustomDropdownMenu(
                    initialSelectedObject: 'Комната',
                    onSelected: (p0) {},
                    floatingLabelText: 'Объекта',
                    hintText: "Свой вариант",
                    menuObjects: const [
                      'Комната',
                      'Коттедж',
                      'Техника',
                      'Эл. техника',
                      'Комната',
                      'Коттедж',
                      'Техника',
                      'Эл. техника',
                    ],
                  ),
                  kSBH25,
                  FloatingLabelTextField(
                    controller: objectDescription,
                    floatingLabelText: 'Описание объекта/адрес',
                    hintText: 'Введите текст',
                  ),
                  kSBH25,
                  Row(
                    children: [
                      Flexible(
                        child: FloatingLabelTextField(
                          controller: objectRooms,
                          floatingLabelText: 'Кол-во комнат',
                          hintText: '12',
                        ),
                      ),
                      kSBW12,
                      Flexible(
                        child: FloatingLabelTextField(
                          controller: objectFloor,
                          floatingLabelText: 'Этаж',
                          hintText: '7',
                        ),
                      ),
                    ],
                  ),
                  kSBH25,
                  FloatingLabelTextField(
                    controller: objectName,
                    floatingLabelText: 'Название объекта',
                    hintText: 'Введите название объекта',
                  ),
                  kSBH25,
                  FloatingLabelTextField(
                    controller: objectSleepingPlace,
                    floatingLabelText: 'Спальные места',
                    hintText: 'Введите кол-во спальных мест',
                  ),
                  kSBH25,
                  FloatingLabelTextField(
                    controller: objectPrice,
                    floatingLabelText: 'Стоимость объекта',
                    hintText: 'Введите стоимость объекта',
                  ),
                  kSBH25,
                  Chip(
                    label: Text(
                      'Фото',
                      style: AppTextStyle.w400s15SFProDisplay,
                    ),
                    labelPadding: kPZero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                          color: AppColors.colorGray,
                          strokeAlign: BorderSide.strokeAlignInside),
                    ),
                  ),
                  kSBH15,
                  Row(
                    children: [
                      ///TODO: Кнопки для картинок
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
