import 'dart:convert';

import 'package:qaz_booking_ui/model/guest_model.dart';

class ObjectToBook {
  final String? id;
  final String? object;
  final String? objectName;
  final String? objectDescription;
  final String? objectPrice;
  final String? sleepingPlaces;
  final String? objectType;
  final int? roomsCount;
  final int? floorNumber;
  final List<String>? listImages;
  final List<GuestModel>? guests;

  const ObjectToBook({
    this.id,
    this.object,
    this.objectName,
    this.objectDescription,
    this.objectPrice,
    this.sleepingPlaces,
    this.objectType,
    this.roomsCount,
    this.floorNumber,
    this.listImages,
    this.guests,
  });

  ObjectToBook copyWith({
    String? id,
    String? object,
    String? objectName,
    String? objectDescription,
    String? objectPrice,
    String? sleepingPlaces,
    String? objectType,
    int? roomsCount,
    int? floorNumber,
    List<String>? listImages,
    List<GuestModel>? guests,
  }) =>
      ObjectToBook(
        id: id ?? this.id,
        object: object ?? this.object,
        objectName: objectName ?? this.objectName,
        objectDescription: objectDescription ?? this.objectDescription,
        objectPrice: objectPrice ?? this.objectPrice,
        sleepingPlaces: sleepingPlaces ?? this.sleepingPlaces,
        objectType: objectType ?? this.objectType,
        roomsCount: roomsCount ?? this.roomsCount,
        floorNumber: floorNumber ?? this.floorNumber,
        listImages: listImages ?? this.listImages,
        guests: guests ?? this.guests,
      );

  factory ObjectToBook.fromJson(String str) =>
      ObjectToBook.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ObjectToBook.fromMap(Map<String, dynamic> json) => ObjectToBook(
        object: json["object"],
        objectName: json["object_name"],
        objectDescription: json["object_description"],
        objectPrice: json["object_price"],
        sleepingPlaces: json["sleeping_places"],
        objectType: json["object_type"],
        roomsCount: json["rooms_count"],
        floorNumber: json["floor_number"],
        listImages: json["list_images"] == null
            ? []
            : List<String>.from(json["list_images"]!.map((x) => x)),
        guests: json["guests"] == null
            ? []
            : List<GuestModel>.from(json['guests']!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "object": object,
        "object_name": objectName,
        "object_description": objectDescription,
        "object_price": objectPrice,
        "sleeping_places": sleepingPlaces,
        "object_type": objectType,
        "rooms_count": roomsCount,
        "floor_number": floorNumber,
        "list_images": listImages == null
            ? []
            : List<GuestModel>.from(listImages!.map((x) => x)),
        "guests":
            guests == null ? [] : List<GuestModel>.from(guests!.map((x) => x)),
      };
}
