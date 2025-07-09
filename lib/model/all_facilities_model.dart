// To parse this JSON data, do
//
//     final allFacilitiesModel = allFacilitiesModelFromJson(jsonString);

import 'dart:convert';

AllFacilitiesModel allFacilitiesModelFromJson(String str) => AllFacilitiesModel.fromJson(json.decode(str));

String allFacilitiesModelToJson(AllFacilitiesModel data) => json.encode(data.toJson());

class AllFacilitiesModel {
    int? status;
    bool? error;
    String? message;
    List<Datum>? data;

    AllFacilitiesModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory AllFacilitiesModel.fromJson(Map<String, dynamic> json) => AllFacilitiesModel(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? facilitiesId;
    String? facilitiesName;
    String? image;
    bool isSelect;

    Datum({
        this.facilitiesId,
        this.facilitiesName,
        this.image,
        this.isSelect=false
    });

    factory Datum.fromJson(Map<String, dynamic> json, {String? facilitiesId}) => Datum(
        facilitiesId: json["facilities_id"],
        facilitiesName: json["facilities_name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "facilities_id": facilitiesId,
        "facilities_name": facilitiesName,
        "image": image,
        "is_select":isSelect
    };
}
