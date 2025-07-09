import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/model/orderlist_model.dart';
import 'package:dizisalon_vender/screen/mysalon/showQr_screen.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class customerDetails extends StatelessWidget {
  OrderList? orderItem;
   customerDetails({required this.orderItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Customer Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:   Container(
           margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.grey.shade400,
              offset: const Offset(0, 4),
            )
          ],
        ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                  height: 70.h,
                  width: 68.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200,blurRadius: 1,spreadRadius: 1),
                      
                    ],
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:orderItem?.profileImage != null? NetworkImage("${AppUrl.imageApi}${orderItem?.profileImage??""}"):AssetImage("assets/image/no_image.png"))
                  ),
                                ),
                                 
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(orderItem?.userName??"", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                                                Text(orderItem?.userPhone??"", style: TextStyle(color: Colors.grey)),
                                                 Text(orderItem?.serviceName??"", style: TextStyle(color: Colors.grey)),
                                                // SizedBox(width: 4),
                                               
                                              ],
                                            ),
                                            Icon(Icons.compare_arrows, size: 24,color: Colors.grey,),
                                         
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(orderItem?.barberName??"", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                                                SizedBox(),
                                                  orderItem?.isConfirm=="4"?SizedBox():  InkWell(
                                            onTap: ()async{
                                              // if (orderItem?.isConfirm=="0") {
                                              //   salon.updateOrder(apontId: orderItem?.id??"", status: "1");
                                              // } else if(orderItem?.isConfirm=="1"){
                                            
                                              //  await salon.generateQr(orderId: "1",customerName: "Dibya")
                                              //   .then((val)async{
                                              //     print(val);
                                              //      if (!context.mounted) return;
                                              //     WidgetsBinding.instance.addPostFrameCallback((_){
                                              //     //  await Future.delayed(Duration(seconds: 2));
                                                    //  Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) => ShowqrScreen(
                                                    //         orderId: orderItem?.id??"",
                                                    //         customerName: orderItem?.userName??"",
                                                    //       ),
                                                    //     ),
                                                    //   );
                                              //     });
                                              //   });
                                              //   // salon.updateOrder(apontId: orderItem?.id??"", status: "4");
                                              // }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF002B5B),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text("Remove",
                                               style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                   ],
                  ),
                ),
                Divider(height: 20, thickness: 1),
                _infoText("Order Number:", "${orderItem?.id??""}"),
                _infoText("Order Date & Time:", "${orderItem?.createdAt??""}, 12:08 pm"),
                _infoText("Customer Name:", "${orderItem?.userName??""}"),
                _infoText("Phone Number:", "+91 ${orderItem?.userPhone??""}"),
                _infoText("Barber Name:", "${orderItem?.barberName??""}"),
                _infoText("Service:", "${orderItem?.serviceName??""}"),
                _infoText("Service Price:", "${orderItem?.price??""} Rs"),
                _infoText("Service Schedule at:", "${DateFormat("dd/MM/yyyy, hh:mm a").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(orderItem?.apointmentDate??""))}"),
                // _infoText("Waiting List Number:", "#9 <Completed>", isCompleted: true),
                // _infoText("Arriving Time:", "30 min <Completed>", isCompleted: true),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _actionButton(context,"${orderItem?.isConfirm=="0"?"Confirm": orderItem?.isConfirm=="1"?"Complete": orderItem?.isConfirm=="2"?"Pending": "Cancel"}", const Color(0xFF002B5B)),
                    SizedBox(width: 16,),
                    _outlinedButton("Call Now",orderItem?.userPhone??""),
                  ],
                ),
              ],
            ),
          ),
        ),
      
    );
    // return Column(
    //   children: [
    //     AppBar(),
    //   ],
    // );
  }

  Widget _infoText(String label, String value, {bool isCompleted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(text: "$label ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: value,
              style: TextStyle(
                color: isCompleted ? Colors.green : Colors.black,
                fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, String text, Color color) {
    return ElevatedButton(
      onPressed: () {
        if (orderItem?.isConfirm=="0") {
                                            Get.find<SalonViewmodel>().updateOrder(apontId: orderItem?.id??"", status: "1");
                                          } else if(orderItem?.isConfirm=="1"){
                                        
                                          //  await salon.generateQr(orderId: "1",customerName: "Dibya")
                                          //   .then((val)async{
                                          //     print(val);
                                          //      if (!context.mounted) return;
                                          //     WidgetsBinding.instance.addPostFrameCallback((_){
                                          //     //  await Future.delayed(Duration(seconds: 2));
                                                 Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ShowqrScreen(
                                                        orderId: orderItem?.id??"",
                                                        customerName: orderItem?.userName??"",
                                                      ),
                                                    ),
                                                  );
                                          //     });
                                          //   });
                                          //   // salon.updateOrder(apontId: orderItem?.id??"", status: "4");
                                          }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(140, 45),
      ),
      child: Text(text, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold)),
    );
  }

  Widget _outlinedButton(String text,String phone) {
    void makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch phone call';
  }
}
    return OutlinedButton(
      onPressed: () {
        makePhoneCall(phone);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: const Color(0xFF002B5B),),
        minimumSize: Size(140, 45),
      ),
      child: Text(text, style: GoogleFonts.montserrat(color: const Color(0xFF002B5B),fontWeight: FontWeight.bold)),
    );
  }
}
