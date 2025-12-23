
import 'package:dio/dio.dart';

import '../../data/app_url.dart';
import '../../data/network/api_helper.dart';

class AuthApiRepository {
  //login Repository
   Future getOtprepo({
    required String phone
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'contact': phone});
      response = await NetworkApiService()
          .postApi(url: AppUrl.GetOtop, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
  Future loginRepo({
    required String phone,
    required String deviceToken
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'contact': phone,'device_token':deviceToken});
      response = await NetworkApiService()
          .postApi(url: AppUrl.loginOtp, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future signupREpo({
    required String name,
    required String salonName,
    required String phone,
    required String email,
    required String salonType
  }) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'owner_name': name,
        'salon_name': salonName,
        'phone': phone,
        'email': email,
        'salon_type':salonType
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.resister, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

Future updateProfileREpo({
  required String userId,
    required String name,
    required String phone,
    required String salonName,
    required String email,
    required String salonType,
    required dynamic logoimage
  }) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'update_user_id':userId,
        'owner_name': name,
        'salon_name': salonName,
        'phone': phone,
        'email': email,
        'salon_type':salonType,
        'logo_image':logoimage
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.resister, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  //
  Future verifyOtp({
    required String phone,
  }) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'contact': phone});
      response = await NetworkApiService()
          .postApi(url: AppUrl.verifyOtp, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future Allgender() async {
    late var response;

    try {
      // FormData formData = FormData.fromMap({'contact': phone});
      response = await NetworkApiService()
          .getApi(urll: AppUrl.gender);
 print(response);
      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  
}
