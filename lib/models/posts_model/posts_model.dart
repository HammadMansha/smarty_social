import 'dart:convert';


class FeedPostData {
  String id;
  String? userId;
  String? username;
  String picUrl;
  String timestamp;

  FeedPostData({
    required this.id,
    required this.userId,
    required this.username,
    required this.picUrl,
    required this.timestamp,
  });

  factory FeedPostData.fromJson(Map<String, dynamic> json) => FeedPostData(
    id: json["_id"],
    userId: json["user_id"],
    username: json["username"],
    picUrl: json["picURL"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "username": username,
    "picURL": picUrl,
    "timestamp": timestamp,
  };
}
