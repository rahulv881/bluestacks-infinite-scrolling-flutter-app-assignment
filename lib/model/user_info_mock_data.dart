// To parse this JSON data, do
//
//     final userInfoMockData = userInfoMockDataFromJson(jsonString);

import 'dart:convert';

UserInfoMockData userInfoMockDataFromJson(String str) =>
    UserInfoMockData.fromJson(json.decode(str));

String userInfoMockDataToJson(UserInfoMockData data) =>
    json.encode(data.toJson());

class UserInfoMockData {
  UserInfoMockData({
    required this.name,
    required this.userId,
    required this.password,
    required this.mobileNumber,
    required this.profileImgUrl,
    required this.rating,
    required this.winningPercentage,
    required this.tournamentsPlayed,
    required this.tournamentsWon,
  });

  String name;
  int userId;
  String password;
  String mobileNumber;
  String profileImgUrl;
  int rating;
  double winningPercentage;
  int tournamentsPlayed;
  int tournamentsWon;

  factory UserInfoMockData.fromJson(Map<String, dynamic> json) =>
      UserInfoMockData(
        name: json["name"],
        userId: json["userId"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        profileImgUrl: json["profileImgUrl"],
        rating: json["rating"],
        tournamentsPlayed: json["tournamentsPlayed"],
        tournamentsWon: json["tournamentsWon"],
        winningPercentage: json["winningPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userId": userId,
        "password": password,
        "mobileNumber": mobileNumber,
        "profileImgUrl": profileImgUrl,
        "rating": rating,
        "tournamentsPlayed": tournamentsPlayed,
        "tournamentsWon": tournamentsWon,
        "winningPercentage": winningPercentage,
      };
}
