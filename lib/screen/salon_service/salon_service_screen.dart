import 'package:dizisalon_vender/model/home_model.dart';
import 'package:dizisalon_vender/screen/barber/add_barber_form.dart';
import 'package:dizisalon_vender/screen/home/widget/link_kyc_form.dart';
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/all_services_model.dart';
import '../../view_model/home_viewmodel.dart';
import '../navigation/bottom_navigation.dart';
final service = Get.find<SalonViewmodel>();
class ServiceListScreen extends StatefulWidget {
    LoginUser? saalon;
    bool editService;
   ServiceListScreen({required this.saalon,this.editService=false, super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
 final home = Get.find<HomeViewmodel>();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
       WidgetsBinding.instance
        .addPostFrameCallback((_){
          // if (service.allService.value.data==null) {
            service.allServiceList(salonType: widget.saalon?.salonType??"").then((v){
              ShowToast(msg: v.toString());
              if (v) {
                if (widget.editService) {
            service.setservice(home.homemodel.value.messages?.data?.salonServices);
          }
              }
            });
          // }
          
          if (widget.editService&&service.allService.value.data!=null) {
            service.setservice(home.homemodel.value.messages?.data?.salonServices);
          }
          });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/image/splash_logo.png', // replace with your logo
              height: 32.h,fit: BoxFit.cover
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('For Men', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
            //  Text("Male"),
              _buildGrid(service.allService.value.data ?? []),
    //           Text("Female"),
    //           _buildGrid(service.allService.value.data
    // ?.where((service) => service.genderId == "2")
    // .toList() ?? []),
    //           Text("Other"),
    //           _buildGrid(service.allService.value.data
    // ?.where((service) => service.genderId == "3")
    // .toList() ?? []),
              SizedBox(height: 20),
              // Text('For Women', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(height: 4),
              // Text('Select the services that you want to list'),
              // _buildGrid(womenServices),
              // Spacer(),
              Row(
                children: [
                   IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SalonKycform(saalon: widget.saalon,isEdit: true,)));
                   },
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey)
          ),),
         icon: Icon(Icons.arrow_back,size: 24,)),
         SizedBox(width: 16,),
                   Expanded(
          child: SizedBox(
            height: 50,
            
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                          if (service.isLoading.value) {
                            null;
                          }else{
                            service.salonServiceAdd().then((v)async{
                        if (v) {
                         await Get.find<HomeViewmodel>().home();
                         WidgetsBinding.instance.addPostFrameCallback((_){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBarberScreen(saalon: widget.saalon,)));});
                          // return Navigator.pop(context);
                        }
                      });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF002B5B),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:service.isLoading.value?Center(child: CircularProgressIndicator(),): Text('Submit'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Datum> services) {
    var male = services.where((service) => service.genderId.toString() == "1")
    .toList() ?? [];
      var female = services.where((service) => service.genderId.toString() == "2")
    .toList() ?? [];
      var other = services.where((service) => service.genderId.toString() == "3")
    .toList() ?? [];
    // print(services[0].toJson());
    return Obx(
      ()=> service.allService.value.message==null?Center(child: CircularProgressIndicator(),): Column(
        children: [
            male.length==0?SizedBox(): Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("For Men",style: GoogleFonts.openSans(fontSize: 20.sp,fontWeight: FontWeight.bold,)),
                 Text('Select the services that you want to list',style: GoogleFonts.openSans(fontSize: 14.sp,fontWeight: FontWeight.w400,),),
           SizedBox(height: 8,),
              Padding( 
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: male.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                          Transform.scale(
                      scale: 1.2, 
                      alignment: Alignment.centerRight,
                        
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 0.8, ),
                            ),
                             fillColor: MaterialStateProperty.all(Colors.white),
                             
                              checkColor: Colors.indigo.shade900,
                            value: male[index].isSelected, 
                            onChanged: (v) {
                            service.allService.value.data?[index].isSelected=v!;
                            service.allService.refresh();
                                
                          }),
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            male[index].serviceMasterName??"",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.jost(fontSize: 16.sp,color: Colors.grey.shade700,fontWeight: FontWeight.w400,)
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
       
            female.length==0?SizedBox(): Column(
            children: [
                 Text("For Women",style: GoogleFonts.openSans(fontSize: 20.sp,fontWeight: FontWeight.bold,)),
                 Text('Select the services that you want to list',style: GoogleFonts.openSans(fontSize: 14.sp,fontWeight: FontWeight.w400,),),
          
              Padding( 
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: female.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                          Transform.scale(
                      scale: 1.2, 
                      alignment: Alignment.centerRight,
                        
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 0.8, ),
                            ),
                             fillColor: MaterialStateProperty.all(Colors.white),
                             
                              checkColor: Colors.indigo.shade900,
                            value: female[index].isSelected, 
                            onChanged: (v) {
                            service.allService.value.data?[index].isSelected=v!;
                            service.allService.refresh();
                                
                          }),
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            female[index].serviceMasterName??"",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.jost(fontSize: 16.sp,color: Colors.grey.shade700,fontWeight: FontWeight.w400,)
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
       
         other.length==0?SizedBox(): Column(
            children: [
                 Text("For Other",style: GoogleFonts.openSans(fontSize: 20.sp,fontWeight: FontWeight.bold,)),
                 Text('Select the services that you want to list',style: GoogleFonts.openSans(fontSize: 14.sp,fontWeight: FontWeight.w400,),),
          
              Padding( 
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: other.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                          Transform.scale(
                      scale: 1.2, 
                      alignment: Alignment.centerRight,
                        
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 0.8, ),
                            ),
                             fillColor: MaterialStateProperty.all(Colors.white),
                             
                              checkColor: Colors.indigo.shade900,
                            value: other[index].isSelected, 
                            onChanged: (v) {
                            service.allService.value.data?[index].isSelected=v!;
                            service.allService.refresh();
                                
                          }),
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            other[index].serviceMasterName??"",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.jost(fontSize: 16.sp,color: Colors.grey.shade700,fontWeight: FontWeight.w400,)
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 
