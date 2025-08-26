import 'package:dizisalon_vender/screen/mysalon/my_salon_screen.dart';
import 'package:dizisalon_vender/screen/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../view_model/home_viewmodel.dart';
import '../../view_model/salon_viewmodel.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/widget/my_salon_screen.dart';
import 'widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  

  final List<Widget> _screens = [
     HomeScreen(),
     MySalonWidgetScreen(),
     MySalonScreen(),
    // const OrderScreen(),
     ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    if (index==0) {
      Get.find<HomeViewmodel>()..home()..cmsArticle();
    } else if(index==1){
       Get.find<HomeViewmodel>().saleChart(fromDate: DateFormat("yyyy-MM-dd").format(DateTime.now(),),toDate: DateFormat("yyyy-MM-dd").format(DateTime.now()));
    }else if(index==2){
      Get.find<HomeViewmodel>().home();
      Get.find<SalonViewmodel>().allOrderList();
    }
    setState(() {
      _selectedIndex = index;
    });
  }
  
  Future<bool> _userBack() async {
    final shouldExit = await 
      showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        children: [

          Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.white, Colors.indigo,Colors.indigo.shade900],
        begin: Alignment.topRight,
        end: Alignment.bottomRight,
      ),
    borderRadius: BorderRadius.circular(12), // ✅ border radius
  ),
  padding: EdgeInsets.all(16),
  child: Icon(Icons.logout,size: 35,color: Colors.white,)),
          Text("Are you sure?",style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              // color: Colors.white,
                            ),),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Do you want to exit?",style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),),
                            SizedBox(height: 20,),
                            ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
           
          },
          child: Text("Yes",style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),),
                        // SizedBox(height: 8,),
                          TextButton(
          onPressed: () => Navigator.of(context).pop(false), // Cancel
          child: Text("Cancel"),
        ),
        SizedBox(height: 16,),

                          ],
                        ),
                      
      // actions: [
         
        
        
      // ],
    ),
  );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WillPopScope(
      onWillPop: _userBack,
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300, // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(0, -2), // Shadow direction
            ),
          ],
        ),
        child: BottomNavBar(
          selectedIndex: _selectedIndex,
          onTabSelected: _onTabSelected,
        ),
      ),
    );
  }
}
