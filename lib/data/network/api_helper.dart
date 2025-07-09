import 'dart:io';


import 'package:dio/dio.dart';

import '../app_url.dart';
import '../response/exception.dart';
import '../response/response_check.dart';

class NetworkApiService {
  var dio = Dio();
  Future<dynamic> getApi({required String urll}) async {
    late var jsonResponse;
    try {
      var response = await await dio.get("${AppUrl.baseUrl}${urll}");
      // print(response);
      jsonResponse = checkREsponse(response);
    } on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }

  Future postApi({required url, required FormData formData}) async {
    late var jsonResponse;

    try {
      var response = await dio.post("${AppUrl.baseUrl}${url}",
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
          data: formData);
      // print(response);
      jsonResponse = checkREsponse(response);
    } on DioException catch (e) {
  // The request was made and the server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  if (e.response != null) {
    print(e.response?.data);
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    print(e.requestOptions);
    print(e.message);
  }} on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }
}
