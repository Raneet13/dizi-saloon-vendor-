
import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/mysalon/barber_details_widget.dart';
import 'package:dizisalon_vender/screen/mysalon/showQr_screen.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../model/orderlist_model.dart';
enum BookingStatus {
  completed,
  ongoing,
  cancelled,
}
class BookingItem extends StatelessWidget {
  final OrderList? orderItem;

  const BookingItem({
    super.key,
    required this.orderItem,
  });

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
                Image.asset('assets/images/Frame.png', height: 60),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Do you want to cancel this order?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 190,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Reason for cancellation',
                      hintStyle: TextStyle(color: Colors.grey[400]),
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
                // MyButton(
                //   text: 'Yes',
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                //   onPressed: () {
                //     Navigator.pop(context);
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //       builder: (context) => const CancelScreen()),
                //     // );
                //   },
                // ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'No',
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
    return InkWell(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>customerDetails(orderItem: orderItem,)));
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.green,
              width: 8,
            ),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
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
            // Container(
            //   width: 50,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: Colors.grey[200],
            //     shape: BoxShape.circle,
            //   ),
            //   child: const Icon(Icons.person, color: Colors.grey, size: 28),
            // ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                              orderItem?.userName??"",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                        // Row(
                        //   children: [
                           
                        //     const SizedBox(width: 6),
                        //     const Icon(
                        //       Icons.swap_horiz,
                        //       size: 16,
                        //       color: Colors.grey,
                        //     ),
                        //     const SizedBox(width: 6),
                        //     const Expanded(
                        //       child: Text(
                        //         'Barber Name',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 15,
                        //             overflow: TextOverflow.ellipsis),
                        //         maxLines: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                       
                        const SizedBox(height: 4),
                        Text(
                          '+91 ${orderItem?.userPhone??""}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                            Text(
                              orderItem?.serviceName??"",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                        
                      ],
                    ),
                  const  SizedBox(width: 8,),
                     Align(
                      alignment: Alignment.topCenter,
                       child: const Icon(
                         Icons.swap_horiz,
                         size: 16,
                         color: Colors.grey,
                       ),
                     ),
                         const  SizedBox(width: 8,),
                    Expanded(
                      child: Column(
                      // mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${orderItem?.barberName??""}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(orderItem?.apointmentDate??""))}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 8),
                       orderItem?.isConfirm=="4"?SizedBox():  _buildStatusWidget("${orderItem?.isConfirm=="0"?"Confirm": orderItem?.isConfirm=="1"?"Complete": orderItem?.isConfirm=="2"?"Pending": "Cancel"}", context),
                      ],
                                      ),
                    )
                  ],
                ),
              ),
            ),
            
           
          ],
        ),
      ),
    );
  }
  

  Widget _buildStatusWidget(String statu, BuildContext context) {
     final salon = Get.find<SalonViewmodel>();
    // switch (status) {
    //   // case BookingStatus.completed:
    //   case statu.toString()=="N"
        return InkWell(
          onTap: (){
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
            child:  Text(
              statu,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
    //   case status =="New":
    //     return Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    //           decoration: BoxDecoration(
    //             color: Colors.orange,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: const Text(
    //             'Ongoing',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 13,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 8),
    //         GestureDetector(
    //           onTap: () => _showConfirmDialog(context),
    //           child: Container(
    //             padding: const EdgeInsets.all(4),
    //             decoration: BoxDecoration(
    //               color: Colors.red[50],
    //               borderRadius: BorderRadius.circular(4),
    //             ),
    //             child: Icon(
    //               Icons.close,
    //               size: 16,
    //               color: Colors.red[400],
    //             ),
    //           ),
    //         ),
    //       ],
    //     );
    //   case BookingStatus.cancelled:
        // return Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //   decoration: BoxDecoration(
        //     color: Colors.red,
        //     borderRadius: BorderRadius.circular(4),
        //   ),
        //   child: const Text(
        //     'Cancelled',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 13,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // );
    // }
  }
}
