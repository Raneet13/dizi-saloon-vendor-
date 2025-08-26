import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/model/orderlist_model.dart';
import 'package:dizisalon_vender/screen/mysalon/barber_details_widget.dart';
import 'package:dizisalon_vender/screen/mysalon/showQr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/show_toast/showTost_msg.dart';
import '../../view_model/salon_viewmodel.dart';

class AllBarberScreen extends StatelessWidget {
   AllBarberScreen({super.key});
 final salon = Get.find<SalonViewmodel>();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back_ios),
        title: Text("Order List", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            SizedBox(
              height: 45.h,
              child: TextField(
                
                controller: salon.searchorderController,
                onChanged:  (val){
                  salon.filterAppointmentsByQuery(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 14.sp),
                  hintText: 'Search for Order',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Text(
            //   'Listing of Customers',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 12),
          Obx(
              ()=> salon.isLoading.value?Center(child: CircularProgressIndicator(),): Expanded(
                child:salon.allOrderlist.value.messages?.appointments?.length==0? RefreshIndicator(
                  onRefresh: ()async{
Get.find<SalonViewmodel>().allOrderList();
                  },
                  child: SingleChildScrollView(child: Center(child: Text("No Order"),))):salon.listOrder.value!=null?
                ListView.builder(
                  itemCount: salon.listOrder.value?.length??0,
                  itemBuilder: (context, index) {
                    // final salonOrderItem = salon.allOrderlist.value.messages?.appointments?.orderList;
                    return _customerCard(context,salon.listOrder.value?[index]);}
                    ): 
                     RefreshIndicator(
                  onRefresh: ()async{
Get.find<SalonViewmodel>().allOrderList();
                  },
                
                      child: ListView.builder(
                                        itemCount: salon.allOrderlist.value.messages?.appointments?.length??0,
                                        itemBuilder: (context, index) {
                      final salonOrderItem = salon.allOrderlist.value.messages?.appointments;
                      return _customerCard(context,salonOrderItem![index]);
                      // return Container(
                      //   margin: EdgeInsets.symmetric(vertical: 4),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10),
                      //     boxShadow: [
                      //       BoxShadow(color: Colors.grey.shade200, blurRadius: 6, offset: Offset(0, 4))
                      //     ],
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 8,
                      //         height: 100,
                      //         decoration: BoxDecoration(
                      //           color: Colors.red,
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(10),
                      //             bottomLeft: Radius.circular(10),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(12.0),
                      //           child: Row(
                      //             children: [
                      //               CircleAvatar(
                      //                 backgroundImage: salonOrderItem?[index].profileImage != null
                      //                     ? NetworkImage(salonOrderItem?[index].profileImage??"")
                      //                     : null,
                      //                 backgroundColor: Colors.grey.shade300,
                      //                 radius: 24,
                      //               ),
                      //               SizedBox(width: 12),
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     Row(
                      //                       children: [
                      //                         Expanded(
                      //                           child: Text(salonOrderItem?[index]?.userName??"", style: TextStyle(fontWeight: FontWeight.bold)),
                      //                         ),
                                             
                      //                         SizedBox(width: 4),
                                             
                      //                       ],
                      //                     ),
                      //                     SizedBox(height: 4),
                      //                     Text(salonOrderItem?[index]?.userPhone??"", style: TextStyle(color: Colors.grey)),
                      //                     Text(salonOrderItem?[index]?.serviceName??"", style: TextStyle(color: Colors.grey)),
                      //                   ],
                      //                 ),
                      //               ),
                      //                Transform.translate(offset: Offset(-20, -20), child: Icon(Icons.compare_arrows, size: 24,color: Colors.grey,)),
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                    Text(salonOrderItem?[index]?.barberName??"", style: TextStyle(fontWeight: FontWeight.bold)),
                      //                   // Text(c['duration'], style: TextStyle(color: Colors.grey)),
                      //                   SizedBox(height: 6),
                      //                   Container(
                      //                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      //                     decoration: BoxDecoration(
                      //                       color:Colors.blue,
                      //                       borderRadius: BorderRadius.circular(6),
                      //                     ),
                      //                     child: Text(
                      //                       salonOrderItem?[index].isConfirm=="0"?"New": salonOrderItem?[index].isConfirm=="1"?"Confirm": salonOrderItem?[index].isConfirm=="2"?"Pending": "Cancel",
                      //                       style: TextStyle(color: Colors.white),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // );
                                        
                                        },
                                      ),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
    Widget _customerCard(BuildContext context ,Appointment? orderItem) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>customerDetails(orderItem: orderItem,)));
        
      },
      child: Container(
        height: 84.h,
        // width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200, blurRadius: 6, offset: Offset(0, 4))
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:  EdgeInsets.all(12.0.sp),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                   Container(
                height: 70.h,
                width: 68.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    // BoxShadow(color: Colors.grey.shade200,blurRadius: 1,spreadRadius: 1),
                    
                  ],
                  borderRadius: BorderRadius.circular(4),
                  
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:orderItem?.customerProfile!=null? NetworkImage("${AppUrl.imageApi}${orderItem?.customerProfile??""}"):AssetImage("assets/image/no_image.png"))
                ),
              ),
               
                                  SizedBox(width: 12.w),
                                  Expanded(
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
                                               Text("${orderItem?.services?.map((t)=>t.serviceName??"").toList().join(",")??""}",overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 14.sp)),
                                              // SizedBox(width: 4),
                                             
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.compare_arrows, size: 24.sp,color: Colors.grey,),
                                     
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(orderItem?.barberName??"", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                                            SizedBox(),
                                               InkWell(
                                        onTap: ()async{
                                          if(orderItem?.isConfirm=="3"){
                                            ShowToast(msg: "Your Order Already Cancelled");
                                          }if(orderItem?.isConfirm=="4"){
                                            ShowToast(msg: "Your Order Already Completed");
                                          }else if (orderItem?.isConfirm=="0") {
                                            salon.updateOrder(apontId: orderItem?.appointmentId??"", status: "1");
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
                                                        orderId: orderItem?.appointmentId??"",
                                                        customerName: orderItem?.barberName??"", singleback: true,
                                                      ),
                                                    ),
                                                  );
                                          //     });
                                          //   });
                                          //   // salon.updateOrder(apontId: orderItem?.id??"", status: "4");
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                                          decoration: BoxDecoration(
                                            color:orderItem?.isConfirm=="3"?Colors.red:orderItem?.isConfirm=="4"?Colors.green: const Color(0xFF002B5B),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            orderItem?.isConfirm=="0"?"Confirm": orderItem?.isConfirm=="1"|| orderItem?.isConfirm=="2"?"Complete": orderItem?.isConfirm=="3"?"Cancelled":"Completed",
                                           style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
                }

}

