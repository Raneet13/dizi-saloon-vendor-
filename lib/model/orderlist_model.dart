// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
    int? status;
    bool? error;
    Messages? messages;

    OrderListModel({
        this.status,
        this.error,
        this.messages,
    });

    factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
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
    List<Appointment>? appointments;

    Messages({
        this.responsecode,
        this.appointments,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        responsecode: json["responsecode"],
        appointments: json["appointments"] == null ? [] : List<Appointment>.from(json["appointments"]!.map((x) => Appointment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responsecode": responsecode,
        "appointments": appointments == null ? [] : List<dynamic>.from(appointments!.map((x) => x.toJson())),
    };
}

class Appointment {
    String? orderId;
    String? createdAt;
    String? appointmentId;
    String? apointmentDate;
    String? barberId;
    String? barberName;
    String? barberPhone;
    String? salonId;
    String? salonName;
    String? salonPhone;
    dynamic salonProfileImage;
    String? salonLatitude;
    String? salonLongitude;
    String? customerLatitude;
    String? customerLongitude;
    String? userId;
    String? customerName;
    String? customerContact;
    String? customerProfile;
    bool? isRated;
    String? distance;
    String? isConfirm;
    String? timeSlut;
    List<Service>? services;

    Appointment({
        this.orderId,
        this.createdAt,
        this.appointmentId,
        this.apointmentDate,
        this.barberId,
        this.barberName,
        this.barberPhone,
        this.salonId,
        this.salonName,
        this.salonPhone,
        this.salonProfileImage,
        this.salonLatitude,
        this.salonLongitude,
        this.customerLatitude,
        this.customerLongitude,
        this.userId,
        this.customerName,
        this.customerContact,
        this.customerProfile,
        this.isRated,
        this.distance,
        this.isConfirm,
        this.timeSlut,
        this.services,
    });

    factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        orderId: json["order_id"],
        createdAt: json["created_at"],
        appointmentId: json["appointment_id"],
        apointmentDate: json["apointment_date"],
        barberId: json["barber_id"],
        barberName: json["barber_name"],
        barberPhone: json["barber_phone"],
        salonId: json["salon_id"],
        salonName: json["salon_name"],
        salonPhone: json["salon_phone"],
        salonProfileImage: json["salon_profile_image"],
        salonLatitude: json["salon_latitude"],
        salonLongitude: json["salon_longitude"],
        customerLatitude: json["customer_latitude"],
        customerLongitude: json["customer_longitude"],
        userId: json["user_id"],
        customerName: json["customer_name"],
        customerContact: json["customer_contact"],
        customerProfile: json["customer_profile"],
        isRated: json["is_rated"],
        distance: json["distance"],
        isConfirm: json["is_confirm"],
        timeSlut: json["time_slut"],
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "created_at": createdAt,
        "appointment_id": appointmentId,
        "apointment_date": apointmentDate,
        "barber_id": barberId,
        "barber_name": barberName,
        "barber_phone": barberPhone,
        "salon_id": salonId,
        "salon_name": salonName,
        "salon_phone": salonPhone,
        "salon_profile_image": salonProfileImage,
        "salon_latitude": salonLatitude,
        "salon_longitude": salonLongitude,
        "customer_latitude": customerLatitude,
        "customer_longitude": customerLongitude,
        "user_id": userId,
        "customer_name": customerName,
        "customer_contact": customerContact,
        "customer_profile": customerProfile,
        "is_rated": isRated,
        "distance": distance,
        "is_confirm": isConfirm,
        "time_slut": timeSlut,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    };
}

class Service {
    String? serviceId;
    String? serviceName;
    String? price;

    Service({
        this.serviceId,
        this.serviceName,
        this.price,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["service_id"],
        serviceName: json["service_name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "service_name": serviceName,
        "price": price,
    };
}
