import 'dart:io';

import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/profile/barber_details_screen.dart';
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:dizisalon_vender/view_model/baber_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/barberlist_model.dart';
import '../../view_model/home_viewmodel.dart';
import '../barber/add_barber_form.dart';

class BarberListScreen extends StatefulWidget {
  const BarberListScreen({super.key});

  @override
  State<BarberListScreen> createState() => _BarberListScreenState();
}

class _BarberListScreenState extends State<BarberListScreen> {
   final barber = Get.find<BarberViewmodel>();
      final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance
        .addPostFrameCallback((_) =>barber.allBarber());
    
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title:  Text('Barber List', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF002B5B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                  if (home.homemodel.value.messages?.data?.salonServices?.length==0) {
                    ShowToast(msg: "First You have to Add your Salon SErvice then Add Barber");
                  }else
                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddBarberScreen(),
                                  ),
                                );
                
              },
              icon: const Icon(Icons.add_circle_outline, size: 24,color: Colors.white,),
              label:  Text("Add Barber", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller:  barber.barberserch,
              onChanged: (val){
                barber.searchBarber(search: val);
              },
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  // borderRadius: BorderRadius.circular(12),
                
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for Barbers',
                filled: true,
                // fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Listing of Barbers',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Obx(
              ()=>barber.isLoading.value?Center(child: CircularProgressIndicator(),):barber.allbarberModel.value.data?.barber?.length==0
              ?RefreshIndicator(onRefresh: ()async{await barber.allBarber();}, child: SingleChildScrollView(
           physics: AlwaysScrollableScrollPhysics(), // Ensures the scroll view is always scrollable
          child: SizedBox(height: 300,child: Center(child: Text("No Barber"),),))):
          RefreshIndicator(onRefresh: ()async{await barber.allBarber();},
            child:barber.barberserch.text.isNotEmpty?barber.barbersearchList.value.isEmpty?Center(child: Text("No Barber"),):
            ListView.builder(
                  itemCount: barber.barbersearchList.value.length??0,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context,int){
                  return       barberTile(
                    barber: barber.barbersearchList.value[int],
                        context: context
                
                      );
                }): 
            ListView.builder(
                  itemCount: barber.allbarberModel.value.data?.barber?.length??0,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context,int){
                  return       barberTile(
                    barber: barber.allbarberModel.value.data?.barber?[int],
                        context: context
                
                      );
                }),
          ),
            ),
            SizedBox(height: 30,)
            // Expanded(
            //   child: ListView(
            //     children: [
            //       barberTile(
            //         name: "Manish Singh",
            //         phone: "+91 6375445824",
            //         waiting: "#8",
            //         time: "5:15 PM",
            //         image: 'https://via.placeholder.com/150',
            //         isPresent: false,
            //         context: context

            //       ),
            
            //       barberTile(
            //         name: "Sumita",
            //         phone: "+91 6375445824",
            //         waiting: "#8",
            //         time: "5:15 PM",
            //         image: 'https://via.placeholder.com/150',
            //         isPresent: true,
            //         context: context

            //       ),
            //       barberTile(
            //         name: "Abhishek",
            //         phone: "+91 6375445824",
            //         waiting: null,
            //         time: null,
            //         image: null,
            //         isPresent: null,
            //         context: context
            //       ),
            //     ],
            //   ),
            // )
         
          ],
        ),
      ),
    );
  }

  Widget barberTile({
    required Barber? barber,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: (){
        // print("heelo");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BarberDetailsScreen(barberId: barber?.id??"",)));
      },
      child: Container(
        height: 100.h,
        margin: const EdgeInsets.symmetric(vertical: 4),
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300,blurRadius: 2,spreadRadius: 2)
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Container(
                            width: 8.h,
                            height: 100.h,
                            // alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
            
            const SizedBox(width: 8),
            Container(
              height: 89.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:barber?.profileImage != null ? NetworkImage("${"${AppUrl.imageApi}${barber?.profileImage??""}"}",):AssetImage("assets/image/no_image.png") )
              ),
            ),
            // CircleAvatar(
            //   radius: 30,
            //   backgroundImage: barber?.profileImage != null ? NetworkImage("${AppUrl.imageApi}${barber?.profileImage??""}") : null,
            //   // backgroundColor: image == null ? Colors.grey.shade300 : null,
            //   child: barber?.profileImage == null ? const Icon(Icons.person, size: 30) : null,
            // ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 4,),
                  Text(barber?.fullName??"", style:  GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        )),
                  Text("+91 ${barber?.contactNo??""}",style:  GoogleFonts.montserrat(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        )),
                  // if (waiting != null && time != null) ...[
                    Text("Waiting List: ${barber?.appoinmentCount??"0"}",style: GoogleFonts.montserrat(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),),
                    // Text("Time: ${barber?.totime??""}"),
                    Text(
                      barber?.presentStatus =="0" ?"Absent": "Present" ,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight:FontWeight.bold,
                        color: barber?.presentStatus=="0" ? Colors.red:Colors.green,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  // ],
                  
                  SizedBox(height: 4,),
                ],
              ),
            ),
            // Spacer(),
            // if (isPresent != null)
              Transform.translate(
                offset: const Offset(-10, 26),
                child: Obx(
                  ()=> ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                      minimumSize: Size.zero,
                      backgroundColor: Color(0xFF002B5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                         Get.find<BarberViewmodel>().deleteBarber(barberId: barber?.id??"").then((v){
                            if (v) {
                              return Navigator.pop(context);
                            }
                          });
                    },
                    child: Get.find<BarberViewmodel>().isLoading.value?Center(child: CircularProgressIndicator(),):  Text("Remove", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}