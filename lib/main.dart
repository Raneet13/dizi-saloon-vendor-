import 'dart:async';
import 'dart:convert';

import 'package:dizisalon_vender/firebase_options.dart';
import 'package:dizisalon_vender/notification/local_notification.dart';
import 'package:dizisalon_vender/screen/navigation/bottom_navigation.dart';
import 'package:dizisalon_vender/screen/splash/empty_page.dart';
import 'package:dizisalon_vender/screen/splash/splash_screen.dart';
import 'package:dizisalon_vender/view_model/auth_viewmodel.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/mediaquery.dart';
import 'view_model/baber_viewmodel.dart';
import 'view_model/form_viewmodel.dart';
import 'dart:io';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification == null) {
    await LocalNotificationService.createanddisplaynotification(message);
  }
}
void main() async{
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

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
  final details = await FlutterLocalNotificationsPlugin()
      .getNotificationAppLaunchDetails();

  final payload = details?.notificationResponse?.payload;
  bool openedFromNotification = false;
  if (payload != null && payload.isNotEmpty) {
    LocalNotificationService.initialPayload = payload;
  openedFromNotification = true;
  }
   runApp(MyApp(launchedFromNotification: openedFromNotification));
  
}

class MyApp extends StatefulWidget {
 final bool launchedFromNotification;
  const MyApp({super.key, required this.launchedFromNotification});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Future<String?> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    return token;
    // deviceTokenToSendPushNotification = token.toString();
    // print("Token Value ${token.toString()}");
  }
    @override
  void initState() {
    super.initState();
    _initializeServices();
     WidgetsBinding.instance.addPostFrameCallback((_) async {
    // 🔹 Handle notification tap from terminated state
    
    if ( LocalNotificationService.initialPayload != null) {
      await LocalNotificationService.handleNotificationTap(
          LocalNotificationService.initialPayload!);
      LocalNotificationService.initialPayload = null;
    }
  });
  }
   Future<void> _initializeServices() async {
    await LocalNotificationService.initialize();
    _initFirebaseMessaging();
  }
  void _initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request notification permission (iOS & Android 13+)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // ✅ Foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 Foreground message: ${message.notification?.title}");
      LocalNotificationService.createanddisplaynotification(message);
    });

    // ✅ Background → App opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📲 App opened from background: ${message.data}");
      LocalNotificationService.handleNotificationTap(jsonEncode(message.data));
    });

    // ✅ Terminated → App launched by tapping notification
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      debugPrint("🚀 App launched from terminated state: ${initialMessage.data}");
      // LocalNotificationService.createanddisplaynotification(initialMessage);
       LocalNotificationService.handleNotificationTap(jsonEncode(initialMessage.data));
    }
  }

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
        title: 'Dizisalon Partner',
         navigatorKey: navigatorKey,
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

    // 🚀 If app opened from notification → skip splash and load a blank container
    if (widget.launchedFromNotification) {
      return const  EmptyPage();
    }

    // Normal launch → show splash
    return SplashScreen(launchedFromNotification: false);
          },
        ),
      );
  });
  }
}
