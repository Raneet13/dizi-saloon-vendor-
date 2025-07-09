// To parse this JSON data, do
//
//     final latestBlogModel = latestBlogModelFromJson(jsonString);

import 'dart:convert';

LatestBlogModel latestBlogModelFromJson(String str) => LatestBlogModel.fromJson(json.decode(str));

String latestBlogModelToJson(LatestBlogModel data) => json.encode(data.toJson());

class LatestBlogModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    LatestBlogModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory LatestBlogModel.fromJson(Map<String, dynamic> json) => LatestBlogModel(
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
    String? blogId;
    String? name;
    String? title;
    String? message;
    String? image;

    Data({
        this.blogId,
        this.name,
        this.title,
        this.message,
        this.image,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        blogId: json["blog_id"],
        name: json["name"],
        title: json["title"],
        message: json["message"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "name": name,
        "title": title,
        "message": message,
        "image": image,
    };
}
