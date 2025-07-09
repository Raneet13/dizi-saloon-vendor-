import 'dart:io';

import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/model/home_model.dart';
import 'package:dizisalon_vender/screen/salon_service/salon_service_screen.dart';
import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../view_model/home_viewmodel.dart';
import '../../mysalon/list_barber_form.dart';
 final home = Get.find<SalonViewmodel>();
// BuildContext? ctx = Get.context;

class SalonKycform extends StatefulWidget {
  LoginUser? saalon;
  bool isEdit;
   SalonKycform({this.saalon,this.isEdit=false,  super.key});

  @override
  State<SalonKycform> createState() => _SalonKycformState();
}

class _SalonKycformState extends State<SalonKycform> {
     final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance
        .addPostFrameCallback((_) {
          if (home.allFacilities.value.data==null) {
            home.allFacilitiesList();
          }else
          
          // .then((v){
          //   if (v) {
               if (widget.isEdit) {
           home.allFacilitiesList().then((v)=> home.viewSalondetails(barberId: widget.saalon?.id??""));
          }else{
           home.salonName.text=widget.saalon?.fullName??""; 
          }
          //   } else {
          //     null;
          //   }
          // });
          
         
          });
  }
  String formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); // or use DateFormat('hh:mm a') for "03:45 PM"
  return format.format(dt);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
          Image.asset("assets/image/splash_logo.png",height: 32.w,width:  115.h,),
          SizedBox(width: 20,)
        ],),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          ()=> Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please Provide your Salon Info for KYC", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15.sp)),
                _textField("Salon Name*",home.salonName),
                _textField("Salon Address*",home.salonAddr),
                _textField("State*",home.salonrstate),
                Row(
                  children: [
                    Expanded(child: _textField("City*",home.saloncity)),
                    SizedBox(width: 8),
                    Expanded(child: _textField("Zip Code*",home.salonpin)),
                  ],
                ),
                _amenitiesSection("Facilities"),
                _fileUploadImage(context,"Salon Logo", home.salonLogo.value,home.salonLogo_kyc.value),
                SizedBox(height: 16,),
                _fileUploadImage(context,"Salon Address Proof",home.salonaddressProof.value,home.salonaddressProof_kyc.value),
                SizedBox(height: 16),
                _imagePickerSection(context),
                SizedBox(height: 16),
                _timePickerSection("Salon Open Time","open",formatTimeOfDay(home.openTime.value!)),
                SizedBox(height: 8,),
                _timePickerSection("Salon Close Time","close",formatTimeOfDay(home.closeTime.value!)),
                SizedBox(height: 8,),
                _lunchTimeSection(),
                SizedBox(height: 16,),
                _availableDaysSection(),
                _textField("Number of Seats in Salon",home.salonSeat),
                // _textField("Number of Barbers in Salon",home.babercount),
                _locationSection(),
                SizedBox(height: 20),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(String hintText,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: 48.h,
        child: TextFormField(
          controller: controller,
          // autovalidateMode: AutovalidateMode.always,
          keyboardType: hintText=="Zip Code*"?TextInputType.number:null,
          inputFormatters:controller==home.salonpin? [
             LengthLimitingTextInputFormatter(6), // Max 6 characters
    FilteringTextInputFormatter.digitsOnly,
          ]:null,
          decoration: InputDecoration(
              //  errorText:  null,
    // helperText: '', // Reserve space for errorText
    errorStyle: TextStyle(height: 0.19),
    // helperStyle: TextStyle(height: 0.0),
    // isDense: true,  
            // constraints:  BoxConstraints(maxHeight: 48.h, minHeight: 48.h),
            
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(fontSize: 15.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8)
            ),
          ),
          validator: (value) {
            // if (controller==home.salonpin) {
              
            // }
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _amenitiesSection(String title) {
    // List<String> amenities = ["AC", "Sofa", "TV", "Newspaper", "WiFi", "Magazine"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Obx(
      ()=> Wrap(
        spacing: 10,
        children:home.isLoading.value|| home.allFacilities.value.message==null?[]: home.allFacilities.value.data!.map((item) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
              scale: 1.2, 
              alignment: Alignment.centerRight,
                child: Checkbox(
                   shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(width: 0.8, color: Colors.indigo.shade900),
                  ),
                   fillColor: MaterialStateProperty.all(Colors.white),
                   
                    checkColor: Colors.indigo.shade900,
                    
                  value: item.isSelect,
                   onChanged: (bool? value) {
                  item.isSelect=value!;
                  home.allFacilities.refresh();
                  // home.
                  // home.updateSalonfacilities(item.facilitiesId, value!);
                }),
              ),
              Transform.translate(offset: Offset(-10, 0), child: Text(item.facilitiesName??"",style: GoogleFonts.montserrat(fontSize: 15,color: Colors.grey.shade600),)),
            ],
          );
        }).toList(),
      ),)
      ]);
  }

 Widget _fileUploadImage(BuildContext context, String title,File? image,String kycImage) {
    return   Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade200,blurRadius: 1,spreadRadius: 2)
              ]
            ),
            child:
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: GoogleFonts.montserrat(fontSize: 15.sp)),
          // SizedBox(height: 8),
         Obx(
           ()=>home.isLoading.value?SizedBox(): Row(
                children: [
                  ElevatedButton(onPressed: () {
                    // print(home.salonImages);
                    if (title=="Salon Logo") {
                      home.insertFituredImage(context,"logo");
                    } else {
                      home.insertFituredImage(context,"addr");
                    }
                    
                  }, child: Text("Select", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                   image!=null||kycImage!=""?
                    // SizedBox(
                    //     height: 50,
                    //     width: 50,
                    //     child: Padding(
                    //           padding: EdgeInsets.only(right: 8),
                    //           child:  ClipRRect(
                    //                 borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                    //                 child: Image.file(
                    //                   image!,
                    //                   width: 50,
                    //                   height: 50,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),),
                    //   )
                        Flexible(child:image!=null?ClipRRect(
                                    borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                                    child: Image.file(
                                      image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ):
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                                    child: Image.network(
                                      "${AppUrl.imageApi}${kycImage}",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                   ,
                                   )  : 
                    Text("No file selected", style: TextStyle(color: Colors.grey)),
                ],
              ),
         ),
          
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _fileUploadSection(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              ElevatedButton(onPressed: () {
                // print(home.salonImages);
                home.getImages();
              }, child: Text("Select", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold))),
              SizedBox(width: 10),
               home.salonImages.value.length>0||home.salonImages_kyc.value.length>0?
                Obx(
                  ()=> Flexible(
                    child: SizedBox(
                      height: 50,
                      // width: 200,
                      child:home.salonImages.value.length>0? ListView.builder(
                        itemCount: home.salonImages.value.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,iint) {
                          // return Container(height: 30,width: 30, color: Colors.red,);
                          return Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                                  child: Image.file(
                                    home.salonImages.value[iint]!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Remove the image logic
                                      home.removeImage(iint);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ):ListView.builder(
                        itemCount: home.salonImages_kyc.value.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,iint) {
                          // return Container(height: 30,width: 30, color: Colors.red,);
                          return Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8), // Optional: for rounded square
                                  child: Image.network(
                                    "${AppUrl.newBaseImage}${home.salonImages_kyc.value[iint]!}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Positioned(
                                //   top: 0,
                                //   right: 0,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       // Remove the image logic
                                //       home.removeImage(iint);
                                //     },
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //         color: Colors.black.withOpacity(0.6),
                                //         shape: BoxShape.circle,
                                //       ),
                                //       padding: const EdgeInsets.all(4),
                                //       child: const Icon(
                                //         Icons.close,
                                //         color: Colors.white,
                                //         size: 16,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ): 
                Text("No file selected", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _dropdownField(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(border: OutlineInputBorder()),
        items: ["Salon Type 1", "Salon Type 2", "Salon Type 3"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {},
      ),
    );
  }

  Widget _imagePickerSection(BuildContext context) {
    return _fileUploadSection(context,"Images of Salon*");
  }

  Widget _timePickerSection(String title,String time,String userTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 48,
            // width: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color:  Color(0xFF002B5B),
              
              borderRadius: BorderRadius.circular(8)
            ),
            child:Text(title, style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),)
          ),
        ),
        SizedBox(width: 16,),
        // ElevatedButton(onPressed: () {}, child: ),
        Expanded(
          child: InkWell(
            onTap: (){
              home.selectTime(context: context, time: time);
            },
            child: Container(
              height: 48,
              // width: 150,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${userTime}",),
                  Icon(Icons.arrow_drop_down,color: Colors.grey,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _lunchTimeSection() {
    // return _timePickerSection("Lunch Time:");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 48,
            // width: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:  Color(0xFF002B5B),
              
              borderRadius: BorderRadius.circular(8)
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Lunch Time:",style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                Container(
                  height: 50,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
              color:  Colors.white,
              
              borderRadius: BorderRadius.circular(4)
            ),
            child: Text("1 hr",style: TextStyle(color: Colors.black),), 
                )
              ],
            ),
          ),
        ),
        // ElevatedButton(onPressed: () {}, child: ),
        SizedBox(width: 16,),
       Expanded(
         child: InkWell(
            onTap: (){
              home.selectTime(context: context, time: "launch");
            },
            child: Container(
              height: 48,
              // width: 150,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${formatTimeOfDay(home.launchTime.value!)}"),
                  Icon(Icons.arrow_drop_down,color: Colors.grey,)
                ],
              ),
            ),
          ),
       ),
      ],
    );
  }

  Widget _availableDaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Available Days", style:  GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        SizedBox(height: 4,),
        Row(
          children: home.weekSelection.value.map((char) {
            String day = char.keys.first;
            bool isSelected = char[char.keys.first]!;
            return InkWell(
              onTap: (){
                print(home.weekSelection.value);
                char[day]=!isSelected;
                home.weekSelection.refresh();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo.shade900 : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day,
                  style: GoogleFonts.montserrat(
                    color: isSelected ? Colors.white : Colors.indigo.shade900,
                    // fontWeight: FontWeight.bold,
                    fontSize: 14.sp
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _locationSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            
            decoration: InputDecoration(
              hintText: "Salon Location on Map",
              hintStyle: GoogleFonts.montserrat(fontSize: 15.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              
              suffixIcon:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(onPressed: () {}, child: Text("Open Map",style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),))),
              )
            ),
          ),
        ),
        // SizedBox(width: 8),
      //  ,
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Row(
      children: [
        // IconButton(onPressed: (){},
        // style: IconButton.styleFrom(
        //   backgroundColor: Colors.white,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //     side: BorderSide(color: Colors.grey)
        //   ),),
        //  icon: Icon(Icons.arrow_back,size: 24,)),
        //  SizedBox(width: 16,),
        Expanded(
          child: SizedBox(
            height: 50,
            child: Obx(
              ()=> ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // print("validate");
                    if (home.isLoading.value) {
                      null;
                    }else{
                  
                    home.kycSubmit(widget.isEdit?home.salondetails.value?.messages?.data?.singleBarber?.id??"" :"").then((v)async{
                      if (v) {
                       await Get.find<HomeViewmodel>().home();
                        // return Navigator.pop(context);
                        WidgetsBinding.instance.addPostFrameCallback((_){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListScreen(saalon: widget.saalon,)));
                        });
                      }
                    });
                    }
                  }
                  
                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>BarberListingScreen()));
                },
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.blue,
                  
                  minimumSize: Size(double.infinity, 50),
                ),
                child:home.isLoading.value?Center(child: CircularProgressIndicator(),): Text("${widget.isEdit?"Update":"Submit"}",style: GoogleFonts.montserrat(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
