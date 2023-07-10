
import 'dart:convert';

class DoctorModel {
  final String degrees;
  final String details;
  final String hospital;
  final String image;
  final String name;
  final int phone;

  DoctorModel({
    required this.degrees,
    required this.details,
    required this.hospital,
    required this.image,
    required this.name,
    required this.phone,
  });

  factory DoctorModel.fromRawJson(String str) => DoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    degrees: json["degrees"]??"",
    details: json["details"]??"",
    hospital: json["hospital"]??"unknown",
    image: json["image"]??"",
    name: json["name"]??"",
    phone: json["phone"]??0,
  );

  Map<String, dynamic> toJson() => {
    "degrees": degrees,
    "details": details,
    "hospital": hospital,
    "image": image,
    "name": name,
    "phone": phone,
  };
}
