import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';

const listResources = [
  ObjectToBook(
    object: 'Гостиница',
    objectName: "Номер 1",
    roomsCount: 2,
    id: '0000',
  ),
  ObjectToBook(
    object: 'Хостел',
    objectName: "Номер 12",
    roomsCount: 4,
    id: '0001',
  ),
  ObjectToBook(
    object: 'Гостиница',
    objectName: "Номер 33",
    roomsCount: 1,
    id: '0002',
  ),
  ObjectToBook(
    object: 'Гостиница',
    objectName: "Номер 33",
    roomsCount: 1,
    id: '0003',
  ),
  ObjectToBook(
    object: 'Гостиница',
    objectName: "Номер 33",
    roomsCount: 1,
    id: '0004',
  ),
  ObjectToBook(
    object: 'Гостиница',
    objectName: "Номер 1",
    roomsCount: 2,
    id: '0005',
  ),
  ObjectToBook(
    object: 'Хостел',
    objectName: "Номер 12",
    roomsCount: 4,
    id: '0006',
  ),
  // ObjectToBook(
  //   object: 'Гостиница',
  //   objectName: "Номер 1",
  //   roomsCount: 2,
  //   id: '0007',
  // ),
];
final now = DateTime.now();
final listAppointment = [
  GuestModel(
    startDate: now.add(const Duration(days: 0)),
    resourceId: '0004',
    endDate: now.add(const Duration(days: 30)),
    color: AppColors.colorGreen,
    payment: '5 300 сом',
    guestFullname: 'Арген М. М.',
  ),
  GuestModel(
    startDate: now.add(const Duration(days: 0)),
    resourceId: '0005',
    endDate: now.add(const Duration(days: 30)),
    color: AppColors.colorOrange,
    payment: '7 500 сом',
    guestFullname: 'Жанна Т. Т.',
  ),
  GuestModel(
    startDate: now.add(const Duration(days: 1)),
    resourceId: '0000',
    endDate: now.add(const Duration(days: 2)),
    color: AppColors.colorBlue,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
  GuestModel(
    startDate: now.add(const Duration(days: 3)),
    resourceId: '0000',
    endDate: now.add(const Duration(days: 4)),
    color: AppColors.colorViolet,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
  GuestModel(
    startDate: now,
    resourceId: '0001',
    endDate: now.add(const Duration(days: 2)),
    color: AppColors.colorOrange,
    payment: '77 400 ₸',
    guestFullname: 'Екатерина',
  ),
  GuestModel(
    startDate: now.add(const Duration(days: 2)),
    resourceId: '0002',
    endDate: now.add(const Duration(days: 3)),
    color: AppColors.colorViolet,
    payment: '2k',
    guestFullname: 'Ст',
  ),
  GuestModel(
    startDate: now.add(const Duration(days: 6)),
    resourceId: '0002',
    endDate: now.add(const Duration(days: 9)),
    color: AppColors.colorGreen,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
  GuestModel(
    startDate: now.add(const Duration(days: 3)),
    resourceId: '0003',
    endDate: now.add(const Duration(days: 4)),
    color: AppColors.colorBlue,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
];
