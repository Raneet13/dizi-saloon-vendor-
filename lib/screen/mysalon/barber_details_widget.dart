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
  Appointment? orderItem;
   customerDetails({required this.orderItem, super.key});
   void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/image/mobile_icon.png', height: 60),
                const SizedBox(height: 16),
                 Text(
                  'Are you sure?',
                  style: GoogleFonts.poppins(fontSize: 28.sp, fontWeight: FontWeight.w500,),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Do you want to cancel this order?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 12.sp),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 190,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Reason for cancellation',
                      hintMaxLines: 1,
                      hintStyle: GoogleFonts.montserrat(color: Colors.grey[400],fontSize: 14.sp,fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                    ),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 16),
                 InkWell(
                  onTap: (){
                    Get.find<SalonViewmodel>().updateOrder(apontId: orderItem?.appointmentId??"", status: "3");
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                   child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                                            decoration: BoxDecoration(
                                              color:Colors.red,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text("Cancel",style: TextStyle(color: Colors.white),),),
                 ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


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
           margin:  EdgeInsets.all(16.sp),
        padding:  EdgeInsets.all(12.sp),
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
                  height: 72.h,
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
                      image:orderItem?.customerProfile != null? NetworkImage("${AppUrl.imageApi}${orderItem?.customerProfile??""}"):AssetImage("assets/image/no_image.png"))
                  ),
                                ),
                                 
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(orderItem?.customerName??"", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                                                  Text(orderItem?.customerContact??"", style: TextStyle(color: Colors.grey,fontSize: 14.sp)),
                                                   Text("${orderItem?.services?.map((t)=>t.serviceName??"").toList().join(",")??""}",
                                                   overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,
                                                    style: TextStyle(color: Colors.grey,fontSize: 12.sp)),
                                                  // SizedBox(width: 4),
                                                 
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.compare_arrows, size: 24.sp,color: Colors.grey,),
                                         SizedBox(width: 8.w,),
                                            Column(
                                              // mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(orderItem?.barberName??"", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                                                
                                               Text(orderItem?.barberPhone??"", style: TextStyle(color: Colors.grey,fontSize: 14.sp)),
                                               SizedBox(),
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
                _infoText("Order Number:", "${orderItem?.orderId??""}"),
                _infoText("Order Date & Time:", "${DateFormat("dd MMM yyy hh:mm a").format(DateTime.parse(orderItem?.createdAt??""))}"),
                _infoText("Customer Name:", "${orderItem?.customerName??""}"),
                _infoText("Phone Number:", "+91 ${orderItem?.customerContact??""}"),
                _infoText("Barber Name:", "${orderItem?.barberName??""}"),
                _infoText("Service:", "${orderItem?.services?.map((t)=>t.serviceName??"").toList().join(",")??""}"),
                _infoText("Service Price:", "${orderItem?.services?.map((t)=>t.price??"").toList().join(",")??""} Rs"),
                _infoText("Service Schedule at:", "${DateFormat("dd MMM yyy").format(DateTime.parse(orderItem?.apointmentDate??""))}"),
                _infoText("Service Schedule Time:", "${orderItem?.timeSlut??""}"),
                // _infoText("Waiting List Number:", "#9 <Completed>", isCompleted: true),
                // _infoText("Arriving Time:", "30 min <Completed>", isCompleted: true),
                SizedBox(height: 16),
               orderItem?.isConfirm=="4"||orderItem?.isConfirm=="3"?SizedBox(): Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: _actionButton(context,"${orderItem?.isConfirm=="0"?"Confirm": orderItem?.isConfirm=="1"||orderItem?.isConfirm=="2"?"Complete": orderItem?.isConfirm=="3"? "Cancel":"Completed"}", const Color(0xFF002B5B))),
                    SizedBox(width: 16,),
                   Expanded(child: _outlinedButton("Cancel",context)),
                     SizedBox(width: 8.sp,),
                     InkWell(
                      onTap: ()async{
                         final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: orderItem?.customerContact??"",
                        );
                        
                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          throw 'Could not launch phone call';
                        }
                      },
                       child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.call, color: Colors.white, size: 20,),
                       ),
                     )
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
                                            Get.find<SalonViewmodel>().updateOrder(apontId: orderItem?.appointmentId??"", status: "1");
                                            Navigator.pop(context);
                                          } else if(orderItem?.isConfirm=="1"||orderItem?.isConfirm=="2"){
                                        
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
                                                        orderId: orderItem?.appointmentId??"",
                                                        customerName: orderItem?.customerContact??"", singleback: false,
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
        padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 4.sp),
        minimumSize: Size(140.w, 45.h),
      ),
      child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold)),
    );
  }

  Widget _outlinedButton(String text,BuildContext context) {
   
    return OutlinedButton(
      onPressed: () {
        _showConfirmDialog(context);
        //  Get.find<SalonViewmodel>().updateOrder(apontId: orderItem?.appointmentId??"", status: "3");
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: Colors.red,),
        minimumSize: Size(140.w, 45.h),
      ),
      child: Text(text, style: GoogleFonts.montserrat(color:  Colors.red,fontWeight: FontWeight.bold,fontSize: 14.sp)),
    );
  }
}
