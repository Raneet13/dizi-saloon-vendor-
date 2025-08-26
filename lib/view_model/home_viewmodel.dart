import 'package:dizisalon_vender/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../model/cms_model.dart';
import '../model/home_model.dart';
import '../model/latest_blog_model.dart' as latestblog;
import '../model/latestarticle_model.dart';
import '../model/sale_chart_model.dart';
import '../model/trending_blog_model.dart';
import '../model/trendingstyle_model.dart';
import '../static/show_toast/showTost_msg.dart';

class HomeViewmodel extends GetxController {
  var isLoading = false.obs;
  Rx<HomeModel> homemodel =HomeModel().obs;
  Rx<TrendingStyleModel> trendingStylemodel =TrendingStyleModel().obs;
   Rx<LatestArticleModel> latestArticlemodel =LatestArticleModel().obs;
     Rx<TrendingBlogModel> trendingStyleDetails =TrendingBlogModel().obs;
   Rx<latestblog.LatestBlogModel> latestArticleDetailsmodel =latestblog.LatestBlogModel().obs;
    Rx<SaleChartModel> revenueChart =SaleChartModel().obs;
Rx<CmsModel> cmsemodel =CmsModel().obs;  
//search
RxList<TrendingStyle> trendingStyleSearch = <TrendingStyle>[].obs;
RxList<LatestArticle> latestblogSearch =<LatestArticle>[].obs;
//flowchart
Rx<DateTime?> startDate=DateTime.now().obs;
  Rx<DateTime?> endDate=DateTime.now().obs;
  List<String> allDates = [];


  List<String> _generateDateList(DateTime start, DateTime end) {
    List<String> dateList = [];
    DateTime current = start;
    final formatter = DateFormat('yyyy-MM-dd');

    while (!current.isAfter(end)) {
      dateList.add(formatter.format(current));
      current = current.add(const Duration(days: 1));
    }
    return dateList;
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate.value = args.value.startDate;
      endDate.value = args.value.endDate ?? args.value.startDate;

      // Generate list of dates from start to end
      // if (startDate.value != null && endDate.value != null) {
      //   allDates = _generateDateList(startDate.value!, endDate.value!);
      
      // }
    }
  }
  
//signup
  // TextEditingController sphone = TextEditingController();
  // TextEditingController sforgetnpass = TextEditingController();
  // TextEditingController semail = TextEditingController();
  // TextEditingController sname = TextEditingController();
  // TextEditingController susername = TextEditingController();
// TextEditingController sforgetnpass= TextEditingController();
  // @override
  // void onInit() {
   
  //   super.onInit();
  // }
  Future home() async {
    late bool rsp =false;
    isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
            // ShowToast(msg: userId.toString());
      var resp = await HomeApiRepository().homerepo(userId: userId??"");
      // print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        homemodel.value=HomeModel.fromJson(resp);
        print(homemodel.value.toJson());
        rsp =true;
      } else {
        ShowToast(msg: resp["messages"]["status"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
   Future trendingstyle() async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await HomeApiRepository().trendingstyleRepo();
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        trendingStylemodel.value=TrendingStyleModel.fromJson(resp);
        resp =true;
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
    Future searchtrendingstyle({required String search}) async {
    late bool rsp =false;
    isLoading(true);
    try {
    
      List<TrendingStyle> result = trendingStylemodel.value.data?.trendingStyle
    ?.where((item) =>
        (item.bannerTitle ?? '').toLowerCase().contains(search.toLowerCase()))
    .toList() ?? [];

      trendingStyleSearch.value=result;
      trendingStyleSearch.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
    Future searchblogtyle({required String search}) async {
    late bool rsp =false;
    isLoading(true);
    try {
    
      List<LatestArticle> result = latestArticlemodel.value.data?.latestArticles?.where((item) =>
        (item.name ?? '').toLowerCase().contains(search.toLowerCase()))
    .toList() ?? [];

      latestblogSearch.value=result;
      latestblogSearch.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
  Future latestArticle() async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await HomeApiRepository().latestArticleRepo();
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        latestArticlemodel.value=LatestArticleModel.fromJson(resp);
        resp =true;
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
  //saleChart
   Future saleChart({required String fromDate, required String toDate ,bool? isload}) async {
    late bool rsp =false;
   isload==true?null: isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await HomeApiRepository().saleChartRepo(userId: userId!, fromDate:fromDate, toDate: toDate);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        
        revenueChart.value=SaleChartModel.fromJson(resp);
       isload==true?null: isLoading(false);
        resp =true;
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
     isload==true?null: isLoading(false);
    }
    return rsp;
  }
  //details
     Future trendingstyleDetails(String id) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await HomeApiRepository().trendingdetailsRepo(id: id);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        trendingStyleDetails.value=TrendingBlogModel.fromJson(resp);
        resp =true;
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
  Future latestArticleDetails({required String blogId}) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await HomeApiRepository().latestblogRepo(blogId: blogId);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        latestArticleDetailsmodel.value=latestblog.LatestBlogModel.fromJson(resp);
        resp =true;
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
  Future cmsArticle() async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await HomeApiRepository().cmseRepo();
      // print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        cmsemodel.value=CmsModel.fromJson(resp);
        resp =true;
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
  
}