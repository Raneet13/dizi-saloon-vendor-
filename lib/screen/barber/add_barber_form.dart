import 'dart:async';
import 'package:dizisalon_vender/model/barberdetails_model.dart';
import 'package:dizisalon_vender/screen/navigation/bottom_navigation.dart';
import 'package:dizisalon_vender/screen/order/order_screen.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../model/all_services_model.dart';
import '../../model/home_model.dart';
import '../../static/show_toast/showTost_msg.dart';
import '../../view_model/baber_viewmodel.dart';
import '../../view_model/salon_viewmodel.dart';
import '../salon_service/salon_service_screen.dart';
final barber = Get.find<BarberViewmodel>();

class AddBarberScreen extends StatefulWidget {
   LoginUser? saalon;
  BarberDetailsModel? barberDetailsModel;

  AddBarberScreen({this.barberDetailsModel,this.saalon, super.key});
  @override
  _AddBarberScreenState createState() => _AddBarberScreenState();
}

class _AddBarberScreenState extends State<AddBarberScreen> {
   final _formKey = GlobalKey<FormState>();
 final service = Get.find<HomeViewmodel>();
//  List<String> selectedServices = ['Hair Cut', 'Shaving', 'Shaving', 'Facial', 'Facial', 'Massage'];
  //   final List<Map<String, dynamic>> services = [
  //   {'name': 'Hair Cut', 'price': 50, 'isSelected': false,'id':'16'},
  //   {'name': 'Shaving', 'price': 20, 'isSelected': false,'id':'17'},
  //   {'name': 'Facial', 'price': 100, 'isSelected': false,'id':'18'},
  //   {'name': 'Massage', 'price': 80, 'isSelected': false,'id':'19'},
  // ];

  // List<SalonService> selectedServices = [];
//   void removeService(SalonService serrvic){
// selectedServices.remove(serrvic);
// setState(() {
  
// });
  // }
  void showFullScreenBottomSheet(BuildContext context) async{
   showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context,setStat) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Services', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Obx(
                    ()=> Expanded(
                      child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 18),
                            physics: AlwaysScrollableScrollPhysics(),
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            //   childAspectRatio: 1,
                            //   crossAxisSpacing: 8,
                            //   mainAxisSpacing: 4,
                            // ),
                        itemCount: service.homemodel.value.messages?.data?.salonServices?.length??0,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(service.homemodel.value.messages?.data?.salonServices?[index].serviceName??""),
                            // subtitle: Text('Price: \$${service.allService.value.data?[index]['price']}'),
                            value:service.homemodel.value.messages?.data?.salonServices?[index].isSelected,
                            onChanged: (bool? value) {
                              setStat(() {
                                service.homemodel.value.messages?.data?.salonServices?[index].isSelected=value!;
                    service.homemodel.refresh();
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  barber.barberservice(service.homemodel.value.messages!.data!.salonServices!);
                //  setStat(() {
                        // selectedServices = service.homemodel.value.messages!.data!.salonServices!
                        //     .where((service) => service.isSelected)
                        //     .toList();
                //       });
                //       setState((){});
                      Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF002B5B),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Submit',style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20)
                ],
              ),
            );
          },
        );
      },
    );
    
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
       WidgetsBinding.instance
        .addPostFrameCallback((_) {
         
               if (widget.barberDetailsModel!=null) {
            barber.initBarber(widget.barberDetailsModel);
          }
          });
  
  }
   @override
void dispose() {
  // barber.sotp.dispose(); // Only if you're not reusing it elsewhere
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(actions: [
          Image.asset("assets/image/splash_logo.png",height: 32.h,fit: BoxFit.cover,),
          SizedBox(width: 20,)
        ],),
      body: SafeArea(
        
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Obx(
            ()=>Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    'Barber And Services Listing',
                    style: GoogleFonts.montserrat(
                      // color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInputField('Barber Name*', 'e.g. John Doe',barber.baberName),
                  SizedBox(height: 12),
                  _buildPhoneNumberField(),
                  // SizedBox(height: 2),
                       _buildOtpField(context),
                SizedBox(height: 20),
                 _textField("Barber Address*",barber.barbaerAdd),
                _textField("State*",barber.barberstate),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _textField("City*",barber.babercity)),
                        SizedBox(width: 8),
                        Expanded(child: _textField("Zip Code*",barber.baberpin)),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
              'Available Time',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                      ),SizedBox(height: 5,),
                    Row(
                          children: [
                            Expanded(child: timeBox('From :', barber.fromTime.value, true)),
                            const SizedBox(width: 8),
                            Expanded(child: timeBox('To :', barber.toTime.value, false)),
                          ],
                        ),
                  ],
                ),
                  SizedBox(height:20),
                Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Passport Size Photo", style: GoogleFonts.montserrat(fontSize: 16.sp,color: Colors.grey.shade700,)),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                barber.insertFituredImage(context);
                              },//_pickImage,
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF002B5B)),
                              child: Text("Select", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 12),
                            Expanded(child: Text(
                              barber.uploadPick.value != null ? "${barber.uploadPick.value!.path}" : "No file selected",maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
              
                  // Service chips
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       barber.selectedServices.length==0?SizedBox(): Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:  barber.selectedServices
                              .map((service) => Chip(
                                    label: Text(service.serviceName??"", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                                    labelStyle: TextStyle(color: Colors.white),
                                    backgroundColor: Color(0xFF002B5B),
                                    deleteIcon: CircleAvatar(radius: 12,backgroundColor: Colors.white, child: Icon(Icons.close,size: 16, color: Colors.indigo.shade900)),
                                    onDeleted: () =>barber.removeService(service),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => showFullScreenBottomSheet(context),
                          child: Row(
                            children: [
                              Text("Add Services", style: GoogleFonts.montserrat(color: Color(0xFF002B5B))),
                              SizedBox(width: 4),
                              Icon(Icons.add_circle_outline, color: Color(0xFF002B5B)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
              
                  // Service input fields
                  Obx(
                    ()=> Column(
                      children: barber.selectedServices.map((service) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: serviceInputRow(service),
                      )).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                     widget.saalon!=null? IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListScreen(saalon: widget.saalon,editService: true,)));
                   },
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey)
          ),),
         icon: Icon(Icons.arrow_back,size: 24,)):SizedBox(),
         SizedBox(width: 16,),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child:
                          //  Obx(
                          //   ()=> 
                            ElevatedButton(
                              onPressed: () {
                                // print(login.selectedGender.value);
                                // // Handle submit button press
                                if (_formKey.currentState!.validate()) {
                                //   // print("formvalidate");
                              if(!barber.verifiedPhone.value){
                                // 
                                ShowToast(msg: "First Verify Phone Number");
                              }else{
                                  if (barber.uploadPick.value==null&&widget.barberDetailsModel==null) {
                                    ShowToast(msg: "First Upload Barber Image");
                                  }else if(barber.selectedServices.length==0){
                                    ShowToast(msg: "Choose service Whose be Barber Provided");
                                  }else{
                                    var selectedservice= barber.selectedServices.any((v)=>double.parse(v.servicePrice??"0") ==0||v.serviceTimeInMinutes=="0");//double.parse(v.servicePrice??"0") ==0||serviceTime=="100.0" )
                                    // print(selectedservice);
                                    if (selectedservice) {
                                     
                                      ShowToast(msg: "Make Sure services all are with Price and Time");
                                    }
                                    else
                                    barber.barberRegister(barber.selectedServices,widget.barberDetailsModel==null?"":widget.barberDetailsModel?.messages?.data?.singleBarber?.id??"").then((v)async{
                                      if (v&&widget.saalon!=null) {
                                      WidgetsBinding.instance.addPostFrameCallback((_){
                                          Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) => MainScreen(),
                                                                          ),result: (route)=>false
                                                                        );
                                      });
                                        
                        
                                         
                                        }else{
                                                 WidgetsBinding.instance.addPostFrameCallback((_){
                                                  barber.viewdetailsBarber(barberId: widget.barberDetailsModel?.messages?.data?.singleBarber?.id??"");
                        Navigator.pop(context);
                                                 });
                                        }
                                      });
                                  }
                                  }
                                
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                // backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child:
                              barber.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): 
                              Text(
                                '${widget.barberDetailsModel==null?"Submit":"Update"}',
                                style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                  // ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    Widget _buildInputField(String label, String hint,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 5),
        Obx(
         ()=>barber.isLoading.value?SizedBox(): SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                errorStyle: TextStyle(height: 0.19),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number*',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: barber.barberphone,
                maxLength: 10,
                
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                buildCounter: null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                readOnly: barber.verifiedPhone.value,
                decoration: InputDecoration(
                  suffix: Obx(
              ()=>barber.verifiedPhone.value?
              TextButton(onPressed: (){

              },
               style: TextButton.styleFrom(
                  // backgroundColor: Colors.green,
                   padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ), child: Text("Verified",style: GoogleFonts.montserrat(color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold),))
               :
               TextButton(
                onPressed: () {
                  // Handle send button press
                 if(barber.barberphone.text.isEmpty){
                  ShowToast(msg: "First Enter A Phone Number");
                 }else if (barber.barberphone.text.length<10) {
                    ShowToast(msg: "First Enter A Valid Phone Number");
                  }else
                  barber.signupseendOtp( barber.barberphone.text.toString());
                },
                style: TextButton.styleFrom(
                  // backgroundColor: Colors.blue,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                barber.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): 
                Text(
                  'Verify',
                  style: GoogleFonts.montserrat(color: Color(0xFF002B5B), fontSize: 16),
                ),
              ),
            ),
                  hintText: 'Phone Number',
                  prefixIcon: SizedBox(width: 20, child: Align(alignment: Alignment.centerRight, child: Text("+91  "))),
                  prefixStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                   counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                ),
                validator: (value){
            if (value == null || value.isEmpty) {
              return 'Please enter Phone Number';
            }
            return null;
          },
              ),
            ),
            // SizedBox(width: 10),
            // Obx(
            //   ()=>barber.verifiedPhone.value?
            //   ElevatedButton.icon(onPressed: (){

            //   },
            //    style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.green,
            //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //   icon: Icon(Icons.check,color: Colors.white,), label: Text("Verified",style: TextStyle(color: Colors.white, fontSize: 16),))
            //    :
            //    ElevatedButton(
            //     onPressed: () {
            //       // Handle send button press
            //      if(barber.barberphone.text.isEmpty){
            //       ShowToast(msg: "First Enter A Phone Number");
            //      }else if (barber.barberphone.text.length<10) {
            //         ShowToast(msg: "First Enter A Valid Phone Number");
            //       }else
            //       barber.signupseendOtp( barber.barberphone.text.toString());
            //     },
            //     style: ElevatedButton.styleFrom(
            //       // backgroundColor: Colors.blue,
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child:
            //     barber.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): 
            //     Text(
            //       'Send',
            //       style: TextStyle(color: Colors.white, fontSize: 16),
            //     ),
            //   ),
            // ),
          

          ],
        ),
      ],
    );
  }

  Widget _buildOtpField(BuildContext context) {

    return 
    Obx(
      ()=>barber.phonesendOtp.value&&!barber.verifiedPhone.value? 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'OTP',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
              ),
            barber.phonesendOtp.value?  
            ElevatedButton(
                onPressed: () {
                  // Handle send button press
                  barber.verifyPhone();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                barber.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)):
                 Text(
                  'Verify',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
              :SizedBox(),
            ],
          ),
          SizedBox(height: 5),
          PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      autoDisposeControllers: false,
                      length: 4,
                      obscureText: false,
                      // obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      // validator: (v) {
                      //   if (v!.length < 3) {
                      //     return "I'm from validator";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        inactiveColor: Colors.white,
                        inactiveFillColor: 
                        Colors.white,
                        selectedFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        fieldOuterPadding: const EdgeInsets.only(right: 20)
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      
                      // errorAnimationController: errorController,
                      controller: barber.sotp,
                      keyboardType: TextInputType.number,
                      
                       mainAxisAlignment: MainAxisAlignment.start,
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      
                    ),
              
               SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: (){
                      barber.startTimer(barber.barberphone.text.toString());
                  }, child: Text(
                    'Resend',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ))
                  ,
                SizedBox(width: 15),
              Text(
                  '00:${barber.start.value}',//
                  style: TextStyle(color: Colors.black),
                ),
              
                ],
              ),
              
                   
         
      
      ],
      ):SizedBox(height: 0,),
    );
  }
  Widget _textField(String hintText,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
         keyboardType: hintText=="Zip Code*"?TextInputType.number:null,
          inputFormatters:controller==barber.baberpin? [
             LengthLimitingTextInputFormatter(6), // Max 6 characters
    FilteringTextInputFormatter.digitsOnly,
          ]:null,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        validator: (value){
          if (controller==barber.baberpin) {
            if (value?.length == 6) {
              return null;
            }else{
              return 'Please enter a valid $hintText'; // Custom validation for pin code
            }
          }
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
      ),

    );
  }
  Widget serviceInputRow(SalonService serviceName) {
    // final FocusNode _focusNode = FocusNode();
    return Row(
      children: [
        Expanded(
          child: Container(
            // width: 90,
            padding: EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Color(0xFF002B5B),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(serviceName.serviceName??"", style: GoogleFonts.montserrat(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.bold)),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: double.tryParse(serviceName.servicePrice??"").toString() ),
            inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
  ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Price',
              hintStyle: TextStyle(color: Colors.grey.shade300),
               prefix: ( serviceName.servicePrice != null&&serviceName.servicePrice!.isNotEmpty &&  serviceName.servicePrice!="0" &&serviceName.servicePrice!="0.00")
          ? Text("Rs ", style: TextStyle(color: Colors.black))
          : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onChanged: (val){
              final index = barber.selectedServices.indexWhere((service) => service.serviceName == serviceName.serviceName);
  if (index != -1) {
    barber.selectedServices[index].servicePrice = val;
    // service.homemodel.refresh();
  }
  // setState(() {
    
  // });
              // selectedServices.
            },
            onFieldSubmitted: (v){
                  barber.barberservice(service.homemodel.value.messages!.data!.salonServices!);
                },
          ),
        ),
        SizedBox(width: 8),
        Obx(
          ()=>barber.isLoading.value?SizedBox(): Expanded(
            child:TextFormField(
              // focusNode: _focusNode,
                controller: TextEditingController(text: serviceName.serviceTimeInMinutes??""),
                keyboardType: TextInputType.number,
                inputFormatters: [
                   FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (val){
                  final index = barber.selectedServices.indexWhere((service) => service.serviceName == serviceName.serviceName);
                if (index != -1) {
                // var time=await  timeTaken();
                 barber.selectedServices[index].serviceTimeInMinutes = val;
               
                }
               
                },
                onFieldSubmitted: (v){
                  // print(barber.selectedServices[2].toJson());
                  // barber.selectedServices.refresh();
                  barber.barberservice(service.homemodel.value.messages!.data!.salonServices!);
               
                },
                decoration: InputDecoration(
                  hintText: 'Time Taken',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                  // suffix:serviceName.serviceTime==null?SizedBox(): Text("Min"),
                  
                  suffixText: "Min",
                  suffixStyle:  TextStyle(color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
            
          ),
        ),
      ],
    );
  }
  
  Widget timeBox(String label, TimeOfDay? selectedTime, bool isFrom) {
    String formatTimeOfDay(BuildContext context, TimeOfDay time) {
  final localizations = MaterialLocalizations.of(context);
  return localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
}
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,  style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () =>barber.selectTime(context: context,isFrom: isFrom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(formatTimeOfDay(context, selectedTime!),
                      // selectedTime != null
                      //     ? selectedTime.format(context)
                      //     :'', //(isFrom ? 'From' : 'To'),
                      overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,
                      style: TextStyle(
                        color: selectedTime != null ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  
                   Icon(Icons.access_time, color: Colors.indigo.shade900),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
//   timeTaken()async{
//     Duration _duration = Duration(hours: 0, minutes: 0);
//     await DurationPicker(
//               duration: _duration,
//               onChange: (val) {
//                 // setState(() => _duration = val);
//               },
//             );
//             print(_duration);
// //     final TimeOfDay? picked = await showTimePicker(
// //       context: context,
// //       initialTime: TimeOfDay.now(),
      
// //     );
// //     if (picked != null) {
// //      TimeOfDay time = picked;
// // String formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
// // // print(formattedTime);
// //        return formattedTime;
// //     }
//   }



}
