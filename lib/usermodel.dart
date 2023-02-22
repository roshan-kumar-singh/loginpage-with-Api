import 'dart:convert';


// To parse this JSON data, do
//
//    final userLoginSuccessModel = userLoginSuccessModelFromJson(jsonString);





class UserModel {
  UserModel({
     this.status,
     this.key,
     this.userType,
     this.name,
     this.username,
     this.institute,
     this.code,
     this.mainTeacher,
     this.appUrl,

  });
  String? status;
  String? key;
  String? userType;
  String? name;
  String? username;
  String? institute;
  String? code;
  bool? mainTeacher;
  String? appUrl;

  //   AssignedName(String name){
  //   assignedAgentName=name;
  // }
  factory UserModel.fromJson(Map<dynamic, dynamic> json) =>
      UserModel(

        status: json["status"] ?? null,
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        username:
        json["username"] == null ? null : json["username"],
        userType: json["userType"] == null ? null : json["userType"],
        code: json["code"] == null ? null : json["code"],
        institute: json["institute"] == null ? null : json["institute"],
        mainTeacher: json["mainTeacher"] == null ? null : json["mainTeacher"],
        appUrl: json["appUrl"] == null ? null : json["appUrl"],

      );
}


