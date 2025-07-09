// To parse this JSON data, do
//
//     final allServicesModel = allServicesModelFromJson(jsonString);

import 'dart:convert';

AllServicesModel allServicesModelFromJson(String str) => AllServicesModel.fromJson(json.decode(str));

String allServicesModelToJson(AllServicesModel data) => json.encode(data.toJson());

class AllServicesModel {
    int? status;
    bool? error;
    String? message;
    List<Datum>? data;

    AllServicesModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory AllServicesModel.fromJson(Map<String, dynamic> json) => AllServicesModel(
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
    String? serviceMasterId;
    String? genderId;
    String? serviceMasterName;
    String? image;
    String? serviceType;
    String? status;
    bool isSelected;
    String? price;

    Datum({
        this.serviceMasterId,
        this.genderId,
        this.serviceMasterName,
        this.image,
        this.serviceType,
        this.status,
        this.isSelected=false,
        this.price="0"
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serviceMasterId: json["service_master_id"],
        genderId: json["gender_id"],
        serviceMasterName: json["service_master_name"],
        image: json["image"],
        serviceType: json["service_type"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "service_master_id": serviceMasterId,
        "gender_id": genderId,
        "service_master_name": serviceMasterName,
        "image": image,
        "service_type": serviceType,
        "status": status,
        "is_selected":isSelected,
        "price":price
    };
}


// class Datum {
//     String? serviceMasterId;
//     String? serviceMasterName;
//     String? image;
    

//     Datum({
//         this.serviceMasterId,
//         this.serviceMasterName,
//         this.image,
        
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         serviceMasterId: json["service_master_id"],
//         serviceMasterName: json["service_master_name"],
//         image: json["image"],
//     );

//     Map<String, dynamic> toJson() => {
//         "service_master_id": serviceMasterId,
//         "service_master_name": serviceMasterName,
//         "image": image,
        
//     };
// }
