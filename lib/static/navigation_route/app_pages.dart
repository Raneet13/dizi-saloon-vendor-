// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../screen/account/profile_screen.dart';
// import '../../screen/auth/login_screen.dart';
// import '../../screen/auth/phone_check.dart';
// import '../../screen/auth/signup_screen.dart';
// import '../../screen/cart/cart_sccreen.dart';
// import '../../screen/category/category_sccreen.dart';
// import '../../screen/home/home_screen.dart';
// import '../../screen/navigation/navigation.dart';
// import '../../screen/search/search_screen.dart';
// import '../../screen/splashScreen/splash_screen.dart';
// import 'app_route.dart';

// class AppPages {
//   // AppPages._();
//   AppPages();

//   static const INITIAL = Routes.WELCOME;

//   static final routes = [
//      GetPage(
//       name: Paths.WELCOME,
//       page: () => SplashScreen(),
//       // binding: WelcomeBinding(),
//     ),
//     GetPage(
//       name: Paths.login,
//       page: () => LoginScreen(),
//       // binding: WelcomeBinding(),
//     ),
//     GetPage(
//       name: Paths.Signup,
//       page: () => SignupScreen(),
//       // binding: WelcomeBinding(),
//     ),
//     // GetPage(
//     //   name: Paths.change_password,
//     //   page: () => UpdatePassword(),
//     //   // binding: StandardNavigationMainBinding(),
//     // ),
//     // GetPage(
//     //   name: Paths.verifyOtp,
//     //   page: () => ForgetPassword(phone: Get.arguments["phone"],otp: Get.arguments["otp"],),
//     //   // binding: StandardNavigationDetailBinding(),
//     // ),
//     GetPage(
//       name: Paths.nav,
//       page: ()=>NavigationScreen(),
//       // page: () => BottomNavigationScreen(screen:Get.arguments ??const HomeScreen()),
//       // binding: NestedNavigationDetailBinding(),
//       children: [
//  GetPage(
//       name: Paths.HOME,
//       page: () => HomeScreen(),
//       // binding: HomeBinding(),
//        children: [
//         // GetPage(
//         //   name: Paths.search,
//         //   page: () => SearchScreen(),
//         // ),
//         // GetPage(
//         //   name: Paths.category,
//         //   page: () => CategoryScreen(),
//         // ),
//         // GetPage(
//         //   name: '/orders',
//         //   page: () => Orders(),
//         // ),
//     ],
//     ),
//        GetPage(
//       name: Paths.profile,
//       page: () => ProfileScreen(),
//       // binding: NestedNavigationMainBinding(),
//     ),
//     // GetPage(
//     //   name: Paths.notification,
//     //   page: () => NotificationScreen(),
//     //   // binding: SubTabsNestedNavigationMainBinding(),
//     // ),
//     GetPage(
//       name: Paths.cart,
//       page: () => CheckoutScreen(),
//       // binding: SubTabsNestedNavigationComputersMainPageBinding(),
//     ),
//       ]
//     ),
   
//     // GetPage(
//     //   name: Paths.SUB_TABS_NESTED_NAVIGATION_COMPUTER_DETAIL_PAGE,
//     //   page: () => SubTabsNestedNavigationComputerDetailPageView(argument: ''),
//     //   binding: SubTabsNestedNavigationComputerDetailPageBinding(),
//     // ),
//     // GetPage(
//     //   name: Paths.SUB_TABS_NESTED_NAVIGATION_LAPTOP_DETAIL_PAGE,
//     //   page: () => SubTabsNestedNavigationLaptopDetailPageView(argument: ''),
//     //   binding: SubTabsNestedNavigationLaptopDetailPageBinding(),
//     // ),
//     // GetPage(
//     //   name: Paths.SUB_TABS_NESTED_NAVIGATION_LAPTOPS_MAIN_PAGE,
//     //   page: () => SubTabsNestedNavigationLaptopsMainPageView(),
//     //   binding: SubTabsNestedNavigationLaptopsMainPageBinding(),
//     // ),
//   ];
  
//   // String get route {
//   //   return '/${Paths(this)}';
//   // }

//    Widget getScreenForRoute(String? route) {
//         print(route);
//     switch (route) {
//       case "${Paths.nav}/${Paths.HOME}":
//         return HomeScreen();
//         case "${Paths.nav}/${Paths.profile}":
//         return ProfileScreen();
//       case "${Paths.nav}/${Paths.notification}":
//         return CheckoutScreen();
//       // case Paths.more:
//       //   return const MoreScreen();
//       default:
//         return HomeScreen();
//     }
//   }
//  Widget getRouteForIndex(int index) {
   
//    switch (index) {
//           case 0:
//             return HomeScreen();
//           case 1:
//             return ProfileScreen();
//           case 2:
//             return CheckoutScreen();
//           // case 3:
//           //   return MoreScreen();
//           default:
//             return HomeScreen(); // Default screen
//         }
//   }

//   // static GetPageRoute getPage(RouteSettings settings) {
//   //   var destination = Path.firstWhereOrNull((e) => e.route == settings.name);
//   //   return GetPageRoute(page: () => destination?.widget ?? Container());
//   // }
// }
