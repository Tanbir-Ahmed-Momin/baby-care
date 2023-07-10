
import 'dart:convert';

class GuideLineModel {

  final String details;
  final String title;



  GuideLineModel({

    required this.details,
    required this.title,
  });

  factory GuideLineModel.fromRawJson(String str) => GuideLineModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GuideLineModel.fromJson(Map<String, dynamic> json) => GuideLineModel(

    details: json["description"]??"",
    title: json["title"]??"unknown",

  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": details,
  };
}
