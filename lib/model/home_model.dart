// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    int? status;
    bool? error;
    Messages? messages;

    HomeModel({
        this.status,
        this.error,
        this.messages,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    List<City>? city;
    List<AddDtl>? bannerDtl;
    List<AddDtl>? trendingStyle;
    List<BlogDtl>? blogDtl;
    List<AddDtl>? addDtl;
    bool? reciveOrder;
    bool? centerFacilities;
    
    Mysalon? mysalon;
    LoginUser? loginUser;
    List<SalonService>? salonServices;

    Data({
        this.city,
        this.bannerDtl,
        this.trendingStyle,
        this.blogDtl,
        this.addDtl,
        this.reciveOrder,
        this.centerFacilities,
        this.mysalon,
        this.loginUser,
        this.salonServices,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        city: json["city"] == null ? [] : List<City>.from(json["city"]!.map((x) => City.fromJson(x))),
        bannerDtl: json["banner_dtl"] == null ? [] : List<AddDtl>.from(json["banner_dtl"]!.map((x) => AddDtl.fromJson(x))),
        trendingStyle: json["trending_style"] == null ? [] : List<AddDtl>.from(json["trending_style"]!.map((x) => AddDtl.fromJson(x))),
        blogDtl: json["blog_dtl"] == null ? [] : List<BlogDtl>.from(json["blog_dtl"]!.map((x) => BlogDtl.fromJson(x))),
        addDtl: json["add_dtl"] == null ? [] : List<AddDtl>.from(json["add_dtl"]!.map((x) => AddDtl.fromJson(x))),
        reciveOrder: json["recived_order"],
        centerFacilities: json["center_facilities"],
        mysalon: json["mysalon"] == null ? null : Mysalon.fromJson(json["mysalon"]),
        loginUser: json["login_user"] == null ? null : LoginUser.fromJson(json["login_user"]),
        salonServices: json["salon_services"] == null ? [] : List<SalonService>.from(json["salon_services"]!.map((x) => SalonService.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "city": city == null ? [] : List<dynamic>.from(city!.map((x) => x.toJson())),
        "banner_dtl": bannerDtl == null ? [] : List<dynamic>.from(bannerDtl!.map((x) => x.toJson())),
        "trending_style": trendingStyle == null ? [] : List<dynamic>.from(trendingStyle!.map((x) => x.toJson())),
        "blog_dtl": blogDtl == null ? [] : List<dynamic>.from(blogDtl!.map((x) => x.toJson())),
        "add_dtl": addDtl == null ? [] : List<dynamic>.from(addDtl!.map((x) => x.toJson())),
        "recived_order":reciveOrder,
        "center_facilities": centerFacilities,
        "mysalon": mysalon?.toJson(),
        "login_user": loginUser?.toJson(),
        "salon_services": salonServices == null ? [] : List<dynamic>.from(salonServices!.map((x) => x.toJson())),
    };
}

class AddDtl {
    String? bannerId;
    String? orderby;
    String? image;

    AddDtl({
        this.bannerId,
        this.orderby,
        this.image,
    });

    factory AddDtl.fromJson(Map<String, dynamic> json) => AddDtl(
        bannerId: json["banner_id"],
        orderby: json["orderby"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "orderby": orderby,
        "image": image,
    };
}

class BlogDtl {
  String? blogId;
    String? name;
    String? title;
    String? message;
    String? image;

    BlogDtl({
      this.blogId,
        this.name,
        this.title,
        this.message,
        this.image,
    });

    factory BlogDtl.fromJson(Map<String, dynamic> json) => BlogDtl(
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

class City {
    String? cityId;
    String? cityName;
    String? status;
    String? createdDate;
    String? updatedDate;

    City({
        this.cityId,
        this.cityName,
        this.status,
        this.createdDate,
        this.updatedDate,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        cityName: json["city_name"],
        status: json["status"],
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
        "status": status,
        "created_date": createdDate,
        "updated_date": updatedDate,
    };
}

class LoginUser {
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
    String? createdDate;
    String? updatedDate;
    String? ownerName;
    String? noOfSalonSeat;
    String? salonType;
    dynamic dob;

    LoginUser({
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
    });

    factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
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
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
        ownerName: json["owner_name"],
        noOfSalonSeat: json["no_of_salon_seat"],
        salonType: json["salon_type"],
        dob: json["dob"],
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
        "created_date": createdDate,
        "updated_date": updatedDate,
        "owner_name": ownerName,
        "no_of_salon_seat": noOfSalonSeat,
        "salon_type": salonType,
        "dob": dob,
    };
}

class Mysalon {
    int? barberCount;
    int? customerCount;
    dynamic totalSales;
    int? feedbackCount;
    int? todayOrderCount;
    int? todayCompleteOrder;
    int? todayPendingOrder;
    int? todayCancelOrder;
     String? lastorderuserName;

    Mysalon({
        this.barberCount,
        this.customerCount,
        this.totalSales,
        this.feedbackCount,
        this.todayOrderCount,
        this.todayCompleteOrder,
        this.todayPendingOrder,
        this.todayCancelOrder,
        this.lastorderuserName
    });

    factory Mysalon.fromJson(Map<String, dynamic> json) => Mysalon(
        barberCount: json["Barber_count"],
        customerCount: json["Customer_count"],
        totalSales: json["Total_sales"],
        feedbackCount: json["Feedback_count"],
        todayOrderCount: json["Today_order_count"],
        todayCompleteOrder: json["Today_complete_order"],
        todayPendingOrder: json["Today_pending_order"],
        todayCancelOrder: json["todayCancelOrder"],
        lastorderuserName: json["last_order_user_name"],
    );

    Map<String, dynamic> toJson() => {
        "Barber_count": barberCount,
        "Customer_count": customerCount,
        "Total_sales": totalSales,
        "Feedback_count": feedbackCount,
        "Today_order_count": todayOrderCount,
        "Today_complete_order": todayCompleteOrder,
        "Today_pending_order": todayPendingOrder,
        "todayCancelOrder": todayCancelOrder,
        "last_order_user_name":lastorderuserName
    };
}

class SalonService {
    String? centerServiceId;
    String? serviceId;
    String? servicePrice;
    String? serviceName;
    String? serviceTime;
    bool isSelected;
    String? serviceTimeInMinutes;

    SalonService({
        this.centerServiceId,
        this.serviceId,
        this.servicePrice,
        this.serviceName,
        this.serviceTime,
        this.isSelected=false,
        this.serviceTimeInMinutes
    });

    factory SalonService.fromJson(Map<String, dynamic> json) => SalonService(
        centerServiceId: json["center_service_id"],
        serviceId: json["service_id"],
        servicePrice: json["service_price"],
        serviceName: json["service_name"],
        serviceTime: json["service_time"],
        serviceTimeInMinutes: json["service_time_in_minutes"]
    );

    Map<String, dynamic> toJson() => {
        "center_service_id": centerServiceId,
        "service_id": serviceId,
        "service_price": servicePrice,
        "service_name": serviceName,
        "service_time": serviceTime,
        "is_selected":isSelected,
        "service_time_in_minutes": serviceTimeInMinutes
    };
    
}
