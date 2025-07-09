import 'package:dizisalon_vender/screen/home/widget/detials_of_document.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/home_viewmodel.dart';

class SalonDetailsCard extends StatelessWidget {
   SalonDetailsCard({super.key});
 final home = Get.find<HomeViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Obx(
        ()=> Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
        children: [
          Image.asset("assets/icon/Group.png", height: 35,width: 35,fit: BoxFit.fill,),
          SizedBox(width: 6),
          Text("Salon Details ", style: TextStyle(color: const Color(0xFF002B5B),fontSize: 14,fontWeight: FontWeight.bold)),
          // Text(value, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Color(0xFF002B5B))),
        ],
            ),
                  // Text(
                  //   "Salon Details",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: home.cmsemodel.value.data?.salonDetails)));
                      },
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                        backgroundColor: const Color(0xFF002B5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("View More",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                    ),
                  ),
                ],
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoTile("assets/icon/barber-svg.png", "Barbers", "${home.homemodel.value.messages?.data?.mysalon?.barberCount??"0"}"),
                      SizedBox(height: 16),
                      _infoTile("assets/icon/order_svg.png", "Orders", "${home.homemodel.value.messages?.data?.mysalon?.customerCount??"0"}"),
                    ],
                  ),
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoTile("assets/icon/sale_svg.png", "Sale", "₹ ${home.homemodel.value.messages?.data?.mysalon?.totalSales??"0"}"),
                      SizedBox(height: 16),
                      _infoTile("assets/icon/feedback_svg.png", "Feedback", "${home.homemodel.value.messages?.data?.mysalon?.feedbackCount??"0"}"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF002B5B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Today's Order: ",
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        ),
                        TextSpan(
                          text: "${home.homemodel.value.messages?.data?.mysalon?.todayOrderCount??"0"}",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${home.homemodel.value.messages?.data?.mysalon?.lastorderuserName??"0"}",
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        ),
                        // TextSpan(
                        //   text: "5 min",
                        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 12),
                        // ),
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String icon, String title, String value) {
    return Row(
      children: [
        Image.asset(icon,height: 35,width: 35,fit: BoxFit.fill),
        SizedBox(width: 6),
        Text("$title: ", style: TextStyle(color: const Color(0xFF002B5B),fontSize: 14)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Color(0xFF002B5B))),
      ],
    );
  }
}
