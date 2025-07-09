import 'dart:async';

import 'package:dizisalon_vender/screen/splash/splash_screen.dart';
import 'package:dizisalon_vender/view_model/auth_viewmodel.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/mediaquery.dart';
import 'view_model/baber_viewmodel.dart';
import 'view_model/form_viewmodel.dart';
import 'dart:io';


void main() {
 
  WidgetsFlutterBinding.ensureInitialized();

  Get.lazyPut<AuthViewmodel>(() => AuthViewmodel(), fenix: true);
  Get.lazyPut<HomeViewmodel>(() => HomeViewmodel(), fenix: true);
    Get.lazyPut<BarberViewmodel>(() => BarberViewmodel(), fenix: true);
    Get.lazyPut<SalonViewmodel>(() => SalonViewmodel(), fenix: true);
    Get.lazyPut<FormViewmodel>(() => FormViewmodel(), fenix: true);
    
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.white, // Change to your desired color
  //   // statusBarIconBrightness: Brightness.dark, // For white icons
  //   systemNavigationBarColor: Colors.white, // Navigation bar color (bottom)
  // ));
   runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 730),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData( 
           
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(size: 24),
            backgroundColor: Colors.white,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: Colors.white,
          //   statusBarIconBrightness: Brightness.light,
          // ),
            // shadowColor: Colors.white
          ),
          scaffoldBackgroundColor: Color(0xFFFFFFFF),      
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF002B5B)),
          textTheme: GoogleFonts.montserratTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape:  RoundedRectangleBorder(
      side: BorderSide(color: Colors.white), // Define the color and width of the border
      borderRadius: BorderRadius.circular(8), // Optional: Define the border radius
        ),
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF002B5B)
            )
          ),
           textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
              // foregroundColor: Colors.white,
              
              foregroundColor: Color(0xFF002B5B)
            )
          ),
          useMaterial3: true,
        ),
        home:  Builder(
          builder: (context) {
            MediaQueryUtil.initialize(context);
            return  SplashScreen();
          },
        ),
      );
  });
  }
}
