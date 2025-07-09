import 'package:dizisalon_vender/model/my_service_model.dart';
import 'package:dizisalon_vender/screen/profile/my_service_screen.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class EditMyserviceScreen extends StatelessWidget {
   EditMyserviceScreen({super.key});
final service = Get.find<SalonViewmodel>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the method to fetch data after the first frame is rendered
      service.salonAllservice();
    });
    // service.salonAllservice();
    

    return Scaffold(
      appBar: AppBar(
        title:  Text("My Services Details",style: GoogleFonts.montserrat(fontSize: 25.sp,fontWeight: FontWeight.w600),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(
        ()=>service.isLoading.value? Center(child: CircularProgressIndicator(),): Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.centerRight,
              //   child:  Text("${service.salonService.value.messages?.data?[0].serviceName}",
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //       )),
              // ),
        
              // const SizedBox(height: 12),
        
              // Table header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                color: const Color(0xFFF1F6FF),
                child: Row(
                  children:  [
                    // SizedBox(width: 30),
                    Expanded(
                        flex: 2,
                        child: DropdownButton<Datum>(
            // value: selectedValue,
            underline: SizedBox(), // removes the underline
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
            hint: Text('Service',style: GoogleFonts.montserrat(fontSize: 10.sp,fontWeight: FontWeight.w500),),
            isExpanded: true,
            isDense: true,
            // alignment: Alignment.centerLeft,
            
            items: service.salonService.value.messages?.data?.map((Datum value) {
              return DropdownMenuItem<Datum>(
                value: value,
                child: Text(value.serviceName??""),
              );
            }).toList(),
            onChanged: (newVal) {
              service.changedSalonService(newVal??Datum());
              // setState(() {
              //   selectedValue = newVal!;
              // });
            },
          )
                        ),
                    Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("Appoinment Barber",
                                  style: GoogleFonts.montserrat(fontSize: 10.sp,fontWeight: FontWeight.w500)),
                            ),
                            Text("Status",
                                style: GoogleFonts.montserrat(fontSize: 10.sp,fontWeight: FontWeight.w500)),
                          ],
                        )),// delete
                  ],
                ),
              ),
        
              // Barber List
              // service.salonServiceSelection.value.barbers!.length==0?Center(child: Text("No Service"),):
              ListView.builder(
                shrinkWrap: true,
                itemCount: service.salonService.value.messages?.data?.length??0,
                itemBuilder: (context,int){
                 return InkWell(
                  onTap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyServicesScreen(barber: int,)),
                    );
                  },
                   child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black12, width: 1))),
                    child: Row(
                      children: [
                      
                        Expanded(
                          flex: 2,
                          child: Text(service.salonService.value.messages?.data?[int].serviceName??"",style: GoogleFonts.montserrat(fontSize: 12.sp,fontWeight: FontWeight.w400))
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                       service.salonService.value.messages!.data![int].barbers!
                           .map((barber) => barber.barberName ?? "")
                           .join(", "),
                       style: GoogleFonts.montserrat(
                         fontSize: 11.sp,
                         fontWeight: FontWeight.w400,
                       ),
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                       softWrap: true,
                     ), ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 GestureDetector(
                                          onTap: () {
                                            service.updateService(serviceId: service.salonService.value.messages?.data?[int].centerServiceId??"", centerId: service.salonService.value.messages?.data?[int].centerId??"", serciceStatus: service.salonService.value.messages?.data?[int].status==null||service.salonService.value.messages?.data?[int].status=="1"?"0":"1",price: "0");
                                            // setState(() {
                                            //   isToggled = !isToggled;
                                            // });
                                          },
                                          child:service.salonService.value.messages?.data?[int].status==null||service.salonService.value.messages?.data?[int].status=="1"? Container(
                                            width: 40.w,
                                            height: 19.h,
                                            decoration: BoxDecoration(
                                              color:  const Color(0xFF002B5B),
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text("Yes",
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ):Icon(Icons.toggle_off_outlined,size: 35.sp,color:  const Color(0xFF002B5B),),
                                        ),
                                      
                              //  Icon(Icons.edit_outlined, size: 25.sp, ),
                                                      
                                                    // const Icon(Icons.delete,
                                                    //       color: Colors.red, size: 18),
                                                      
                               
                              ],
                                                          )
                            ],
                          ),
                        ),
                       
                        
                      ],
                    ),
                                   ),
                 );
              
              })
              // ...service.salonServiceSelection.value.barbers!.map((barber) {
              // }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
