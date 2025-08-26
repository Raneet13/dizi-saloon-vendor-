// To parse this JSON data, do
//
//     final saleChartModel = saleChartModelFromJson(jsonString);

import 'dart:convert';

SaleChartModel saleChartModelFromJson(String str) => SaleChartModel.fromJson(json.decode(str));

String saleChartModelToJson(SaleChartModel data) => json.encode(data.toJson());

class SaleChartModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    SaleChartModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory SaleChartModel.fromJson(Map<String, dynamic> json) => SaleChartModel(
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
    List<SalesDatum>? salesData;
    String? totalSales;

    Data({
        this.salesData,
        this.totalSales,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        salesData: json["sales_data"] == null ? [] : List<SalesDatum>.from(json["sales_data"]!.map((x) => SalesDatum.fromJson(x))),
        totalSales: json["total_sales"],
    );

    Map<String, dynamic> toJson() => {
        "sales_data": salesData == null ? [] : List<dynamic>.from(salesData!.map((x) => x.toJson())),
        "total_sales": totalSales,
    };
}

class SalesDatum {
    String? id;
    String? orderId;
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
    String? time;
    String? createdAt;
    String? updatedAt;

    SalesDatum({
        this.id,
        this.orderId,
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
        this.time,
        this.createdAt,
        this.updatedAt,
    });

    factory SalesDatum.fromJson(Map<String, dynamic> json) => SalesDatum(
        id: json["id"],
        orderId: json["order_id"],
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
        time: json["time"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
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
        "time": time,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
