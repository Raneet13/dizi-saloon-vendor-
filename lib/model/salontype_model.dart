// To parse this JSON data, do
//
//     final getAllSalonTypeModel = getAllSalonTypeModelFromJson(jsonString);

import 'dart:convert';

GetAllSalonTypeModel getAllSalonTypeModelFromJson(String str) => GetAllSalonTypeModel.fromJson(json.decode(str));

String getAllSalonTypeModelToJson(GetAllSalonTypeModel data) => json.encode(data.toJson());

class GetAllSalonTypeModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    GetAllSalonTypeModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory GetAllSalonTypeModel.fromJson(Map<String, dynamic> json) => GetAllSalonTypeModel(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    List<Gender>? gender;

    Data({
        this.gender,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        gender: json["gender"] == null ? [] : List<Gender>.from(json["gender"]!.map((x) => Gender.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gender": gender == null ? [] : List<dynamic>.from(gender!.map((x) => x.toJson())),
    };
}

class Gender {
    String? id;
    String? genderName;
    DateTime? createdAt;
    DateTime? updatedAt;

    Gender({
        this.id,
        this.genderName,
        this.createdAt,
        this.updatedAt,
    });

    factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        genderName: json["gender_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "gender_name": genderName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
