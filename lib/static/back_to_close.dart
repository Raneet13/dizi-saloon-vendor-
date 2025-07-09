// import 'package:back_button_interceptor/back_button_interceptor.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'show_toast/showTost_msg.dart';

// class backTocloseApp {
//   static DateTime? _lastBackPressed;
//   BuildContext context;
//   backTocloseApp(this.context);
//   Future<bool> myInterceptor(
//       bool stopDefaultButtonEvent, RouteInfo info) async {
//     DateTime now = DateTime.now();
//     // ShowToast(msg: "Back");
//     // return true;

//     if (_lastBackPressed == null ||
//         now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
//       _lastBackPressed = now;
//       final bottomController =Get.find<BottomNavController>();
//       print(bottomController.screen.value);
//       if (bottomController.screen.value.runtimeType ==HomeScreen||bottomController.screen.value.runtimeType ==ViewallCategoryScreen||bottomController.screen.value.runtimeType ==MayOrderScreen||bottomController.screen.value.runtimeType ==CheckoutScreen) {
//         print("Hello");
//          if (Get.isBottomSheetOpen ?? false) {
//   // A bottom sheet is open
//   // print("Bottom sheet is open!");
//   Get.back();
// } else{
//          ShowToast(msg: "Press Again To back");}
//       } else {
//         print("back to close");
//         // Get.back();
//         if (Get.isBottomSheetOpen ?? false) {
//   // A bottom sheet is open
//   // print("Bottom sheet is open!");
//   Get.back();
// } else{
  
//         Widget screen =   bottomController.prevScreen.value!;
//                                     bottomController.updateIndex(bottomController.selectedIndex.value,screen);
//                                     _lastBackPressed=null;
// }
//       }
      
// //     String currentRoute = Get.currentRoute;
// // print("Current route: $currentRoute");
//       // // var currentNav = Provider.of<BottomUpdate>(context, listen: false);
//       // // ShowToast(msg: "${routeName.toString()}");
//       // if (routeName.toString() == "nav") {
//       //   if (currentNav.selectedIndex == 2) {
//       //     ShowToast(msg: "Press back again to exit");
//       //   } else {
//       //     currentNav.changeBottomTab(2);
//       //   }

//       //   return true;
//       // } else {
//       //   Navigator.of(context).pop();
//       //   // Navigator.pop(context);
//       //   // Navigator.pushReplacement(
//       //   //     context,
//       //   //     MaterialPageRoute(
//       //   //         builder: (context) => BottomNavigationScreen(),
//       //   //         settings: RouteSettings(name: 'nav')));
//       //   return true;
//       // }
//       // // ShowToast(msg: routeName.toString());
//       // //   // ShowToast(msg: "Press back again to exit");
//       // //   Navigator.pop(context);
//       // // return true;

//       // //
//       // // if (_lastBackPressed == null ||
//       // //     now.difference(now) > Duration(seconds: 2)) {
//       // //   _lastBackPressed = now;
//       // //   // ShowToast(msg: lskjjg.toString());
//       // //   ShowToast(msg: "Press back again to exit");
//       // //   return Future.value(false);
//       // // }
//       // // Do not exit the app
     
//     return true;
//     } else {
//       SystemNavigator.pop();

//       return false;
//     }

//     // Exit the app
//   }
// }
