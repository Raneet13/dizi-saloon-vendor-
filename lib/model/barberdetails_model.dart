// To parse this JSON data, do
//
//     final barberDetailsModel = barberDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dizisalon_vender/model/home_model.dart';

BarberDetailsModel barberDetailsModelFromJson(String str) => BarberDetailsModel.fromJson(json.decode(str));

String barberDetailsModelToJson(BarberDetailsModel data) => json.encode(data.toJson());

class BarberDetailsModel {
    int? status;
    bool? error;
    Messages? messages;

    BarberDetailsModel({
        this.status,
        this.error,
        this.messages,
    });

    factory BarberDetailsModel.fromJson(Map<String, dynamic> json) => BarberDetailsModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"] == null ? null : Messages.fromJson(json["messages"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages?.toJson(),
    };
}

class Messages {
    String? responsecode;
    Data? data;

    Messages({
        this.responsecode,
        this.data,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        responsecode: json["responsecode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "responsecode": responsecode,
        "data": data?.toJson(),
    };
}

class Data {
    SingleBarber? singleBarber;
    List<CenterTiming>? centerTimings;
    List<CenterGallery>? centerGallery;
    List<CenterFacility>? centerFacilities;
    List<SalonService>? services;
    List<dynamic>? reviews;

    Data({
        this.singleBarber,
        this.centerTimings,
        this.centerGallery,
        this.centerFacilities,
        this.services,
        this.reviews,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        singleBarber: json["single_barber"] == null ? null : SingleBarber.fromJson(json["single_barber"]),
        centerTimings: json["center_timings"] == null ? [] : List<CenterTiming>.from(json["center_timings"]!.map((x) => CenterTiming.fromJson(x))),
        centerGallery: json["center_gallery"] == null ? [] : List<CenterGallery>.from(json["center_gallery"]!.map((x) => CenterGallery.fromJson(x))),
        centerFacilities: json["center_facilities"] == null ? [] : List<CenterFacility>.from(json["center_facilities"]!.map((x) => CenterFacility.fromJson(x))),
        services: json["services"] == null ? [] : List<SalonService>.from(json["services"]!.map((x) => SalonService.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "single_barber": singleBarber?.toJson(),
        "center_timings": centerTimings == null ? [] : List<dynamic>.from(centerTimings!.map((x) => x.toJson())),
        "center_gallery": centerGallery == null ? [] : List<dynamic>.from(centerGallery!.map((x) => x.toJson())),
        "center_facilities": centerFacilities == null ? [] : List<dynamic>.from(centerFacilities!.map((x) => x.toJson())),
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    };
}

class CenterFacility {
    String? centerFacilitiesId;
    String? centerId;
    String? facilitiesId;
    String? facilitiesName;

    CenterFacility({
        this.centerFacilitiesId,
        this.centerId,
        this.facilitiesId,
        this.facilitiesName,
    });

    factory CenterFacility.fromJson(Map<String, dynamic> json) => CenterFacility(
        centerFacilitiesId: json["center_facilities_id"],
        centerId: json["center_id"],
        facilitiesId: json["facilities_id"],
        facilitiesName: json["facilities_name"],
    );

    Map<String, dynamic> toJson() => {
        "center_facilities_id": centerFacilitiesId,
        "center_id": centerId,
        "facilities_id": facilitiesId,
        "facilities_name": facilitiesName,
    };
}

class CenterGallery {
    String? centerGalleryId;
    String? centeImage;
    String? centerId;
    DateTime? createdDate;

    CenterGallery({
        this.centerGalleryId,
        this.centeImage,
        this.centerId,
        this.createdDate,
    });

    factory CenterGallery.fromJson(Map<String, dynamic> json) => CenterGallery(
        centerGalleryId: json["center_gallery_id"],
        centeImage: json["cente_image"],
        centerId: json["center_id"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    );

    Map<String, dynamic> toJson() => {
        "center_gallery_id": centerGalleryId,
        "cente_image": centeImage,
        "center_id": centerId,
        "created_date": createdDate?.toIso8601String(),
    };
}

class CenterTiming {
    String? timingId;
    String? centerId;
    String? fromtime;
    String? totime;
    String? lunchTime;
    String? day;
    dynamic sequence;
    dynamic serviceId;
    dynamic status;
    DateTime? createdDate;
    DateTime? updatedDate;

    CenterTiming({
        this.timingId,
        this.centerId,
        this.fromtime,
        this.totime,
        this.lunchTime,
        this.day,
        this.sequence,
        this.serviceId,
        this.status,
        this.createdDate,
        this.updatedDate,
    });

    factory CenterTiming.fromJson(Map<String, dynamic> json) => CenterTiming(
        timingId: json["timing_id"],
        centerId: json["center_id"],
        fromtime: json["fromtime"],
        totime: json["totime"],
        lunchTime: json["lunch_time"],
        day: json["day"],
        sequence: json["sequence"],
        serviceId: json["service_id"],
        status: json["status"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        updatedDate: json["updated_date"] == null ? null : DateTime.parse(json["updated_date"]),
    );

    Map<String, dynamic> toJson() => {
        "timing_id": timingId,
        "center_id": centerId,
        "fromtime": fromtime,
        "totime": totime,
        "lunch_time": lunchTime,
        "day": day,
        "sequence": sequence,
        "service_id": serviceId,
        "status": status,
        "created_date": createdDate?.toIso8601String(),
        "updated_date": updatedDate?.toIso8601String(),
    };
}

class Service {
    String? centerServiceId;
    String? serviceId;
    String? servicePrice;
    dynamic serviceTime;
    String? serviceName;
    String? serviceTimeInMinutes;
    Service({
        this.centerServiceId,
        this.serviceId,
        this.servicePrice,
        this.serviceTime,
        this.serviceName,
        this.serviceTimeInMinutes
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        centerServiceId: json["center_service_id"],
        serviceId: json["service_id"],
        servicePrice: json["service_price"],
        serviceTime: json["service_time"],
        serviceName: json["service_name"],
        serviceTimeInMinutes: json["service_time_in_minutes"]
    );

    Map<String, dynamic> toJson() => {
        "center_service_id": centerServiceId,
        "service_id": serviceId,
        "service_price": servicePrice,
        "service_time": serviceTime,
        "service_name": serviceName,
        "service_time_in_minutes":serviceTimeInMinutes
    };
}

class SingleBarber {
    String? id;
    String? fullName;
    dynamic userName;
    dynamic password;
    String? email;
    String? contactNo;
    dynamic gender;
    dynamic alterCnum;
    dynamic profileImage;
    dynamic centerName;
    dynamic details;
    dynamic centerRedgProof;
    dynamic gst;
    dynamic gstImage;
    String? adharFont;
    dynamic adharBack;
    dynamic adharNo;
    String? userType;
    dynamic userId;
    String? state;
    String? cityId;
    dynamic areaId;
    String? pin;
    String? address1;
    dynamic address2;
    dynamic commition;
    dynamic bannerImage;
    String? logoImage;
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
    DateTime? createdDate;
    DateTime? updatedDate;
    String? ownerName;
    String? noOfSalonSeat;
    String? salonType;
    dynamic dob;
    dynamic presentStatus;
    SingleBarber({
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
        this.presentStatus
    });

    factory SingleBarber.fromJson(Map<String, dynamic> json) => SingleBarber(
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
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        updatedDate: json["updated_date"] == null ? null : DateTime.parse(json["updated_date"]),
        ownerName: json["owner_name"],
        noOfSalonSeat: json["no_of_salon_seat"],
        salonType: json["salon_type"],
        dob: json["dob"],
        presentStatus: json["present_status"],
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
        "created_date": createdDate?.toIso8601String(),
        "updated_date": updatedDate?.toIso8601String(),
        "owner_name": ownerName,
        "no_of_salon_seat": noOfSalonSeat,
        "salon_type": salonType,
        "dob": dob,
        "present_status":presentStatus
    };
}
