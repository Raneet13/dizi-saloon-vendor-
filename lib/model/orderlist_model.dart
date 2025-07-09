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
    Appointments? appointments;

    Messages({
        this.responsecode,
        this.appointments,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        responsecode: json["responsecode"],
        appointments: json["appointments"] == null ? null : Appointments.fromJson(json["appointments"]),
    );

    Map<String, dynamic> toJson() => {
        "responsecode": responsecode,
        "appointments": appointments?.toJson(),
    };
}

class Appointments {
    List<OrderList>? orderList;

    Appointments({
        this.orderList,
    });

    factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
        orderList: json["order_list"] == null ? [] : List<OrderList>.from(json["order_list"]!.map((x) => OrderList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_list": orderList == null ? [] : List<dynamic>.from(orderList!.map((x) => x.toJson())),
    };
}

class OrderList {
    String? id;
    String? centerId;
    String? barberId;
    String? serviceId;
    String? userId;
    String? apointmentDate;
    String? timeIntervalStatus;
    String? remark;
    String? isConfirm;
    String? isDelete;
    String? price;
    String? createdAt;
    String? updatedAt;
    String? serviceName;
    String? barberName;
    String? barberPhone;
    String? userName;
    String? userPhone;
    String? profileImage;

    OrderList({
        this.id,
        this.centerId,
        this.barberId,
        this.serviceId,
        this.userId,
        this.apointmentDate,
        this.timeIntervalStatus,
        this.remark,
        this.isConfirm,
        this.isDelete,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.serviceName,
        this.barberName,
        this.barberPhone,
        this.userName,
        this.userPhone,
        this.profileImage,
    });

    factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        centerId: json["center_id"],
        barberId: json["barber_id"],
        serviceId: json["service_id"],
        userId: json["user_id"],
        apointmentDate: json["apointment_date"],
        timeIntervalStatus: json["time_interval_status"],
        remark: json["remark"],
        isConfirm: json["is_confirm"],
        isDelete: json["is_delete"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        serviceName: json["service_name"],
        barberName: json["barber_name"],
        barberPhone: json["barber_phone"],
        userName: json["user_name"],
        userPhone: json["user_phone"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "center_id": centerId,
        "barber_id": barberId,
        "service_id": serviceId,
        "user_id": userId,
        "apointment_date": apointmentDate,
        "time_interval_status": timeIntervalStatus,
        "remark": remark,
        "is_confirm": isConfirm,
        "is_delete": isDelete,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "service_name": serviceName,
        "barber_name": barberName,
        "barber_phone": barberPhone,
        "user_name": userName,
        "user_phone": userPhone,
        "profile_image": profileImage,
    };
}
