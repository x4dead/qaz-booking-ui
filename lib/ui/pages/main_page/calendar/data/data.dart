﻿import 'package:qaz_booking_ui/model/guest_model.dart';
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
  ObjectToBook(
    object: 'Гостиница',
    objectName: "Номер 1",
    roomsCount: 2,
    id: '0007',
  ),
];
final now = DateTime.now();
final listAppointment = [
  GuestModel(
    arrivalDate: now.add(const Duration(days: 1)).toIso8601String(),
    resourceId: '0000',
    departureDate: now.add(const Duration(days: 1)).toIso8601String(),
    color: AppColors.colorBlue,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
  GuestModel(
    arrivalDate: now.add(const Duration(days: 3)).toIso8601String(),
    resourceId: '0000',
    departureDate: now.add(const Duration(days: 4)).toIso8601String(),
    color: AppColors.colorViolet,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
  GuestModel(
    arrivalDate: now.toIso8601String(),
    resourceId: '0001',
    departureDate: now.add(const Duration(days: 2)).toIso8601String(),
    color: AppColors.colorOrange,
    payment: '77 400 ₸',
    guestFullname: 'Екатерина',
  ),
  GuestModel(
    arrivalDate: now.add(const Duration(days: 2)).toIso8601String(),
    resourceId: '0002',
    departureDate: now.add(const Duration(days: 3)).toIso8601String(),
    color: AppColors.colorViolet,
    payment: '2k',
    guestFullname: 'Ст',
  ),
  GuestModel(
    arrivalDate: now.add(const Duration(days: 6)).toIso8601String(),
    resourceId: '0002',
    departureDate: now.add(const Duration(days: 9)).toIso8601String(),
    color: AppColors.colorGreen,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
  GuestModel(
    arrivalDate: now.add(const Duration(days: 3)).toIso8601String(),
    resourceId: '0003',
    departureDate: now.add(const Duration(days: 4)).toIso8601String(),
    color: AppColors.colorBlue,
    payment: '6 300 ₸',
    guestFullname: 'Эдуард Б. М.',
  ),
];