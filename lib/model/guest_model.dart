// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

class GuestModel {
  final bool? isSaved;
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
    this.isSaved,
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
    bool? isSaved,
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
        isSaved: isSaved ?? this.isSaved,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSaved': isSaved,
      'startDate': startDate?.millisecondsSinceEpoch,
      'startTime': startTime,
      'endDate': endDate?.millisecondsSinceEpoch,
      'endTime': endTime,
      'bookingStatus': bookingStatus,
      'objectName': objectName,
      'adultsCount': adultsCount,
      'childrenCount': childrenCount,
      'guestFullname': guestFullname,
      'phoneNumber': phoneNumber,
      'paymentMethod': paymentMethod,
      'prepayment': prepayment,
      'payment': payment,
      'photosOfDocuments': photosOfDocuments,
      'color': color?.value,
      'comment': comment,
      'resourceId': resourceId,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      isSaved: map['isSaved'] != null ? map['isSaved'] as bool : null,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int)
          : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int)
          : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      bookingStatus:
          map['bookingStatus'] != null ? map['bookingStatus'] as String : null,
      objectName:
          map['objectName'] != null ? map['objectName'] as String : null,
      adultsCount:
          map['adultsCount'] != null ? map['adultsCount'] as int : null,
      childrenCount:
          map['childrenCount'] != null ? map['childrenCount'] as int : null,
      guestFullname:
          map['guestFullname'] != null ? map['guestFullname'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      paymentMethod:
          map['paymentMethod'] != null ? map['paymentMethod'] as String : null,
      prepayment:
          map['prepayment'] != null ? map['prepayment'] as String : null,
      payment: map['payment'] != null ? map['payment'] as String : null,
      photosOfDocuments: map['photosOfDocuments'] != null
          ? List<String>.from((map['photosOfDocuments'] as List<String>))
          : null,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      resourceId:
          map['resourceId'] != null ? map['resourceId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestModel.fromJson(String source) =>
      GuestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
