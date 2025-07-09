import 'dart:convert';

import 'package:dio/dio.dart';

import '../../data/app_url.dart';
import '../../data/network/api_helper.dart';

class HomeApiRepository {
  //login Repository
   Future homerepo({
    required String userId
  }) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.home, formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
     Future trendingstyleRepo() async {
    late var response;

    try {
      // FormData formData =
      //     FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .getApi(urll: AppUrl.trendingStyle);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
  Future latestArticleRepo() async {
    late var response;

    try {
      // FormData formData =
      //     FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .getApi(urll: AppUrl.latestArticleList);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future trendingdetailsRepo({required String id}) async {
    late var response;

    try {
       FormData formData =
          FormData.fromMap({'banner_id': id});
      response = await NetworkApiService()
          .postApi(url: AppUrl.trendingStyleDtls,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future latestblogRepo({required String blogId}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'blog_id': blogId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.latestArticleListDtls,formData: formData);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
   Future cmseRepo() async {
    late var response;

    try {
      // FormData formData =
      //     FormData.fromMap({'user_id': userId});
      response = await NetworkApiService()
          .getApi(urll: AppUrl.cms);

      // response = await loginOtpModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}