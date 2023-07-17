import 'dart:convert';

class UserModel {
  final String uid;
  final String photoUrl;
  final String address;
  final String phone;
  final String name;

  UserModel({
    required this.uid,
    required this.photoUrl,
    required this.address,
    required this.phone,
    required this.name,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        photoUrl: json["photoUrl"] ??
            'https://firebasestorage.googleapis.com/v0/b/babycare-184d3.appspot.com/o/profiles%2Fdefault.jpg?alt=media&token=e5594834-444e-4943-9251-118e94aa62bd',
        address: json["address"] ?? 'Unknown',
        phone: json["phone"] ?? '+880',
        name: json["name"] ?? 'Guest',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoUrl": photoUrl,
        "address": address,
        "phone": phone,
        "name": name,
      };
}
