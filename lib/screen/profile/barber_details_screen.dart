import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/barber/add_barber_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../view_model/baber_viewmodel.dart';
class BarberDetailsScreen extends StatefulWidget {
  String barberId;
   BarberDetailsScreen({required this.barberId, super.key});

  @override
  State<BarberDetailsScreen> createState() => _BarberDetailsScreenState();
}

class _BarberDetailsScreenState extends State<BarberDetailsScreen> {
  final barberdetails =Get.find<BarberViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
   WidgetsBinding.instance.addPostFrameCallback((_) {
      barberdetails.viewdetailsBarber(barberId: widget.barberId);
    });
  }
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
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Barber Details",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
      ),
      body:Obx(
        ()=>barberdetails.isLoading.value?Center(child: CircularProgressIndicator(),): Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: image, name, QR, remove
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image:  DecorationImage(
                      
                      image:barberdetails.barberdetails.value.messages?.data?.singleBarber?.profileImage!=null? NetworkImage('${AppUrl.imageApi}${barberdetails.barberdetails.value.messages?.data?.singleBarber?.profileImage??""}'):AssetImage("assets/image/no_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("${barberdetails.barberdetails.value.messages?.data?.singleBarber?.fullName??""}",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text("+91 ${barberdetails.barberdetails.value.messages?.data?.singleBarber?.contactNo??""}",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                     barberdetails.barberdetails.value.messages?.data?.services?.length==0?SizedBox(): Text("${barberdetails.barberdetails.value.messages?.data?.services?[0].serviceName??""}",
                          style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image.asset(
                    //   'assets/image/pointer.png',
                    //   width: 24,
                    //   height: 24,
                    // ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF002A6A),
                        minimumSize: const Size(70, 28),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onPressed: () async{
                        barberdetails.deleteBarber(barberId: barberdetails.barberdetails.value.messages?.data?.singleBarber?.id??"").then((v)async{
                          if (v){
                          //  await barber.allBarber();
                           Navigator.pop(context);
                          }
                        });
                      },
                      child:barberdetails.isLoading.value?Center(child: CircularProgressIndicator(),):  Text("Remove", style:  GoogleFonts.montserrat(fontSize: 12.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
        
            const SizedBox(height: 16),
        
            const Divider(),
        
            // Barber details
            Text.rich(
              TextSpan(
                text: "Barber Name:",
                style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: " ${barberdetails.barberdetails.value.messages?.data?.singleBarber?.fullName??""}",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            //  Text("  ${barberdetails.barberdetails.value.messages?.data?.singleBarber?.fullName??""}",
            //     style: GoogleFonts.montserrat(fontSize: 14)),
            
            const SizedBox(height: 14),
              Text.rich(
              TextSpan(
                text: "Phone Number:",
                style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: " +91 ${barberdetails.barberdetails.value.messages?.data?.singleBarber?.contactNo??""}",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            //  Text("  ",
            //     style: GoogleFonts.montserrat(fontSize: 14)),
            const SizedBox(height: 14),
            Text.rich(
              TextSpan(
                text: "Address:",
                style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: " ${barberdetails.barberdetails.value.messages?.data?.singleBarber?.address1??""}",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            //  Text(
            //   "Address:  ${barberdetails.barberdetails.value.messages?.data?.singleBarber?.address1??""}",
            //   style: GoogleFonts.montserrat(fontSize: 14),
            // ),
            const SizedBox(height: 8),
             Text("Available Time:  ${DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(barberdetails.barberdetails.value.messages?.data?.centerTimings?.first?.fromtime ??"")) } to ${DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(barberdetails.barberdetails.value.messages?.data?.centerTimings?.first?.totime ??""))}",
                style: GoogleFonts.montserrat(color: Colors.green, fontSize: 14,fontWeight: FontWeight.w600)),
        
            const SizedBox(height: 16),
        
            // Service table
           barberdetails.barberdetails.value.messages?.data?.services?.length==0?SizedBox(): Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children:  [
                  TableRow(
                    children: [
                      Text("Service Name",
                          style:  GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                      Text("Price",
                          style:  GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                      Text("Time",
                          style:  GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ...((barberdetails.barberdetails.value.messages?.data?.services ?? [])
        .asMap()
        .entries
        .map((entry) {
          // print(entry);
      // final service = entry.value;
      return TableRow(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Text("${entry.value.serviceName??""}",maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,)),
                      Text("Rs ${entry.value.servicePrice??""}",maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,),
                      Text("${entry.value.serviceTimeInMinutes??""} Min",maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,),
                    ],
                  );
    }).toList()),
                  
                  
                  // TableRow(
                  //   children: [
                  //     Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 6),
                  //         child: Text("Shaving")),
                  //     Text("50 Rs."),
                  //     Text("15Min."),
                  //   ],
                  // ),
                  // TableRow(
                  //   children: [
                  //     Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 6),
                  //         child: Text("Facial")),
                  //     Text("200Rs."),
                  //     Text("15Min."),
                  //   ],
                  // ),
                ],
              ),
            ),
        
            // const SizedBox(height: 16),
        
            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        // child: SizedBox(),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF002A6A),
                            minimumSize: const Size.fromHeight(40),
                          ),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddBarberScreen(barberDetailsModel: barberdetails.barberdetails.value,)));
                          },
                          icon: const Icon(Icons.edit_square, size: 18,color: Colors.white,),
                          label:  Text("Edit",style:  GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: const Color(0xFF002A6A),
                            minimumSize: const Size.fromHeight(40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Color(0xFF002A6A)),
                            ),
                          ),
                          onPressed: () {
                            makePhoneCall(barberdetails.barberdetails.value.messages?.data?.singleBarber?.contactNo??"");
                          },
                          child: const Text("Call Now",
                              style: TextStyle(color: Color(0xFF002A6A))),
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 12),
        
            // Absent Button
            SizedBox(
              height: 48.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:barberdetails.barberdetails.value.messages?.data?.singleBarber?.presentStatus=="0"? Colors.red:Colors.green,
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  if (!barberdetails.isLoading.value) {
                  barberdetails.barberupdateStatus(barberId: barberdetails.barberdetails.value.messages?.data?.singleBarber?.id??"",sts: barberdetails.barberdetails.value.messages?.data?.singleBarber?.presentStatus!="0"?"0":"1");  
                  }
                  
                  // print(barberdetails.barberdetails.value.messages?.data?.services?[0].toJson());
                },
                child:barberdetails.isLoading.value?Center(child: CircularProgressIndicator(),):  Text("${barberdetails.barberdetails.value.messages?.data?.singleBarber?.presentStatus=="0"?"Absent":"Present"}",style:  GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold)),
              ),
            )
                ],
              ),
            ),
        
           
          ],
        ),
            ),
      )
  ,
    );
  }
}

