

import 'package:dio/dio.dart';

import '../data/app_url.dart';
import '../data/network/api_helper.dart';

class FormApiRepository {
 Future contactusREpo({
    required String name,
    required String message,
    required String phone,
    required String email,
    required String inqeryType
  }) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'message': message,
        'contactno': phone,
        'email': email,
        'inquerry_type':inqeryType
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.contactusForm, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}