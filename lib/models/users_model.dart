// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.message,
    required this.number,
  });

  String id;
  String name;
  String message;
  String number;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        message: json["Message"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Message": message,
        "number": number,
      };
}
