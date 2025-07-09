
import 'dart:async';
import 'dart:io';
import 'package:dizisalon_vender/model/all_services_model.dart' as service;
import 'package:dizisalon_vender/model/home_model.dart';
import 'package:dizisalon_vender/model/my_service_model.dart';
import 'package:dizisalon_vender/repository/barber_repository.dart';
import 'package:dizisalon_vender/repository/salon_repository.dart';
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import '../model/all_facilities_model.dart' as facilities;
import '../model/all_review_model.dart';
import '../model/barberdetails_model.dart';
import '../model/barberlist_model.dart' hide Barber;
import '../model/orderlist_model.dart';
import '../repository/auth_repository.dart';

class SalonViewmodel extends GetxController {
  var isLoading = false.obs;
  Rx<BarberDetailsModel> salondetails =BarberDetailsModel().obs;
Rx<facilities.AllFacilitiesModel> allFacilities =facilities.AllFacilitiesModel().obs;
Rx<service.AllServicesModel> allService =service.AllServicesModel().obs;
Rx<OrderListModel> allOrderlist =OrderListModel().obs;
Rx<AllReviewModel> centerallReview =AllReviewModel().obs;
RxString qrhtml ="".obs;
Rx<MyserviceModel> salonService =MyserviceModel().obs;
Rx<Datum> salonServiceSelection =Datum().obs;
//barberserviceupdate
  TextEditingController priceController = TextEditingController();
   TextEditingController timeController = TextEditingController();


  // signup
    TextEditingController salonName = TextEditingController();
  TextEditingController salonAddr = TextEditingController();
  TextEditingController salonrstate = TextEditingController();
  TextEditingController saloncity = TextEditingController();
  TextEditingController salonpin = TextEditingController();
    Rx<TimeOfDay?> openTime =TimeOfDay(hour: 10,minute: 0).obs;
  Rx<TimeOfDay?> closeTime =TimeOfDay(hour: 22,minute: 0).obs;
  Rx<TimeOfDay?> launchTime =TimeOfDay(hour: 13,minute: 0).obs;
  final ImagePicker _picker = ImagePicker();
    Rx<File?> salonLogo = Rx<File?>(null);
      Rx<File?> salonaddressProof = Rx<File?>(null);
    Rx<List<File?>> salonImages = Rx<List<File?>>([]);
    RxString salonLogo_kyc = RxString("");
      RxString salonaddressProof_kyc = RxString("");
    Rx<List<String>> salonImages_kyc = Rx<List<String>>([]);
    RxList<Map<String, bool>> weekSelection = List.generate(7, (index) => {"SMTWTFS".split('')[index]: false}).obs;

  TextEditingController salonSeat = TextEditingController();
  TextEditingController babercount = TextEditingController();
  TextEditingController salonLocation = TextEditingController();
  initkyc()async{
    salonName.text=salondetails.value.messages?.data?.singleBarber?.fullName??"";
    salonAddr.text=salondetails.value.messages?.data?.singleBarber?.address1??"";
    salonrstate.text=salondetails.value.messages?.data?.singleBarber?.state??"";
    saloncity.text=salondetails.value.messages?.data?.singleBarber?.cityId??"";
    salonpin.text=salondetails.value.messages?.data?.singleBarber?.pin??"";
    salonSeat.text=salondetails.value.messages?.data?.singleBarber?.noOfSalonSeat??"";
    salonLogo_kyc.value=salondetails.value.messages?.data?.singleBarber?.logoImage??"";
    salonaddressProof_kyc.value=salondetails.value.messages?.data?.singleBarber?.adharFont??"";
    salonImages_kyc.value=salondetails.value.messages?.data?.centerGallery?.map((e) => e.centeImage.toString()).toList()??[];
    openTime.value=parseTimeOfDay(salondetails.value.messages?.data?.centerTimings?.first.fromtime??"");
    closeTime.value=parseTimeOfDay(salondetails.value.messages?.data?.centerTimings?.first.totime??"");
    launchTime.value=parseTimeOfDay(salondetails.value.messages?.data?.centerTimings?.first.lunchTime??"");
    weekSelection.value=await List.generate(7, (index) {
      String day = "SMTWTFS".split('')[index];
      bool isSelected = salondetails.value.messages?.data?.centerTimings?.any((dayy)=>dayy.day.toString()==day) ?? false;
      return {day: isSelected};
    });
    allFacilities.value=await facilities.AllFacilitiesModel(
      status: 1,
      error: false,
      message: "Facilities",
      data:allFacilities.value.data?.map((facility) {
    final isMatched = salondetails.value.messages?.data?.centerFacilities?.any(
      (center) => center.facilitiesId == facility.facilitiesId,
    );

    return facilities.Datum(
      facilitiesId: facility.facilitiesId,
      facilitiesName: facility.facilitiesName,
      image: facility.image,
      isSelect: isMatched??false,
    );
  }).toList() ?? []
    );
    refresh();
  }
    

  TimeOfDay parseTimeOfDay(String timeStr) {
  final parts = timeStr.split(":");
  if (parts.length != 3) throw FormatException("Invalid time format");
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  //  final second = int.parse(parts[1]);
  // TimeOfDay does not store seconds, so they are ignored.
  return TimeOfDay(hour: hour, minute: minute);
}

  Future viewSalondetails({required String barberId}) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await BarrberApiRepository().viewdetailsBarber(userId: barberId);
      // print(resp);
      if (resp != null && !resp["error"]) {//&& !resp["error"]
        isLoading(false);
        salondetails.value=BarberDetailsModel.fromJson(resp);
        await initkyc();
        rsp =true;
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
    Future allFacilitiesList() async {
    late bool rsp =false;
    isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await SalonApiRepository().allfacilitiesSalon();
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        allFacilities.value=facilities.AllFacilitiesModel.fromJson(resp);
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
  //Alservice
   Future allServiceList({required String salonType}) async {
    late bool rsp =false;
    isLoading(true);
    try {
              // final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await SalonApiRepository().allservices(salontype: salonType);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        allService.value=service.AllServicesModel.fromJson(resp);
        rsp =true;
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
  //update Facilities
//   updateSalonfacilities(String index,bool isSelected){
// allFacilities.value.data?.where((v)=>v.facilitiesId==index?v.isSelect=isSelected:v);
//   }

  // image pick 
    insertFituredImage(BuildContext context,String imageName) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Choose the medium of your Image"),
            actions: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery,imageName);
                  // context.pop();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera,imageName);
                   Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  Future<void> _pickImage(ImageSource source,String imageNam) async {
    // final LostDataResponse response = await _picker.retrieveLostData();
    final pickedFile = await _picker.pickImage(
        source: source, maxWidth: 400, imageQuality: 45);
     


    if (pickedFile != null) {
      //  final String processedPath = await compute(processImageInIsolate, pickedFile.path);
      // final imageFile = File(pickedFile.path);
      // final imageSize = await imageFile.length();
      // ToastUtil.showToast(msg: extension);
      if (imageNam=="logo") {
        //  if (!mounted) return;
     salonLogo.value = File(pickedFile.path);   
      } else {
        salonaddressProof.value = File(pickedFile.path);
      }
     
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }

    Future<List<File>> getImages() async {
     final pickedFiles = await _picker.pickMultiImage(imageQuality: 100);
     if (pickedFiles != null && pickedFiles.isNotEmpty) {
       salonImages.value= pickedFiles.map((xFile) => File(xFile.path)).toList();
     }
     return [];
   }
   removeImage(int index){
    salonImages.value.removeAt(index);
    salonImages.refresh();
    refresh();
   }
   //timechoose
   Future<void> selectTime({required BuildContext context,required String time}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
     
        if (time=="open") {
          openTime.value = picked;
          // print(fromTime.value);
        } else if(time=="close") {
          closeTime.value = picked;
        }else if(time=="launch"){
          launchTime.value=picked;
        }
    }
  }
  Future kycSubmit(String updateUserId) async {
    late bool rsp = false;
    isLoading(true);
    List<Map<String, bool>> selectedWeekList = weekSelection.value.where((item) {
  return item.values.first == true;
}).toList();
 List<facilities.Datum> selectedfacilitiesList =  allFacilities.value.data!.where((item) {
  return item.isSelect == true;
}).toList();
List<dynamic> salonGaleryImage = [];
for (var i = 0; i < salonImages.value.length; i++) {
  salonGaleryImage.add(dio.MultipartFile.fromFileSync(salonImages.value[i]!.path,
                filename: salonImages.value[i]!.path.split('/').last));
}
if (selectedWeekList.length==0) {
  isLoading(false);
  ShowToast(msg: "first Select your Week of day Salon Open");
  
}else if(selectedfacilitiesList.length==0){
  isLoading(false);
  ShowToast(msg: "first Select Facilities Your Salon Provide");
  
}else if(salonaddressProof.value==null){
   isLoading(false);
  ShowToast(msg: "first upload your address proof document");
 
}else if(salonGaleryImage.length==0){
   isLoading(false);
  ShowToast(msg: "first upload At list one Galary Image for yollur Salon");
 
}else if(salonLogo.value==null){
   isLoading(false);
  ShowToast(msg: "first upload your Salon Logo  / Salon Image");
 
}else{
  
    try {
             final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await SalonApiRepository().updateKycSalon(userId: userId!, 
      salonName: salonName.text, salonAddress: salonAddr.text, state: salonrstate.text, city: saloncity.text, pincode: salonpin.text, logoimage: dio.MultipartFile.fromFileSync(salonLogo.value!.path,
                filename: salonLogo.value!.path.split('/').last), addrprofimage: dio.MultipartFile.fromFileSync(salonaddressProof.value!.path,
                filename: salonaddressProof.value!.path.split('/').last), salonimages: salonGaleryImage, openTime: openTime.value!.hour.toString(), closeTime: closeTime.value!.hour.toString(), launchTime: launchTime.value!.hour.toString(), noSeat: salonSeat.text, allFacility: selectedfacilitiesList, weakSelection: selectedWeekList, updateUserId: updateUserId);
      print(resp);
      if (resp != null && !resp["error"]) {
        isLoading(false);
        rsp = true;
        print(resp);
        // clearSignup();
        // allorder.value = AllOrderModel.fromJson(resp);
        //       final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('phoneNumber', phone.text);
        // forgetnpasContact.text =resp["messages"]["status"]["login_otp"].toString();
        ShowToast(msg: resp["message"].toString());
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
}
  

    return rsp;
  }
  //salonServiceList
   Future salonServiceAdd() async {
    late bool rsp = false;
    isLoading(true);
    
 List<service.Datum> selectedserviceList =  allService.value.data!.where((item) {
  return item.isSelected == true;
}).toList();


    try {
             final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await SalonApiRepository().addServiceSalon(userId: userId!, services: selectedserviceList);
      print(resp);
      if (resp != null && !resp["error"]) {
        isLoading(false);
        rsp = true;
        print(resp);
        // clearSignup();
        // allorder.value = AllOrderModel.fromJson(resp);
        //       final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('phoneNumber', phone.text);
        // forgetnpasContact.text =resp["messages"]["status"]["login_otp"].toString();
        ShowToast(msg: resp["messages"]["status"].toString());
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
  //all Order
    Future allOrderList() async {
    late bool rsp =false;
    isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await SalonApiRepository().orderListRepo(userId: userId!);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        allOrderlist.value=OrderListModel.fromJson(resp);
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
     Future allreviewList() async {
    late bool rsp =false;
    isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await SalonApiRepository().allreview(userId: userId!);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        centerallReview.value=AllReviewModel.fromJson(resp);
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
   Future updateOrder({required String apontId,required String status}) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await SalonApiRepository().updateBooking(appontId: apontId, sts: status);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        // allOrderlist.value=OrderListModel.fromJson(resp);
        allOrderList();
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

     Future generateQr({required String orderId,required String customerName}) async {
     var rsp=true;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await SalonApiRepository().generateQrcode(orderId: orderId,customer: customerName);
      print(resp);
      // if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        qrhtml.value=resp;
        // allOrderlist.value=OrderListModel.fromJson(resp);
        // allOrderList();
        // resp =true;
        // rsp=resp;
      // } else {
      //   ShowToast(msg: resp["message"].toString());
      // }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }

void setservice(List<SalonService>? listSErvice)async{
   allService.value=await service.AllServicesModel(
      status: 1,
      error: false,
      message: "services",
      data:allService.value.data?.map((servic) {
    final isMatched = listSErvice?.any(
      (center) => center.serviceId == servic.serviceMasterId,
    );

    return service.Datum(
       serviceMasterId: servic.serviceMasterId,
       genderId: servic.genderId,
    serviceMasterName: servic.serviceMasterName,
    serviceType: servic.serviceType,
    image: servic.serviceMasterId,
  isSelected: isMatched??false,
    price: servic.serviceMasterId,
    status: servic.status,
    );
  }).toList() ?? []
    );
    allFacilities.refresh();
    
}
  Future salonAllservice() async {
    late bool rsp =false;
    isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await SalonApiRepository().salonserviceRepo(userId: userId!);
      // print(resp);
      if (resp != null && !resp["error"]) {//&& !resp["error"]
        isLoading(false);
        salonService.value=MyserviceModel.fromJson(resp);
        salonServiceSelection.value=salonService.value.messages?.data?.first??Datum();
        // await initkyc();
        rsp =true;
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
  Future changedSalonService(Datum service)async{
    salonServiceSelection.value=service;
    // return Future.value(true);
  }
    Future updateService(
{required String serviceId,required String centerId,String? price,required String serciceStatus,String?time}
    ) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await SalonApiRepository().updateService(serviceId: serviceId, centerId: centerId, serciceStatus: serciceStatus,time: time,price: price);
      print(resp);
      if (resp != null && !resp["error"]) {//&& !resp["error"]
        isLoading(false);
        salonAllservice();
        // salonService.value=MyserviceModel.fromJson(resp);
        // salonServiceSelection.value=salonService.value.messages?.data?.first??Datum();
        // await initkyc();
        rsp =true;
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
    initserviceprrandtime(Barber? barberdetails){
    priceController.text = barberdetails?.barServicePrice??"";
    timeController.text =barberdetails?.barServiceTiming??"";
    // salonServiceSelection.value=Datum();
    refresh();
  }
  clearbarberservice(){
    priceController.clear();
    timeController.clear();
    // salonServiceSelection.value=Datum();
    refresh();
  }
 
}