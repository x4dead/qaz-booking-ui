import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_chip.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_button.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_dropdown_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/floating_label_text_field.dart';
import 'package:qaz_booking_ui/ui/widgets/image_attach_widget.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'dart:math' as math;

class BookingObjectPage extends StatefulWidget {
  const BookingObjectPage({super.key, this.objectToBook});
  final ObjectToBook? objectToBook;

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

  ValueNotifier<List<String>> listImgs = ValueNotifier(['', '', '']);
  void addObjecImage(int index, String url) {
    final oldList = listImgs.value;

    ///Обновление листа для перерисовки виджета
    listImgs.value = [];
    listImgs.value = oldList;

    listImgs.value[index] = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: const CustomAppBar(
        title: 'Комната 2',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kPH20,
          child: Column(
            children: [
              kSBH20,
              CustomDropdownMenu(
                initialSelectedObject: 'Хостел',
                onSelected: (p0) {},
                floatingLabelText: 'Тип объекта',
                hintText: "Свой вариант",
                menuObjects: const [
                  'Хостел',
                  'Гостиница',
                  'Дом',
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
                  'Автомобиль',
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
              const CustomChip(title: 'Фото'),
              kSBH15,
              ValueListenableBuilder(
                  valueListenable: listImgs,
                  builder: (context, v, child) {
                    return Row(
                        children:
                            List.generate(math.max(0, 3 * 2 - 1), (index) {
                      if (index.isEven) {
                        final int itemIndex = index ~/ 2;
                        List localImgs = [
                          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/92/c8/fb/rio-tigre-hotel.jpg?w=700&h=-1&s=1',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH1MaELC2i0QAMgbY5ODNGI_BZusJEfZBmPQ&usqp=CAU',
                          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/59/a6/e0/rez-apart-hotel.jpg?w=700&h=-1&s=1"
                        ];
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
                      }
                      return const Spacer();
                    }));
                  }),
              kSBH50,
              Padding(
                padding: kPH20,
                child: CustomButton(
                  buttonText: 'Готово',
                  onTap: () => context.go('/objects_for_booking'),
                ),
              ),
              kSBH100,
              kSBH8
            ],
          ),
        ),
      ),
    );
  }
}
