import 'dart:async';
import 'dart:io';
import 'package:dizisalon_vender/model/salontype_model.dart' show Gender, GetAllSalonTypeModel;
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import '../model/home_model.dart';
import '../repository/auth_repository.dart';

class AuthViewmodel extends GetxController {
  var isLoading = false.obs;
  // login
  TextEditingController phone = TextEditingController();
   TextEditingController otpController = TextEditingController();
  Rx<String> otp = "".obs;
  
// signup
  TextEditingController sownerName = TextEditingController();
  TextEditingController ssalonname = TextEditingController();
  TextEditingController sphone = TextEditingController();
  TextEditingController semail = TextEditingController();
  TextEditingController sotp = TextEditingController();
  Rx<String> otpbyphone = "".obs;
  Rx<bool> phonesendOtp = false.obs;
   Rx<bool> verifiedPhone = false.obs;
   Rx<Gender> selectedGender=Gender().obs;
  //tresend
   var start = 30.obs;
  var canResend = false.obs;
  Timer? _timer;
  //Update Salon Profile
  TextEditingController upsownerName = TextEditingController();
  TextEditingController upssalonname = TextEditingController();
  TextEditingController upsphone = TextEditingController();
  TextEditingController upsemail = TextEditingController();
  Rx<Gender> upselectedGender=Gender().obs;
  final ImagePicker _picker = ImagePicker();
    Rx<File?> uploadlogoPick = Rx<File?>(null);
    Rx<GetAllSalonTypeModel> salontypemodel=GetAllSalonTypeModel().obs;

// TextEditingController sforgetnpass= TextEditingController();
  // @override
  // void onInit() {
  //   viewAllorder();
  //   super.onInit();
  // }
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
        otp.value=resp["messages"]["status"]["Otp"].toString();
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
  Future login() async {
    late bool rsp = false;
    isLoading(true);
    try {
      var token = await getDeviceTokenToSendNotification();
      var resp = await AuthApiRepository()
          .loginRepo(phone: phone.text,deviceToken: token??"");
      print(resp);
      if (resp != null && !resp["error"] ) {//&& !resp["error"]
        isLoading(false);
        rsp = true;
        otp.value=resp["messages"]["status"]["login_otp"].toString();
        // allorder.value = AllOrderModel.fromJson(resp);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'userId', resp["messages"]["status"]["user_id"].toString());
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
   Future<String?> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    return token;
    // deviceTokenToSendPushNotification = token.toString();
    print("Token Value ${token.toString()}");
  }
 Future otpVerify() async {
    late bool rsp = false;
    isLoading(true);
    try {
      var resp = await AuthApiRepository()
          .verifyOtp(phone: phone.text);
      print(resp);
      if (resp != null ) {
        isLoading(false);
        rsp = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'userId', resp["messages"]["status"]["user_id"].toString());
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

  //  Future updateProfile() async {
  //   isLoading(true);
  //   // print(name.text);
  //   try {
  //     var resp = await ProfileReopoository().updateProfile(user_id: "18", full_name: name.text, e_mail: email.text, profileImage: null);
  //     if (resp != null) {
  //       isLoading(false);
  //      viewProfile();
  //       // categoryModel.value = CategoryModel.fromJson(resp);
  //       // print(resp);
  //       // transactions(resp);
  //     }
  //   } catch (e) {debugPrint(e.toString());} finally {
  //     isLoading(false);
  //   }
  // }
  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('phoneNumber');
    //  await prefs.remove('address');
    await prefs.remove('userId');
    return true;
  }

  Future signup() async {
    late bool rsp = false;
    isLoading(true);
    try {
      //  if(phone.text==null||phone.text.isEmpty){
      //   ShowToast(msg: "First Enter Mobile Number");
      //  } if (phone.text.length!=10) {
      //     ShowToast(msg: "First Enter 10 digit mobile Number");
      //   } else {
      var resp = await AuthApiRepository().signupREpo(salonName: ssalonname.text.toString(),name: sownerName.text.toString(),phone: sphone.text.toString(),email: semail.text.toString(),salonType: selectedGender.value.id.toString());
      print(resp);
      if (resp != null && !resp["error"]) {
        isLoading(false);
        rsp = true;
         ShowToast(msg: resp["message"].toString());
        clearSignup();
        // allorder.value = AllOrderModel.fromJson(resp);
        //       final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('phoneNumber', phone.text);
        // forgetnpasContact.text =resp["messages"]["status"]["login_otp"].toString();
       
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
  updateGender(Gender gender){
    selectedGender.value =gender;
    print(selectedGender.value);
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
signupseendOtp(String contact){
getOtp(contact: contact).then((v){
  sotp.text=v;
  otpbyphone.value=v;
  phonesendOtp.value=true;
});
}
void startTimer(String contact) {
  canResend.value = false;
  start.value = 30;
  _timer?.cancel();

  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (start.value > 0) {
      start.value--;
    } else {
      signupseendOtp(contact);
      canResend.value = true;
      _timer?.cancel(); // ✅ Safe again
      start.value = 30;
    }
  });
}
  updatevisible() {
    print("Update visible click");
  }

  clearSignup() {
    ssalonname.clear();
    sownerName.clear();
    sphone.clear();
    semail.clear();
    selectedGender.value=Gender();
    sotp.clear();
    phonesendOtp.value=false;
    verifiedPhone.value=false;
    update();
  }
  initprofile(LoginUser? user){
upssalonname.text=user?.fullName??"";
upsownerName.text =user?.ownerName??"";
upsemail.text=user?.email??"";
upsphone.text=user?.contactNo??"";
upselectedGender.value = user?.salonType==null?Gender():salontypemodel.value.data!.gender!.firstWhere((v)=>v.id==user?.salonType,orElse: () => Gender(),) ;
upselectedGender.refresh();
  }
   upupdateGender(Gender gender){
    upselectedGender.value =gender;
    print(selectedGender.value);
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
     uploadlogoPick.value = File(pickedFile.path);
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }
  Future updateProfile() async {
    late bool rsp = false;
    isLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
      var resp = await AuthApiRepository().updateProfileREpo(userId: userId!, salonName: upssalonname.text.toString(),name: upsownerName.text.toString(),phone: upsphone.text, email: upsemail.text.toString(),salonType: upselectedGender.value.id.toString(),logoimage: uploadlogoPick.value == null
            ? ""
            : dio.MultipartFile.fromFileSync(uploadlogoPick.value!.path,
                filename: uploadlogoPick.value!.path.split('/').last));
      print(resp);
      if (resp != null && !resp["error"]) {
        isLoading(false);
        rsp = true;
        print(resp);
        clearSignup();
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
    Future viewallsalontype() async {
    late bool rsp =false;
    isLoading(true);
    try {
        //       final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await AuthApiRepository().Allgender();
      print(resp);
      if (resp != null && !resp["error"]) {//&& !resp["error"]
        isLoading(false);
        salontypemodel.value=GetAllSalonTypeModel.fromJson(resp);
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
