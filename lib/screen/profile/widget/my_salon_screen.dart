import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../view_model/home_viewmodel.dart';
import '../../mysalon/all_barberlist_screen.dart';
import '../../mysalon/my_salon_screen.dart';
import '../../review_screen/review_screen.dart';
import '../barbar_list_screen.dart';

class MySalonWidgetScreen extends StatelessWidget {
   MySalonWidgetScreen({super.key});
   final salon = Get.find<HomeViewmodel>();
   List img=[
    "assets/image/barber_.png","assets/image/_barber.png","assets/image/sales_.png","assets/image/feedback_.png"
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Salon",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
          // shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16
            ), 
            itemCount: 4,
        itemBuilder: (context,int){
          return Container(
          //   height: 100,
          //   width: 122,
            padding:EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ]
                // border: Border.all(color: Colors.grey),
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage("assets/image/group_icon.png")
                // )
            ),
          child: Container(
            padding:EdgeInsets.all(16),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(0)),
                border: Border.all(color: Colors.grey.shade300),
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage("assets/image/group_icon.png")
                // )
            ),
            child: InkWell(
              onTap: (){
                if (int==0) {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  BarberListScreen()),
                    );
                } else if(int==1){
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AllBarberScreen()),
                    );
                }else if(int==2){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MySalonScreen()),
                    );
                }else if(int==3){
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  FeedbackScreen()),
                    );
                  
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(img[int],height: 54.h,width: 67.w,fit: BoxFit.cover,),
                  
                  Text("${int==0?"Barber":int==1?"Customers":int==2?"Sales":"Feedback"}",style: GoogleFonts.montserrat(fontSize: 14,color:  Color(0xFF002B5B),fontWeight: FontWeight.w500),),
                  Text("${int==0?salon.homemodel.value.messages?.data?.mysalon?.barberCount??"0":int==1?salon.homemodel.value.messages?.data?.mysalon?.customerCount??"0":int==2?salon.homemodel.value.messages?.data?.mysalon?.totalSales??"0":salon.homemodel.value.messages?.data?.mysalon?.feedbackCount??"0"}",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          );
        }),
      ),
    );
  }
}