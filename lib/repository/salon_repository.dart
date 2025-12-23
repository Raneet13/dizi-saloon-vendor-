import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dizisalon_vender/model/all_facilities_model.dart' as facilities;
import 'package:dizisalon_vender/model/all_services_model.dart' as service;
import '../../data/app_url.dart';
import '../../data/network/api_helper.dart';
import '../model/all_services_model.dart';

class SalonApiRepository {
  //login Repository
   Future allfacilitiesSalon() async {
    late var response;

    try {
      // FormData formData =
      //     FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .getApi(urll: AppUrl.allFacilities);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
    Future allservices({required String salontype}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'salon_type': salontype});
      response = await NetworkApiService()
          .postApi(url: AppUrl.service,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
  //kyc 
   Future removeGalleryImage({required String galleryId}) async {
    late var response;

    try {
   FormData formData =
          FormData.fromMap({'center_gallery_id': galleryId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.removeGaleryImage, formData: formData);
      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   
   Future updateKycSalon({
    required String userId,
    required String salonName,
    required String updateUserId,
    required String salonAddress,
    required String state,
    required String city,
    required String pincode,
     required dynamic logoimage,
      required dynamic addrprofimage,
      required List<dynamic> salonimages,
      String? lat,
      String?lng,
    required String openTime,
    required String closeTime,
    required String launchTime,
    required String launchTimeClose,
   required String noSeat,
   required List<facilities.Datum> allFacility,
   required List<Map<String,bool>> weakSelection,
   
    // 
  }) async {
    late var response;

    try {
      Map<String, dynamic> formMap = {
        'user_id':userId,
'salon_name':salonName,
'salon_address':salonAddress,
'state':state,
'city_id':city,
'pincode':pincode,
'logo_image':logoimage,
'address_proof':addrprofimage,
'lat':lat,
'lng':lng,
// services[0][id]:1
// services[0][price]:150
'open_time':openTime,
'close_time':closeTime,
'lunch_time':launchTime,
'lunch_time_end':launchTimeClose,
'no_of_salon_seat':noSeat
      };
//       for (int i = 0; i < services.length; i++) {
//   formMap['services[$i][id]'] = services[i]['id'].toString();
//   formMap['services[$i][price]'] = services[i]['price'].toString();
// }
  if (updateUserId !="") {
        formMap['update_user_id']=updateUserId;
      }
    for (int i = 0; i < allFacility.length; i++) {
      formMap['facilities[$i]'] = allFacility[i].facilitiesId.toString();
    }
   for (int i = 0; i < salonimages.length; i++) {
  formMap['salon_images[$i]'] = salonimages[i];
}
 for (int i = 0; i < weakSelection.length; i++) {
  formMap['available_days[$i]'] = weakSelection[i].keys.first.toString();
}

// Now create FormData
FormData formData = FormData.fromMap(formMap);
print(formData.fields.map((e) => '${e.key}: ${e.value}').toList());
      response = await NetworkApiService()
          .postApi(url: AppUrl.kycSubmit, formData: formData);
    print(formData.fields.map((e) => '${e.key}: ${e.value}').toList());

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   
   
   
   
   Future addServiceSalon({required String userId,required List<service.Datum> services}) async {
    late var response;

    try {
        Map<String, dynamic> formMap = {'user_id': userId};
      //   'user_id':userId,
      // FormData formData =
      //     FormData.fromMap({});
             for (int i = 0; i < services.length; i++) {
   final service = services[i];
  if (service != null) {
    formMap['services[$i]'] = service.serviceMasterId.toString();
  }
}

FormData formData = FormData.fromMap(formMap);
      response = await NetworkApiService()
          .postApi(url: AppUrl.addSalonService, formData: formData);
      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future orderListRepo({required String userId, String? appoinmentI}) async {
    late var response;

    try {
   FormData formData =
          FormData.fromMap({'user_id': userId,'apointment_id':appoinmentI??""});
      response = await NetworkApiService()
          .postApi(url: AppUrl.orderList, formData: formData);
      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future allreview({required String userId}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'center_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.getCenterReview,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
  Future updateBooking({required String appontId,required String sts}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'appointment_id': appontId,'status':sts});
      response = await NetworkApiService()
          .postApi(url: AppUrl.updateOrderSts,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
    Future generateQrcode({required String orderId,required String customer}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'order_id': orderId,'coust_name':customer});
      response = await NetworkApiService()
          .postApi(url: AppUrl.generateQr,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
     Future salonserviceRepo({required String userId}) async {
    late var response;

    try {
   FormData formData =
          FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.salonService, formData: formData);
      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future updateService({required String serviceId,required String centerId,String? price,required String serciceStatus,String?time}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': centerId,'service_id':serviceId,'pricing':price,'sercice_status':serciceStatus,'timing':time});
      response = await NetworkApiService()
          .postApi(url: AppUrl.updateserviceStatus,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future updateServiceBarber({required String serviceId,required String centerId,String? price,required String serciceStatus}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': centerId,'service_id':serviceId,'pricing':price,'sercice_status':serciceStatus});
      response = await NetworkApiService()
          .postApi(url: AppUrl.updateserviceStatus,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
     Future updatesalonService({required String serviceId,required String centerId,required String serciceStatus}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': centerId,'service_id':serviceId,'sercice_status':serciceStatus});
      response = await NetworkApiService()
          .postApi(url: AppUrl.salonupdateserviceStatus,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
     Future removeGalleryimage({required String galleryId}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'center_gallery_id': galleryId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.removeGaleryImage,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}