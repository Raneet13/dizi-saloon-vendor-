// To parse this JSON data, do
//
//     final latestArticleModel = latestArticleModelFromJson(jsonString);

import 'dart:convert';

LatestArticleModel latestArticleModelFromJson(String str) => LatestArticleModel.fromJson(json.decode(str));

String latestArticleModelToJson(LatestArticleModel data) => json.encode(data.toJson());

class LatestArticleModel {
    int? status;
    bool? error;
    String? message;
    Data? data;

    LatestArticleModel({
        this.status,
        this.error,
        this.message,
        this.data,
    });

    factory LatestArticleModel.fromJson(Map<String, dynamic> json) => LatestArticleModel(
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
    List<LatestArticle>? latestArticles;

    Data({
        this.latestArticles,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        latestArticles: json["latest_articles"] == null ? [] : List<LatestArticle>.from(json["latest_articles"]!.map((x) => LatestArticle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "latest_articles": latestArticles == null ? [] : List<dynamic>.from(latestArticles!.map((x) => x.toJson())),
    };
}

class LatestArticle {
    String? blogId;
    String? name;
    String? title;
    String? message;
    String? category;
    String? image;
    DateTime? date;
    String? createdAt;

    LatestArticle({
        this.blogId,
        this.name,
        this.title,
        this.message,
        this.category,
        this.image,
        this.date,
        this.createdAt,
    });

    factory LatestArticle.fromJson(Map<String, dynamic> json) => LatestArticle(
        blogId: json["blog_id"],
        name: json["name"],
        title: json["title"],
        message: json["message"],
        category: json["category"],
        image: json["image"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "name": name,
        "title": title,
        "message": message,
        "category": category,
        "image": image,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
    };
}
