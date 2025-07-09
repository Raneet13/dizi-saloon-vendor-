import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/model/orderlist_model.dart';
import 'package:dizisalon_vender/screen/mysalon/barber_details_widget.dart';
import 'package:dizisalon_vender/screen/mysalon/showQr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../view_model/salon_viewmodel.dart';

class AllBarberScreen extends StatelessWidget {
   AllBarberScreen({super.key});
 final salon = Get.find<SalonViewmodel>();
  final List<Map<String, dynamic>> customers = const [
    {
      'name': 'Avinash Shao',
      'phone': '+91 6375445824',
      'service': 'Hair Cutting',
      'barber': 'Barber Name',
      'status': 'End',
      'statusColor': Color(0xFF002B5B),
      'duration': '15 min',
      'img': 'https://i.pravatar.cc/150?img=3',
      'sideColor': Colors.red,
    },
    {
      'name': 'Dineesh Goyal',
      'phone': '+91 6375445824',
      'service': 'Shaving',
      'barber': 'Barber Name',
      'status': 'ongoing',
      'statusColor': Colors.orange,
      'duration': 'Reached',
      'img': null,
      'sideColor': Colors.amber,
    },
    {
      'name': 'Kajal Sharma',
      'phone': '+91 6375445824',
      'service': 'Hair Cutting',
      'barber': 'Barber Name',
      'status': 'End',
      'statusColor': Color(0xFF002B5B),
      'duration': '45 min',
      'img': 'https://i.pravatar.cc/150?img=10',
      'sideColor': Colors.red,
    },
    {
      'name': 'Sebastian',
      'phone': '+91 6375445824',
      'service': 'Hair Cutting',
      'barber': 'Barber Name',
      'status': 'Completed',
      'statusColor': Colors.green,
      'duration': 'Reached',
      'img': 'https://i.pravatar.cc/150?img=12',
      'sideColor': Colors.green,
    },
  ];

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
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Order',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                child:salon.allOrderlist.value.messages?.appointments?.orderList?.length==0?Center(child: Text("No Order"),): ListView.builder(
                  itemCount: salon.allOrderlist.value.messages?.appointments?.orderList?.length??0,
                  itemBuilder: (context, index) {
                    final salonOrderItem = salon.allOrderlist.value.messages?.appointments?.orderList;
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
            )
          ],
        ),
      ),
    );
  }
    Widget _customerCard(BuildContext context ,OrderList? orderItem) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>customerDetails(orderItem: orderItem,)));
        
      },
      child: Container(
        height: 80.h,
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
                            width: 8,
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
                              padding: const EdgeInsets.all(12.0),
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
                    image:orderItem?.profileImage!=null? NetworkImage("${AppUrl.imageApi}${orderItem?.profileImage??""}"):AssetImage("assets/image/no_image.png"))
                ),
              ),
               
                                  SizedBox(width: 12),
                                  Expanded(
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
                                          if (orderItem?.isConfirm=="0") {
                                            salon.updateOrder(apontId: orderItem?.id??"", status: "1");
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
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF002B5B),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            orderItem?.isConfirm=="0"?"Confirm": orderItem?.isConfirm=="1"?"Complete": orderItem?.isConfirm=="2"?"Pending": "Cancel",
                                           style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
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

