// To parse this JSON data, do
//
//     final trendingBlogModel = trendingBlogModelFromJson(jsonString);

import 'dart:convert';

TrendingBlogModel trendingBlogModelFromJson(String str) => TrendingBlogModel.fromJson(json.decode(str));

String trendingBlogModelToJson(TrendingBlogModel data) => json.encode(data.toJson());

class TrendingBlogModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    TrendingBlogModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory TrendingBlogModel.fromJson(Map<String, dynamic> json) => TrendingBlogModel(
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
    String? bannerId;
    String? bannerTitle;
    String? description;
    String? orderby;
    String? image;

    Data({
        this.bannerId,
        this.bannerTitle,
        this.description,
        this.orderby,
        this.image,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bannerId: json["banner_id"],
        bannerTitle: json["banner_title"],
        description: json["description"],
        orderby: json["orderby"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "banner_title": bannerTitle,
        "description": description,
        "orderby": orderby,
        "image": image,
    };
}
