// To parse this JSON data, do
//
//     final trendingStyleModel = trendingStyleModelFromJson(jsonString);

import 'dart:convert';

TrendingStyleModel trendingStyleModelFromJson(String str) => TrendingStyleModel.fromJson(json.decode(str));

String trendingStyleModelToJson(TrendingStyleModel data) => json.encode(data.toJson());

class TrendingStyleModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    TrendingStyleModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory TrendingStyleModel.fromJson(Map<String, dynamic> json) => TrendingStyleModel(
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
    List<TrendingStyle>? trendingStyle;

    Data({
        this.trendingStyle,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        trendingStyle: json["trending_style"] == null ? [] : List<TrendingStyle>.from(json["trending_style"]!.map((x) => TrendingStyle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "trending_style": trendingStyle == null ? [] : List<dynamic>.from(trendingStyle!.map((x) => x.toJson())),
    };
}

class TrendingStyle {
    String? bannerId;
    String? bannerTitle;
    String? bannerSubtitle;
    String? description;
    String? urrl;
    String? type;
    String? orderby;
    String? image;
    String? createdDate;
    String? updatedDate;

    TrendingStyle({
        this.bannerId,
        this.bannerTitle,
        this.bannerSubtitle,
        this.description,
        this.urrl,
        this.type,
        this.orderby,
        this.image,
        this.createdDate,
        this.updatedDate,
    });

    factory TrendingStyle.fromJson(Map<String, dynamic> json) => TrendingStyle(
        bannerId: json["banner_id"],
        bannerTitle: json["banner_title"],
        bannerSubtitle: json["banner_subtitle"],
        description: json["description"],
        urrl: json["urrl"],
        type: json["type"],
        orderby: json["orderby"],
        image: json["image"],
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
    );

    Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "banner_title": bannerTitle,
        "banner_subtitle": bannerSubtitle,
        "description": description,
        "urrl": urrl,
        "type": type,
        "orderby": orderby,
        "image": image,
        "created_date": createdDate,
        "updated_date": updatedDate,
    };
}
