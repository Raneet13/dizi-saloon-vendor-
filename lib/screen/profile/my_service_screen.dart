import 'package:dizisalon_vender/model/my_service_model.dart';
import 'package:dizisalon_vender/screen/profile/edit_myservice_screen.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class MyServicesScreen extends StatelessWidget {
  int barber;
   MyServicesScreen({required this.barber, super.key});
 final service = Get.find<SalonViewmodel>();
   
   
void showShavingDialog(BuildContext context,Barber? barberdetails) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shaving",
                  style: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    // service.clearbarberservice();
                    },
                  child: const Icon(Icons.close, color: Color(0xFF002B5B)),
                )
              ],
            ),
            const SizedBox(height: 20),

            /// Barber Name
            Text(
              "Barber Name*",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              initialValue: "${barberdetails?.barberName??""}",
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Time
            Text(
              "Time",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: service.timeController,
              // initialValue: "${barberdetails?.barServiceTiming??""}",
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Price
            Text(
              "Price",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              // initialValue: barberdetails?.barServicePrice??"",
              controller: service.priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// Save Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // print(service.priceController.text);
                  service.updateService(serviceId: barberdetails?.barberServiceId??"", centerId: barberdetails?.barberUserId??"", serciceStatus:"1",price: service.priceController.text,time: service.timeController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002B5B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Save",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    // final barbers = [
    //   {"name": "Avinash", "time": "30 min.", "price": "100 Rs."},
    //   {"name": "Ajay", "time": "15 min.", "price": "100 Rs."},
    // ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Services"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(
        ()=>service.isLoading.value?Center(child: CircularProgressIndicator(),): Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("${service.salonService.value.messages?.data?[barber].serviceName??""}",
                  style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.w600)),
        
              const SizedBox(height: 12),
        
              // Table header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                color: const Color(0xFFF1F6FF),
                child: Row(
                  children:  [
                    // SizedBox(width: 30),
                    Expanded(
                        flex: 2,
                        child: Text("Barbers Name",
                            style: GoogleFonts.montserrat(fontSize: 10.sp,fontWeight: FontWeight.w500))),
                    Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("Time",
                                  style: GoogleFonts.montserrat(fontSize: 10.sp,fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                        flex: 1,
                        child: Text("Price",
                            style: GoogleFonts.montserrat(fontSize: 10.sp,fontWeight: FontWeight.w400))),
                          ],
                        )),// delete
                  ],
                ),
              ),
        
              // Barber List
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 1))),
                  child: Row(
                    children: [
                    
                      Expanded(
                        flex: 2,
                        child: Text("${service.salonService.value.messages?.data?[barber].barbers?[index].barberName??""}",style: GoogleFonts.montserrat(fontSize: 12.sp,fontWeight: FontWeight.w400)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("${service.salonService.value.messages?.data?[barber].barbers?[index].barServiceTiming??""}",style: GoogleFonts.montserrat(fontSize: 12.sp,fontWeight: FontWeight.w400))),
                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("${service.salonService.value.messages?.data?[barber].barbers?[index].barServicePrice??""}",style: GoogleFonts.montserrat(fontSize: 12.sp,fontWeight: FontWeight.w400)),
                              InkWell(
                                onTap: (){
                                  service.initserviceprrandtime(service.salonService.value.messages?.data?[barber].barbers?[index]);
                                  showShavingDialog(context,service.salonService.value.messages?.data?[barber].barbers?[index]);
                                },
                                child: const Icon(Icons.edit, size: 18)),
                        
                      // const Icon(Icons.delete,
                      //       color: Colors.red, size: 18),
                        
                               
                              ],
                            ))
                          ],
                        ),
                      ),
                     
                      
                    ],
                  ),
                );
              
              }, separatorBuilder: (context,int){
              return SizedBox(height: 4,);
              }, itemCount: service.salonService.value.messages?.data?[barber].barbers?.length??0)
              // ...barber!.barbers!.map((barber) {
              // }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
