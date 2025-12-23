import 'package:dizisalon_vender/screen/mysalon/all_barberlist_screen.dart';
import 'package:dizisalon_vender/screen/mysalon/barber_details_widget.dart';
import 'package:dizisalon_vender/screen/mysalon/showQr_screen.dart';
import 'package:dizisalon_vender/screen/notification/notification_sccreen.dart';
import 'package:dizisalon_vender/screen/profile/profile_details_screen.dart';
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/app_url.dart';
import '../../model/orderlist_model.dart';
import '../loading_screen/loading_screen.dart';

class MySalonScreen extends StatefulWidget {
  const MySalonScreen({super.key});

  @override
  State<MySalonScreen> createState() => _MySalonScreenState();
}

class _MySalonScreenState extends State<MySalonScreen> {
  final salon = Get.find<SalonViewmodel>();
   final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
          salon.allOrderList();
    });
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:  Row(
          children: [
             Obx(()=> home.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)):   InkWell(
              onTap: (){
                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  ProfileDetailScreen(),
                              ),
                            );
              },
               child: CircleAvatar(
                radius: 16.r,
                            backgroundImage:home.homemodel.value.messages?.data?.loginUser?.logoImage==null?AssetImage("assets/image/userimage.png"):  NetworkImage('${AppUrl.imageApi}${home.homemodel.value.messages?.data?.loginUser?.logoImage??""}'), // Replace with actual image
                          ),
             )),
                        // SizedBox(width: 20,),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                        }, icon: Icon(Icons.notifications_outlined,size: 24.sp,color: Colors.grey,))
                        
          ],
        ),
        actions: [
          Image.asset("assets/image/splash_logo.png",height: 28.h,fit: BoxFit.cover,),
          SizedBox(width: 15,)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              ()=>home.isLoading.value||salon.isLoading.value?JumpingDotsScreen(): Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${home.homemodel.value?.messages?.data?.loginUser?.fullName??""}",
                        style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w600,color: Color(0xFF002B5B)),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Color(0xFF002B5B)),
                          SizedBox(width: 5),
                          Text("${DateFormat("dd, MMM, yyyy").format(DateTime.now())}",
                              style: GoogleFonts.montserrat(color: Color(0xFF002B5B))),
                        ],
                      ),
                    ],
                  ),
                 Stack(
                  fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      // strokeWidth: 40,
                      // strokeAlign: 2,
                      year2023: true,
                      value: 0.6,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.green),
                    ),
                  ),
                  Text(
                    '60%',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              )
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildOrderStats(),
            SizedBox(height: 20),
            _buildRecentCustomers(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStats() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 24.sp),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5,spreadRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            ()=>home.isLoading.value?SizedBox.shrink(): Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _orderStatItem(Icons.groups, "${home.homemodel.value.messages?.data?.mysalon?.todayOrderCount??"0"}", "Today Orders", Color(0xFF002B5B)),
                    // Spacer(),
                    SizedBox(height: 16,),
                    _orderStatItem(Icons.check_circle, "${home.homemodel.value.messages?.data?.mysalon?.todayCompleteOrder ??"0"}", "Completed", Colors.green),
                
                  ],
                ),
                SizedBox(width: 16.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _orderStatItem(Icons.history_rounded, "${home.homemodel.value.messages?.data?.mysalon?.todayPendingOrder ??"0"}", "Pending", Colors.orange),
                  
               SizedBox(height: 16,),
                _orderStatItem(Icons.cancel, "${home.homemodel.value.messages?.data?.mysalon?. todayCancelOrder??"0"}", "Cancelled", Colors.red),
              ],
            ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _orderStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Row(
          children: [
            
            Container(
  width: 50.w, // diameter = 2 * radius
  height: 50.h,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    
    border: Border.all(
      color: color, // border color
      width: 4.0.w,         // border width
    ),
  ),child: Icon(icon, color: color, size: 24.sp)),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.bold,color: color)),
                Text(label, style: GoogleFonts.montserrat(color: color,fontSize: 14.sp, decoration: TextDecoration.underline,fontWeight: FontWeight.w500, decorationColor: color,
                decorationThickness: 1)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentCustomers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Orders", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15.sp)),
            Row(
              children: [
                // ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(
                //   backgroundColor:Colors.white,
                //   foregroundColor: const Color(0xFF002B5B),
                //   // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //       // minimumSize: Size.zero,
                //       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                //       ), child: Text("Add Cust +"),),
                // SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBarberScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF002B5B),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(horizontal: 8.sp,vertical: 8.sp),
                      ),
                  child: Text("Show More", style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Obx(
         ()=>salon.allOrderlist.value.messages==null||salon.isLoading.value?Center(child: CircularProgressIndicator(),):salon.allOrderlist.value.messages?.appointments?.length==0?RefreshIndicator(onRefresh: ()async{await salon.allOrderList();}, child: SingleChildScrollView(
           physics: AlwaysScrollableScrollPhysics(), // Ensures the scroll view is always scrollable
          child: SizedBox(height: 300,child: Center(child: Text("No Booking"),),))):RefreshIndicator(onRefresh: ()async{await salon.allOrderList();}, child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: salon.allOrderlist.value.messages?.appointments?.length??0,
            itemBuilder: (context,int){
            return _customerCard(context,salon.allOrderlist.value.messages?.appointments?[int] );
             
          })),
        ),
  
      ],
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
                      margin: EdgeInsets.symmetric(vertical: 4.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 6,spreadRadius: 2,)
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color:orderItem?.isConfirm=="3"? Colors.red:orderItem?.isConfirm=="4"?Colors.green:Color(0xFF002B5B),
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
                width: 68.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200,blurRadius: 1,spreadRadius: 1),
                    
                  ],
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:orderItem?.customerProfile != null? NetworkImage("${AppUrl.imageApi}${
                                        orderItem?.customerProfile??""
                                        }"):AssetImage("assets/image/no_image.png")
                                        )
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
                                              Text(orderItem?.customerContact??"", style: TextStyle(color: Colors.grey,fontSize: 12.sp)),
                                               Text("${orderItem?.services?.map((t)=>t.serviceName??"").toList().join(",")??""}",overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 12.sp)),
                                              // SizedBox(width: 4),
                                             
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.compare_arrows, size: 24.sp,color: Colors.grey,),
                                     SizedBox(width: 8.w,),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(orderItem?.barberName??"",maxLines: 1, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                                            Text(orderItem?.barberPhone??"",maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 12.sp)),
                                            // SizedBox(),
                                              InkWell(
                                        onTap: ()async{
                                          if(orderItem?.isConfirm=="3"){
                                            ShowToast(msg: "Your Order Already Cancelled");
                                          }if(orderItem?.isConfirm=="4"){
                                            ShowToast(msg: "Your Order Already Completed");
                                          }else if (orderItem?.isConfirm=="0") {
                                            salon.updateOrder(apontId: orderItem?.appointmentId??"", status: "1");
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
                                                        customerName: orderItem?.customerName??"", singleback: true,
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
                                            orderItem?.isConfirm=="0"?"Confirm": orderItem?.isConfirm=="1"||orderItem?.isConfirm=="2"?"Complete": orderItem?.isConfirm=="3"? "Cancelled":"Completed",
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
