// To parse this JSON data, do
//
//     final barberListModel = barberListModelFromJson(jsonString);

import 'dart:convert';

BarberListModel barberListModelFromJson(String str) => BarberListModel.fromJson(json.decode(str));

String barberListModelToJson(BarberListModel data) => json.encode(data.toJson());

class BarberListModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    BarberListModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory BarberListModel.fromJson(Map<String, dynamic> json) => BarberListModel(
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
    List<Barber>? barber;

    Data({
        this.barber,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        barber: json["Barber"] == null ? [] : List<Barber>.from(json["Barber"]!.map((x) => Barber.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Barber": barber == null ? [] : List<dynamic>.from(barber!.map((x) => x.toJson())),
    };
}

class Barber {
    String? id;
    String? fullName;
    dynamic userName;
    dynamic password;
    String? email;
    String? contactNo;
    dynamic gender;
    String? alterCnum;
    String? profileImage;
    dynamic centerName;
    dynamic details;
    dynamic centerRedgProof;
    dynamic gst;
    dynamic gstImage;
    dynamic adharFont;
    dynamic adharBack;
    dynamic adharNo;
    String? userType;
    String? userId;
    dynamic state;
    String? cityId;
    String? areaId;
    dynamic pin;
    dynamic address1;
    dynamic address2;
    dynamic commition;
    dynamic bannerImage;
    dynamic logoImage;
    dynamic hygene;
    dynamic acciesType;
    dynamic status;
    dynamic reasone;
    String? wallet;
    dynamic otp;
    dynamic lat;
    dynamic lng;
    dynamic roles;
    dynamic accountDetails;
    dynamic benefName;
    dynamic merchantAgrrement;
    dynamic avarageRating;
    String? createdDate;
    String? updatedDate;
    dynamic ownerName;
    dynamic noOfSalonSeat;
    dynamic salonType;
    dynamic dob;
    String? timingId;
    String? centerId;
    String? fromtime;
    String? totime;
    dynamic lunchTime;
    dynamic day;
    dynamic sequence;
    dynamic serviceId;
    dynamic appoinmentCount;
    dynamic presentStatus;
    Barber({
        this.id,
        this.fullName,
        this.userName,
        this.password,
        this.email,
        this.contactNo,
        this.gender,
        this.alterCnum,
        this.profileImage,
        this.centerName,
        this.details,
        this.centerRedgProof,
        this.gst,
        this.gstImage,
        this.adharFont,
        this.adharBack,
        this.adharNo,
        this.userType,
        this.userId,
        this.state,
        this.cityId,
        this.areaId,
        this.pin,
        this.address1,
        this.address2,
        this.commition,
        this.bannerImage,
        this.logoImage,
        this.hygene,
        this.acciesType,
        this.status,
        this.reasone,
        this.wallet,
        this.otp,
        this.lat,
        this.lng,
        this.roles,
        this.accountDetails,
        this.benefName,
        this.merchantAgrrement,
        this.avarageRating,
        this.createdDate,
        this.updatedDate,
        this.ownerName,
        this.noOfSalonSeat,
        this.salonType,
        this.dob,
        this.timingId,
        this.centerId,
        this.fromtime,
        this.totime,
        this.lunchTime,
        this.day,
        this.sequence,
        this.serviceId,
        this.appoinmentCount,
        this.presentStatus,
    });

    factory Barber.fromJson(Map<String, dynamic> json) => Barber(
        id: json["id"],
        fullName: json["full_name"],
        userName: json["user_name"],
        password: json["password"],
        email: json["email"],
        contactNo: json["contact_no"],
        gender: json["gender"],
        alterCnum: json["alter_cnum"],
        profileImage: json["profile_image"],
        centerName: json["center_name"],
        details: json["details"],
        centerRedgProof: json["center_redg_proof"],
        gst: json["gst"],
        gstImage: json["gst_image"],
        adharFont: json["adhar_font"],
        adharBack: json["adhar_back"],
        adharNo: json["adhar_no"],
        userType: json["user_type"],
        userId: json["user_id"],
        state: json["state"],
        cityId: json["city_id"],
        areaId: json["area_id"],
        pin: json["pin"],
        address1: json["address1"],
        address2: json["address2"],
        commition: json["commition"],
        bannerImage: json["banner_image"],
        logoImage: json["logo_image"],
        hygene: json["hygene"],
        acciesType: json["accies_type"],
        status: json["status"],
        reasone: json["reasone"],
        wallet: json["wallet"],
        otp: json["otp"],
        lat: json["lat"],
        lng: json["lng"],
        roles: json["roles"],
        accountDetails: json["account_details"],
        benefName: json["benef_name"],
        merchantAgrrement: json["merchant_agrrement"],
        avarageRating: json["avarage_rating"],
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
        ownerName: json["owner_name"],
        noOfSalonSeat: json["no_of_salon_seat"],
        salonType: json["salon_type"],
        dob: json["dob"],
        timingId: json["timing_id"],
        centerId: json["center_id"],
        fromtime: json["fromtime"],
        totime: json["totime"],
        lunchTime: json["lunch_time"],
        day: json["day"],
        sequence: json["sequence"],
        serviceId: json["service_id"],
        appoinmentCount: json["today_appointment_count"],
        presentStatus: json["present_status"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "user_name": userName,
        "password": password,
        "email": email,
        "contact_no": contactNo,
        "gender": gender,
        "alter_cnum": alterCnum,
        "profile_image": profileImage,
        "center_name": centerName,
        "details": details,
        "center_redg_proof": centerRedgProof,
        "gst": gst,
        "gst_image": gstImage,
        "adhar_font": adharFont,
        "adhar_back": adharBack,
        "adhar_no": adharNo,
        "user_type": userType,
        "user_id": userId,
        "state": state,
        "city_id": cityId,
        "area_id": areaId,
        "pin": pin,
        "address1": address1,
        "address2": address2,
        "commition": commition,
        "banner_image": bannerImage,
        "logo_image": logoImage,
        "hygene": hygene,
        "accies_type": acciesType,
        "status": status,
        "reasone": reasone,
        "wallet": wallet,
        "otp": otp,
        "lat": lat,
        "lng": lng,
        "roles": roles,
        "account_details": accountDetails,
        "benef_name": benefName,
        "merchant_agrrement": merchantAgrrement,
        "avarage_rating": avarageRating,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "owner_name": ownerName,
        "no_of_salon_seat": noOfSalonSeat,
        "salon_type": salonType,
        "dob": dob,
        "timing_id": timingId,
        "center_id": centerId,
        "fromtime": fromtime,
        "totime": totime,
        "lunch_time": lunchTime,
        "day": day,
        "sequence": sequence,
        "service_id": serviceId,
        "today_appointment_count":appoinmentCount,
        "present_status":appoinmentCount,
    };
}
