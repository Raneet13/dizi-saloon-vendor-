import 'dart:convert';

import 'package:dio/dio.dart';

import '../../data/app_url.dart';
import '../../data/network/api_helper.dart';
import '../model/all_services_model.dart';
import '../model/home_model.dart';

class BarrberApiRepository {
  //login Repository
   Future allbarberList({
    required String userId
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.barberList, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

 Future viewdetailsBarber({
    required String userId
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.singleBarber, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  } 
   Future deleteBarber({
    required String barberId
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': barberId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.deleteBarber, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  } 
   Future updatebaeber({
    required String barberId,
    required String status
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': barberId,'status':status});
      response = await NetworkApiService()
          .postApi(url: AppUrl.userstatusUpdate, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  } 
  Future addBarberRepo({
    required String userId,
    required String barbername,
    required String updateUserId,
    required String barberAddress,
    required String state,
    required String city,
    required String pincode,
    required String openTime,
    required String closeTime,
    required String contactNo,
    required dynamic image,
    required List<SalonService> services
  }) async {
    late var response;
 String serviceTimeInMinutes(String time) {
   int totalMinutes = int.tryParse(time) ?? 0;
  Duration duration = Duration(minutes: totalMinutes);

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = twoDigits(duration.inHours);
  String mins = twoDigits(duration.inMinutes.remainder(60));
  String secs = twoDigits(duration.inSeconds.remainder(60));

  return "$hours:$mins:$secs";
  }
    try {
      Map<String, dynamic> formMap = {
        'user_id':userId,
'salon_name':barbername,
'salon_address':barberAddress,
'state':state,
'city_id':city,
'pincode':pincode,
// services[0][id]:1
// services[0][price]:150
'open_time':openTime,
'close_time':closeTime,
'contact_no':contactNo,
'profile_image':image
      };
      if (updateUserId!="") {
        formMap['update_user_id']=updateUserId;
      }
      for (int i = 0; i < services.length; i++) {
  formMap['services[$i][id]'] = services[i].serviceId.toString();
  formMap['services[$i][price]'] = services[i].servicePrice.toString();
   formMap['services[$i][service_time]'] = serviceTimeInMinutes(services[i].serviceTimeInMinutes.toString());
}

// Now create FormData
FormData formData = FormData.fromMap(formMap);
      response = await NetworkApiService()
          .postApi(url: AppUrl.addBarber, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }   
}