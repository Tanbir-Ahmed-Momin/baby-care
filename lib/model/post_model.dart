
import 'dart:convert';

class PostModel {
  final String userId;
  final String postedBy;
  final String details;
  final int time;
  final String title;

  PostModel({
    required this.userId,
    required this.postedBy,
    required this.details,
    required this.time,
    required this.title,
  });

  factory PostModel.fromRawJson(String str) => PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    userId: json["user_id"]??"",
    postedBy: json["posted_by"]??"unknown",
    details: json["details"]??"",
    time: json["time"]??00000,
    title: json["title"]??"",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "posted_by": postedBy,
    "details": details,
    "time": time,
    "title": title,
  };
}
