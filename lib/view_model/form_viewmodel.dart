import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/form_repository.dart';
import '../static/show_toast/showTost_msg.dart';

class FormViewmodel extends GetxController {
  var isLoading = false.obs;
// Rx<BarberListModel> allbarberModel =BarberListModel().obs;
// Rx<BarberDetailsModel> barberdetails =BarberDetailsModel().obs;

  // signup
    TextEditingController contactPhone = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController contactmessage = TextEditingController();
  TextEditingController contactemail = TextEditingController();
  // TextEditingController salonSeat = TextEditingController();
  // TextEditingController contactcount = TextEditingController();
  // TextEditingController salonLocation = TextEditingController();

  Future contact({required String inqeryType}) async {
    late bool rsp = false;
    isLoading(true);
    try {
        //      final prefs = await SharedPreferences.getInstance();
        // var  userId = await prefs.getString(
        //     'userId');
      var resp = await FormApiRepository().contactusREpo(name: contactName.text, message: contactmessage.text, phone: contactPhone.text, email: contactemail.text,inqeryType: inqeryType);
      print(resp);
      if (resp != null && !resp["error"]) {
        isLoading(false);
        cleancontactform();
        rsp = true;
        ShowToast(msg: resp["message"].toString());
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
  cleancontactform(){
    contactName.text="";
    contactPhone.text="";
    contactmessage.text="";
    contactemail.text="";
  }
}