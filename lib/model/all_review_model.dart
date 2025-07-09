// To parse this JSON data, do
//
//     final allReviewModel = allReviewModelFromJson(jsonString);

import 'dart:convert';

AllReviewModel allReviewModelFromJson(String str) => AllReviewModel.fromJson(json.decode(str));

String allReviewModelToJson(AllReviewModel data) => json.encode(data.toJson());

class AllReviewModel {
    int? status;
    bool? error;
    Messages? messages;

    AllReviewModel({
        this.status,
        this.error,
        this.messages,
    });

    factory AllReviewModel.fromJson(Map<String, dynamic> json) => AllReviewModel(
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
    List<Review>? reviews;

    Messages({
        this.responsecode,
        this.reviews,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        responsecode: json["responsecode"],
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responsecode": responsecode,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    };
}

class Review {
    String? ratingReviewId;
    String? senderId;
    String? reciverId;
    String? review;
    String? rating;
    dynamic categoryId;
    String? ratingStatus;
    String? createdDate;
    String? senderName;
    String? senderContact;

    Review({
        this.ratingReviewId,
        this.senderId,
        this.reciverId,
        this.review,
        this.rating,
        this.categoryId,
        this.ratingStatus,
        this.createdDate,
        this.senderName,
        this.senderContact,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        ratingReviewId: json["rating_review_id"],
        senderId: json["sender_id"],
        reciverId: json["reciver_id"],
        review: json["review"],
        rating: json["rating"],
        categoryId: json["category_id"],
        ratingStatus: json["rating_status"],
        createdDate: json["created_date"],
        senderName: json["sender_name"],
        senderContact: json["sender_contact"],
    );

    Map<String, dynamic> toJson() => {
        "rating_review_id": ratingReviewId,
        "sender_id": senderId,
        "reciver_id": reciverId,
        "review": review,
        "rating": rating,
        "category_id": categoryId,
        "rating_status": ratingStatus,
        "created_date": createdDate,
        "sender_name": senderName,
        "sender_contact": senderContact,
    };
}
