
import 'dart:async';
import 'dart:io';
import 'package:dizisalon_vender/repository/barber_repository.dart';
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import '../model/all_services_model.dart';
import '../model/barberdetails_model.dart';
import '../model/barberlist_model.dart';
import '../model/home_model.dart';
import '../repository/auth_repository.dart';

class BarberViewmodel extends GetxController {
  var isLoading = false.obs;
Rx<BarberListModel> allbarberModel =BarberListModel().obs;
Rx<BarberDetailsModel> barberdetails =BarberDetailsModel().obs;
 RxList<Barber> barbersearchList =<Barber>[].obs;
 TextEditingController barberserch = TextEditingController();

  // signup
    TextEditingController barberphone = TextEditingController();
  TextEditingController baberName = TextEditingController();
  TextEditingController barbaerAdd = TextEditingController();
  TextEditingController barberstate = TextEditingController();
  TextEditingController babercity = TextEditingController();
  TextEditingController baberpin = TextEditingController();
  TextEditingController salonSeat = TextEditingController();
  TextEditingController babercount = TextEditingController();
  TextEditingController salonLocation = TextEditingController();
  TextEditingController sotp = TextEditingController();
   RxList<SalonService> selectedServices =<SalonService>[].obs;
  // List<SalonService> selectedServices
  RxString barberlogo ="".obs;
  Rx<String> otpbyphone = "".obs;
  Rx<bool> phonesendOtp = false.obs;
   Rx<bool> verifiedPhone = false.obs;
     Rx<TimeOfDay?> fromTime=TimeOfDay(hour: 10,minute: 0).obs;
  Rx<TimeOfDay?> toTime=TimeOfDay(hour: 22,minute: 0).obs;
  final ImagePicker _picker = ImagePicker();
    Rx<File?> uploadPick = Rx<File?>(null);
     var start = 30.obs;
  var canResend = false.obs;
  Timer? _timer;


    //get otp
     Future getOtp({required String contact}) async {
    late String rsp = "";
    isLoading(true);
    try {
      var resp = await AuthApiRepository()
          .getOtprepo(phone: contact);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        rsp = resp["messages"]["status"]["Otp"].toString();
        // otp.value=resp["messages"]["status"]["Otp"].toString();
        // allorder.value = AllOrderModel.fromJson(resp);
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString(
        //     'userId', resp["messages"]["user"]["id"].toString());
        // forgetnpasContact.text =resp["messages"]["user"]["id"].toString();
        // ShowToast(msg: resp["messages"]["status"]["login_otp"].toString());
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
  signupseendOtp(String contact){
getOtp(contact: contact).then((v){
  sotp.text=v;
  otpbyphone.value=v;
  phonesendOtp.value=true;
});
}

verifyPhone(){
  if (sotp.text.isEmpty||sotp.text.length<4) {
    ShowToast(msg: "Please Enter 4 Digit OTP");
  }else if (sotp.text.toString()==otpbyphone.value) {
  verifiedPhone.value=true;
}else{
  ShowToast(msg: "Enter Correct Otp");
}
}
void startTimer(String contact) {
  canResend.value = false;
  start.value = 10;
  _timer?.cancel();

  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (start.value > 0) {
      start.value--;
    } else {
      signupseendOtp(contact);
      canResend.value = true;
      _timer?.cancel(); // ✅ Safe again
    }
  });
}


 Future<void> selectTime({required BuildContext context,required bool isFrom}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
     
        if (isFrom) {
          fromTime.value = picked;
          print(fromTime.value);
        } else {
          toTime.value = picked;
        }
    }
  }
   insertFituredImage(BuildContext context) {
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
                  _pickImage(ImageSource.gallery);
                  // context.pop();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                   Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
        source: source, maxWidth: 400, imageQuality: 45);

    if (pickedFile != null) {
      // final imageFile = File(pickedFile.path);
      // final imageSize = await imageFile.length();
      // ToastUtil.showToast(msg: extension);
     uploadPick.value = File(pickedFile.path);
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }
  //all Barber list
   Future allBarber() async {
    late bool rsp =false;
    isLoading(true);
    try {
              final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await BarrberApiRepository().allbarberList(userId: userId!);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        allbarberModel.value=BarberListModel.fromJson(resp);
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
  Future viewdetailsBarber({required String barberId}) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await BarrberApiRepository().viewdetailsBarber(userId: barberId);
      print(resp);
      if (resp != null && !resp["error"]) {//&& !resp["error"]
        isLoading(false);
        barberdetails.value=BarberDetailsModel.fromJson(resp);
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
   Future barberRegister(List<SalonService> services,String updateUserId) async {
    late bool rsp = false;
    // isLoading(true);
    print(updateUserId);
    try {
             final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await BarrberApiRepository().addBarberRepo(
        userId: userId!,
         barbername: baberName.text.toString(), 
         barberAddress: barbaerAdd.text.toString(), state: barberstate.text, city: babercity.text, pincode: baberpin.text,
          openTime: "${fromTime.value!.hour.toString()}:${fromTime.value!.minute.toString()}:00", closeTime: "${toTime.value!.hour.toString()}:${toTime.value!.minute.toString()}:00", contactNo: barberphone.text.toString(),
           image:  uploadPick.value == null
            ? ""
            : dio.MultipartFile.fromFileSync(uploadPick.value!.path,
                filename: uploadPick.value!.path.split('/').last), services: services,updateUserId: updateUserId);
      print(resp);
      if (resp != null && !resp["error"]) {
        isLoading(false);
        rsp = true;
        // print(resp);
       await allBarber();
        clearBarberfield();
       await Get.find<HomeViewmodel>().home();
        // allorder.value = AllOrderModel.fromJson(resp);
        //       final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('phoneNumber', phone.text);
        // forgetnpasContact.text =resp["messages"]["status"]["login_otp"].toString();
        ShowToast(msg: resp["message"].toString());
      } else {
        ShowToast(msg: resp["message"].toString());
      }
    } catch (e) {
      
      ShowToast(msg: e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
  clearBarberfield(){
baberName.text="";
barberphone.text="";
barbaerAdd.text="";
barberstate.text="";
babercity.text="";
baberpin.text="";
uploadPick.value=null;
fromTime.value=TimeOfDay(hour: 10,minute: 0);
 toTime.value=TimeOfDay(hour: 22,minute: 0);
 selectedServices.value=[];
 verifiedPhone.value=false;
 sotp.text="";
  otpbyphone.value="";
  phonesendOtp.value=false;
 refresh();
  }
    Future deleteBarber({required String barberId}) async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await BarrberApiRepository().deleteBarber(barberId: barberId);
      // print(resp);
      if (resp != null && !resp["error"]) {//&& !resp["error"]
        isLoading(false);
        allBarber();
        // barberdetails.value=BarberDetailsModel.fromJson(resp);
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

barberservice(List<SalonService>?  salonSErvice){
  // selectedServices.value.refresh();
  selectedServices.value = salonSErvice!
                            .where((service) => service.isSelected)
                            .toList();
}

initBarber(BarberDetailsModel? barber)async{
  print(barber?.messages?.data?.services?.first.toJson());
baberName.text =barber?.messages?.data?.singleBarber?.fullName??"";
barberphone.text =barber?.messages?.data?.singleBarber?.contactNo??"";
barbaerAdd.text =barber?.messages?.data?.singleBarber?.address1??"";
babercity.text =barber?.messages?.data?.singleBarber?.cityId??"";
baberpin.text =barber?.messages?.data?.singleBarber?.pin??"";
barberstate.text =barber?.messages?.data?.singleBarber?.state??"";
fromTime.value =parseTimeOfDay(barber?.messages?.data?.centerTimings?.first.fromtime??"");
toTime.value =parseTimeOfDay(barber?.messages?.data?.centerTimings?.first.totime??"");
barberlogo.value=barber?.messages?.data?.singleBarber?.profileImage??"";
  verifiedPhone.value=true;
selectedServices.value=(barber?.messages?.data?.services ?? [])
    .where((service) => service.isSelected == false)
    .toList();
// await barberservice(barber?.messages?.data?.services??[]);
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
 removeService(SalonService serrvic){
selectedServices.remove(serrvic);
refresh();
  }
  
  Future barberupdateStatus({required String barberId,required String sts}) async {
    late String rsp = "";
    isLoading(true);
    try {
      var resp = await BarrberApiRepository()
          .updatebaeber(barberId: barberId, status: sts);
      print(resp);
      if (resp != null ) {//&& !resp["error"]
        isLoading(false);
        viewdetailsBarber(barberId: barberId);
        // rsp = resp["messages"]["status"]["Otp"].toString();
        // otp.value=resp["messages"]["status"]["Otp"].toString();
        // allorder.value = AllOrderModel.fromJson(resp);
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString(
        //     'userId', resp["messages"]["user"]["id"].toString());
        // forgetnpasContact.text =resp["messages"]["user"]["id"].toString();
        ShowToast(msg: resp["messages"]["message"].toString());
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

  //
  Future searchBarber({required String search}) async {
    late bool rsp =false;
    isLoading(true);
    try {
    
      List<Barber> result = allbarberModel.value.data?.barber
    ?.where((item) =>
        (item.fullName ?? '').toLowerCase().contains(search.toLowerCase()))
    .toList() ?? [];

      barbersearchList.value=result;
      barbersearchList.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
    return rsp;
  }
    
}