// To parse this JSON data, do
//
//     final cmsModel = cmsModelFromJson(jsonString);

import 'dart:convert';

CmsModel cmsModelFromJson(String str) => CmsModel.fromJson(json.decode(str));

String cmsModelToJson(CmsModel data) => json.encode(data.toJson());

class CmsModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    CmsModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory CmsModel.fromJson(Map<String, dynamic> json) => CmsModel(
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
    BarbarKyc? kyc;
    BarbarKyc? coustKyc;
    BarbarKyc? barbarKyc;
    BarbarKyc? serviceKyc;
    BarbarKyc? privacyPolicy;
    BarbarKyc? takeOrder;
    BarbarKyc? salonDetails;

    Data({
        this.kyc,
        this.coustKyc,
        this.barbarKyc,
        this.serviceKyc,
        this.privacyPolicy,
        this.takeOrder,
        this.salonDetails
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        kyc: json["Kyc"] == null ? null : BarbarKyc.fromJson(json["Kyc"]),
        coustKyc: json["Coust_kyc"] == null ? null : BarbarKyc.fromJson(json["Coust_kyc"]),
        barbarKyc: json["Barbar_Kyc"] == null ? null : BarbarKyc.fromJson(json["Barbar_Kyc"]),
        serviceKyc: json["Service_Kyc"] == null ? null : BarbarKyc.fromJson(json["Service_Kyc"]),
        privacyPolicy: json["Privacy_Policy"] == null ? null : BarbarKyc.fromJson(json["Privacy_Policy"]),
        takeOrder: json["Take_order"] == null ? null : BarbarKyc.fromJson(json["Take_order"]),
        salonDetails: json["salon_datils"] == null ? null : BarbarKyc.fromJson(json["salon_datils"]),
    );

    Map<String, dynamic> toJson() => {
        "Kyc": kyc?.toJson(),
        "Coust_kyc": coustKyc?.toJson(),
        "Barbar_Kyc": barbarKyc?.toJson(),
        "Service_Kyc": serviceKyc?.toJson(),
        "Privacy_Policy": privacyPolicy?.toJson(),
        "Take_order": takeOrder?.toJson(),
        "salon_datils": salonDetails?.toJson(),
    };
}

class BarbarKyc {
    String? id;
    String? pageName;
    String? details;
    String? image;
    dynamic address;
    dynamic phone;
    dynamic email;
    dynamic iframe;
    String? createdDate;
    String? updatedDate;
    String? pageTitle;
    String? pageKeyword;
    String? pageDescription;

    BarbarKyc({
        this.id,
        this.pageName,
        this.details,
        this.image,
        this.address,
        this.phone,
        this.email,
        this.iframe,
        this.createdDate,
        this.updatedDate,
        this.pageTitle,
        this.pageKeyword,
        this.pageDescription,
    });

    factory BarbarKyc.fromJson(Map<String, dynamic> json) => BarbarKyc(
        id: json["id"],
        pageName: json["page_name"],
        details: json["details"],
        image: json["image"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        iframe: json["iframe"],
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
        pageTitle: json["page_title"],
        pageKeyword: json["page_keyword"],
        pageDescription: json["page_description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "page_name": pageName,
        "details": details,
        "image": image,
        "address": address,
        "phone": phone,
        "email": email,
        "iframe": iframe,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "page_title": pageTitle,
        "page_keyword": pageKeyword,
        "page_description": pageDescription,
    };
}
