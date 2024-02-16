import 'dart:convert';
import 'dart:ui';

class GuestModel {
  final DateTime? startDate;
  final String? startTime;
  final DateTime? endDate;
  final String? endTime;
  final String? bookingStatus;
  final String? objectName;
  final int? adultsCount;
  final int? childrenCount;
  final String? guestFullname;
  final String? phoneNumber;
  final String? paymentMethod;
  final String? prepayment;
  final String? payment;
  final List<String>? photosOfDocuments;
  final Color? color;
  final String? comment;
  final String? resourceId;

  const GuestModel({
    this.resourceId,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.bookingStatus,
    this.objectName,
    this.adultsCount,
    this.childrenCount,
    this.guestFullname,
    this.phoneNumber,
    this.paymentMethod,
    this.prepayment,
    this.payment,
    this.photosOfDocuments,
    this.color,
    this.comment,
  });

  GuestModel copyWith({
    DateTime? startDate,
    String? startTime,
    DateTime? endDate,
    String? endTime,
    String? bookingStatus,
    String? objectName,
    int? adultsCount,
    int? childrenCount,
    String? guestFullname,
    String? phoneNumber,
    String? paymentMethod,
    String? prepayment,
    String? payment,
    List<String>? photosOfDocuments,
    Color? color,
    String? comment,
  }) =>
      GuestModel(
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        endDate: endDate ?? this.endDate,
        endTime: endTime ?? this.endTime,
        bookingStatus: bookingStatus ?? this.bookingStatus,
        objectName: objectName ?? this.objectName,
        adultsCount: adultsCount ?? this.adultsCount,
        childrenCount: childrenCount ?? this.childrenCount,
        guestFullname: guestFullname ?? this.guestFullname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        prepayment: prepayment ?? this.prepayment,
        payment: payment ?? this.payment,
        photosOfDocuments: photosOfDocuments ?? this.photosOfDocuments,
        color: color ?? this.color,
        comment: comment ?? this.comment,
      );
}
