﻿import 'dart:convert';

class GuestModel {
  final String? arrivalDate;
  final String? arrivalTime;
  final String? departureDate;
  final String? departureTime;
  final String? bookingStatus;
  final String? objectName;
  final int? adultsCount;
  final int? childrenCount;
  final String? guestFullname;
  final String? phoneNumber;
  final String? paymentMethod;
  final int? prepayment;
  final int? payment;
  final List<String>? photosOfDocuments;
  final String? color;
  final String? comment;

  GuestModel({
    this.arrivalDate,
    this.arrivalTime,
    this.departureDate,
    this.departureTime,
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
    String? arrivalDate,
    String? arrivalTime,
    String? departureDate,
    String? departureTime,
    String? bookingStatus,
    String? objectName,
    int? adultsCount,
    int? childrenCount,
    String? guestFullname,
    String? phoneNumber,
    String? paymentMethod,
    int? prepayment,
    int? payment,
    List<String>? photosOfDocuments,
    String? color,
    String? comment,
  }) =>
      GuestModel(
        arrivalDate: arrivalDate ?? this.arrivalDate,
        arrivalTime: arrivalTime ?? this.arrivalTime,
        departureDate: departureDate ?? this.departureDate,
        departureTime: departureTime ?? this.departureTime,
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

  factory GuestModel.fromJson(String str) =>
      GuestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GuestModel.fromMap(Map<String, dynamic> json) => GuestModel(
        arrivalDate: json["arrival_date"],
        arrivalTime: json["arrival_time"],
        departureDate: json["departure_date"],
        departureTime: json["departure_time"],
        bookingStatus: json["booking_status"],
        objectName: json["object_name"],
        adultsCount: json["adults_count"],
        childrenCount: json["children_count"],
        guestFullname: json["guest_fullname"],
        phoneNumber: json["phone_number"],
        paymentMethod: json["payment_method"],
        prepayment: json["prepayment"],
        payment: json["payment"],
        photosOfDocuments: json["photos_of_documents"] == null
            ? []
            : List<String>.from(json["photos_of_documents"]!.map((x) => x)),
        color: json["color"],
        comment: json["comment"],
      );

  Map<String, dynamic> toMap() => {
        "arrival_date": arrivalDate,
        "arrival_time": arrivalTime,
        "departure_date": departureDate,
        "departure_time": departureTime,
        "booking_status": bookingStatus,
        "object_name": objectName,
        "adults_count": adultsCount,
        "children_count": childrenCount,
        "guest_fullname": guestFullname,
        "phone_number": phoneNumber,
        "payment_method": paymentMethod,
        "prepayment": prepayment,
        "payment": payment,
        "photos_of_documents": photosOfDocuments == null
            ? []
            : List<dynamic>.from(photosOfDocuments!.map((x) => x)),
        "color": color,
        "comment": comment,
      };
}