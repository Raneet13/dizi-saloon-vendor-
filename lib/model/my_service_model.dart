// To parse this JSON data, do
//
//     final myserviceModel = myserviceModelFromJson(jsonString);

import 'dart:convert';

MyserviceModel myserviceModelFromJson(String str) => MyserviceModel.fromJson(json.decode(str));

String myserviceModelToJson(MyserviceModel data) => json.encode(data.toJson());

class MyserviceModel {
    int? status;
    bool? error;
    Messages? messages;

    MyserviceModel({
        this.status,
        this.error,
        this.messages,
    });

    factory MyserviceModel.fromJson(Map<String, dynamic> json) => MyserviceModel(
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
    List<Datum>? data;

    Messages({
        this.responsecode,
        this.data,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        responsecode: json["responsecode"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responsecode": responsecode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? centerServiceId;
    String? serviceId;
    String? servicePrice;
    dynamic serviceTime;
    String? serviceName;
    String? centerId;
    dynamic status;
    List<Barber>? barbers;

    Datum({
        this.centerServiceId,
        this.serviceId,
        this.servicePrice,
        this.serviceTime,
        this.serviceName,
        this.centerId,
        this.status,
        this.barbers,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        centerServiceId: json["center_service_id"],
        serviceId: json["service_id"],
        servicePrice: json["service_price"],
        serviceTime: json["service_time"],
        serviceName: json["service_name"],
        centerId: json["center_id"],
        status: json["status"],
        barbers: json["barbers"] == null ? [] : List<Barber>.from(json["barbers"]!.map((x) => Barber.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "center_service_id": centerServiceId,
        "service_id": serviceId,
        "service_price": servicePrice,
        "service_time": serviceTime,
        "service_name": serviceName,
        "center_id": centerId,
        "status": status,
        "barbers": barbers == null ? [] : List<dynamic>.from(barbers!.map((x) => x.toJson())),
    };
}

class Barber {
    String? barberServiceId;
    String? serviceId;
    String? barberId;
    String? barberUserId;
    String? barberName;
    String? barberContact;
    String? barServicePrice;
    String? barServiceTiming;
    dynamic barServiceStatus;

    Barber({
        this.barberServiceId,
        this.serviceId,
        this.barberId,
        this.barberUserId,
        this.barberName,
        this.barberContact,
        this.barServicePrice,
        this.barServiceTiming,
        this.barServiceStatus,
    });

    factory Barber.fromJson(Map<String, dynamic> json) => Barber(
        barberServiceId: json["barber_service_id"],
        serviceId: json["service_id"],
        barberId: json["barber_id"],
        barberUserId: json["barber_user_id"],
        barberName: json["barber_name"],
        barberContact: json["barber_contact"],
        barServicePrice: json["bar_service_price"],
        barServiceTiming: json["bar_service_timing"],
        barServiceStatus: json["bar_service_status"],
    );

    Map<String, dynamic> toJson() => {
        "barber_service_id": barberServiceId,
        "service_id": serviceId,
        "barber_id": barberId,
        "barber_user_id": barberUserId,
        "barber_name": barberName,
        "barber_contact": barberContact,
        "bar_service_price": barServicePrice,
        "bar_service_timing": barServiceTiming,
        "bar_service_status": barServiceStatus,
    };
}
