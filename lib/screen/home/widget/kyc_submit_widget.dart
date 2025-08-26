import 'package:dizisalon_vender/model/home_model.dart';
import 'package:dizisalon_vender/screen/home/widget/detials_of_document.dart';
import 'package:dizisalon_vender/screen/home/widget/link_kyc_form.dart';
import 'package:dizisalon_vender/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../model/cms_model.dart';
import '../../../view_model/home_viewmodel.dart';
import '../../auth/login/loginscreen.dart';
import '../../barber/add_barber_form.dart';
import '../../order/order_screen.dart';
import '../../salon_service/salon_service_screen.dart';

class KYCWidget extends StatelessWidget {
  LoginUser? saalon;
  final bool? gologin;
  bool year2023 = true;
 
   final List<String> steps = [
    "Fill KYC",
    "Services",
    "List Barbers",
    "Take Order ",
  ];

  KYCWidget({required this.saalon,this.gologin, super.key});
   final home = Get.find<HomeViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Obx(
        ()=>home.isLoading.value?Center(child: CircularProgressIndicator(),): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                Image.asset("assets/image/onboarding/Group 115.png",height: 20,width: 20,),
                SizedBox(
                  height: 30.h,
                  // width: ,
                  child: ElevatedButton(
                    onPressed: () {
                      if (home.homemodel.value.messages?.data?.centerFacilities !=true) {//home.homemodel.value.messages?.data?.centerFacilities !=true
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: home.cmsemodel.value.data?.kyc)));
                      } else if(home.homemodel.value.messages?.data?.salonServices?.length==0){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: home.cmsemodel.value.data?.serviceKyc)));
                      }else if(home.homemodel.value.messages?.data?.mysalon?.barberCount== 0){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: home.cmsemodel.value.data?.barbarKyc)));
                      }else if(home.homemodel.value.messages?.data?.reciveOrder !=true){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: home.cmsemodel.value.data?.takeOrder)));
                      }
                    else{
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: home.cmsemodel.value.data?.privacyPolicy)));
                    }
                      
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      backgroundColor: const Color(0xFF002B5B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Know More",style: TextStyle(fontSize: 13.sp),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
           Container(
                 height: SizeConfig.blockHeight * 8,
                //  alignment: AlignmentDirectional.centerStart,
                 width: double.infinity,
                margin: EdgeInsets.zero,
                 padding: EdgeInsets.zero,
                //  color: Colors.grey,
                //  width:MediaQuery.of(context).size.width *1.2,
                 child: FixedTimeline.tileBuilder(
                   
                  //  mainAxisSize: MainAxisSize.max,
                   
                   // 
                  //  itemExtent: 80,
                  theme: TimelineThemeData(
                    direction: Axis.horizontal,
                           // nodePosition: -1,
                           nodeItemOverlap: true,
                           connectorTheme: ConnectorThemeData(
                             color: Color(0xffe6e7e9),
                             thickness: 18.0,
                           ),
                         ),
                   builder: TimelineTileBuilder.connected(
                          
                           itemCount: steps.length,
                          //  itemExtent: MediaQuery.sizeOf(context).width*0.24,
                            itemExtentBuilder: (_,int) =>int==0||int==3?50:MediaQuery.sizeOf(context).width <=360?SizeConfig.blockWidth*27.7: SizeConfig.blockWidth*30.5,
                           
                            connectionDirection: ConnectionDirection.after,
                            contentsAlign: ContentsAlign.reverse,
                          //  contentsAlign: ContentsAlign.reverse,
                           // connectionDirection: ConnectionDirection.before,
                          //  indicatorPositionBuilder: (_, __) => 0.0,
                           indicatorBuilder: (context, index) {
                            
                             return DotIndicator(
                               size: 12,
                               color: Color(0xFF002B5B),
                              //  child: Center(child: Icon(Icons.circle, color: Color(0xFF002B5B),)),
                             );
                           },
                          //  firstConnectorBuilder: (context) => SizedBox(),
                          //  lastConnectorBuilder: (context) => SizedBox(),
                          //  indicatorPositionBuilder: (_, __) => 0.0,
                           connectorBuilder: (context, index, __) {
                            if (index==0 && home.homemodel.value.messages?.data?.centerFacilities ==true) {//
                  
                  return SolidLineConnector(
                               thickness: 15,
                              space:12,
                               indent: 0,
                              //  endIndent: 4,
                               color: Color(0xFF002B5B),
                             );
                                     } else if(index==1 && home.homemodel.value.messages!.data!.salonServices!.length>0){
                   return SolidLineConnector(
                                thickness: 15,
                              space:12,
                               color: Color(0xFF002B5B),
                             );
                                     }else if(index==2 && home.homemodel.value.messages!.data!.mysalon!.barberCount!>0){
                   return SolidLineConnector(
                               thickness: 15,
                              space:12,
                               color: Color(0xFF002B5B),
                             );
                                     }else if(index==3 && home.homemodel.value.messages!.data!.mysalon!.totalSales!>0){
                   return SolidLineConnector(
                               thickness: 15,
                              space:12,
                               color: Color(0xFF002B5B),
                             );
                                     }
                                   else{
                 return SolidLineConnector(
                  
                                thickness: 15,
                              space:12,
                               color: Colors.grey.shade300,
                             );
                           }
                           },
                           
                                     contentsBuilder: (context, index) => Container(
                                      width: 60,
                                      height: 30,
                                      alignment: Alignment.topLeft,
                   padding: const EdgeInsets.only(bottom: 4),
                   child: Text(
                           steps[index],
                           overflow: TextOverflow.ellipsis,
                           maxLines: 1,
                           softWrap: true,
                           style: GoogleFonts.montserrat(fontSize: 12, color: Colors.black),
                           textAlign: TextAlign.start,
                   ),
                 ),
                          //  contentsBuilder: (context, index) => Padding(
                          //    padding: const EdgeInsets.only(top: 0),
                          //    child: Text(
                          //      steps[index],
                          //      style: TextStyle(fontSize: 12),
                          //      textAlign: TextAlign.center,
                          //    ),
                          //  ),
                   ),
                 ),
               ),
            // SizedBox(
            //   height: 50,
            //   width: double.infinity,
            //   child: FixedTimeline.tileBuilder(
                
            //     direction: Axis.horizontal,
            //     mainAxisSize: MainAxisSize.min,
            //   builder: TimelineTileBuilder.connectedFromStyle(
            //   connectionDirection: ConnectionDirection.before,
            //   oppositeContentsBuilder: (context, index) => Text('Timeline Event $index'),
            //   connectorStyleBuilder: (context, index) {
            //   return ConnectorStyle.solidLine;
            //   },
            //   indicatorStyleBuilder: (context, index) =>(index <= 1) ?IndicatorStyle.dot : IndicatorStyle.outlined,
            //   itemExtent: 80.0,
            //   itemCount: 3,
              
            //   ),
            //   ),
            // ),
            
            // SizedBox(height: 8),
           
            SizedBox(
              width: double.infinity,
              height: SizeConfig.blockHeight * 4,
              child: ElevatedButton(
                onPressed: () {
                  if (gologin==true) {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>SignInScreen(),
                                )
                              );
                  } else {
                   if (home.homemodel.value.messages?.data?.centerFacilities !=true) { 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SalonKycform(saalon: saalon,)));
                    } else if(home.homemodel.value.messages?.data?.salonServices?.length==0){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListScreen(saalon: saalon,)));
                    }else if(home.homemodel.value.messages?.data?.mysalon?.barberCount== 0){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBarberScreen(saalon: saalon,)));
                    }else if(home.homemodel.value.messages?.data?.mysalon?.totalSales == 0){
                      WidgetsBinding.instance.addPostFrameCallback((_){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));});
                    }
                  else{
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SalonKycform()));
                  } 
                  }
                
                 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002B5B),
                  foregroundColor: Colors.white,
                  // padding: EdgeInsets.symmetric(vertical: SizeConfig.blockWidth * 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
                child: Text("List Now",style: GoogleFonts.montserrat(fontSize: 15.sp,fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}