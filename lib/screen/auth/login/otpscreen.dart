import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../view_model/auth_viewmodel.dart';
import '../../navigation/bottom_navigation.dart';


class OTPScreen extends StatefulWidget {
  final String otp;
  final String phoneNumber;

  const OTPScreen({super.key, required this.phoneNumber,required this.otp});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
      final login = Get.find<AuthViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login.otpController=TextEditingController(text: widget.otp);
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
              'OTP Verify',
                    style:  GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  Text(
            //   'OTP Verify',
            //         style:  GoogleFonts.montserrat(
            //           fontSize: 34.sp,
            //           fontWeight: FontWeight.w600,
            //         )
            // ),
            const SizedBox(height: 10),
            Text(
              'We have sent an OTP to +91 ${widget.phoneNumber}',
             
                    style:  GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      // fontWeight: FontWeight.bold,
                    )
            ),
            const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PinCodeTextField(
                        appContext: context,
                        autoDisposeControllers: false,
                        pastedTextStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
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
                          fieldHeight: 44.w,
                          fieldWidth: 44.w,
                          inactiveColor: Colors.grey,
                          inactiveFillColor: 
                          Colors.white,
                          selectedFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          activeColor: Colors.grey.shade300
                          // fieldOuterPadding: const EdgeInsets.only(right: 20)
                          //  fieldOuterPadding: EdgeInsets.zero, 
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        
                        // // errorAnimationController: errorController,
                        controller: login.otpController,
                        keyboardType: TextInputType.number,
                        
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
               
            // TextField(
            //   controller: login.otpController,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     hintText: 'Enter OTP',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide(color: Colors.grey[300]!),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide(color: Colors.grey[300]!),
            //     ),
            //   ),
            // ),
            
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(
                ()=> ElevatedButton(
                  onPressed: () {
                    if (widget.otp.toString()==login.otpController.text.toString()) {
                         login.login().then((value){
                                  if (value) {
                                     Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),result: (route)=>false
                              );
                                  }
                               
                              });
                     
                    }else{
                      ShowToast(msg: "Invalid OTP Input");
                    }
                 
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002B5B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:login.isLoading.value?const Center(child: CircularProgressIndicator(),):  Text(
                    'Verify OTP',
                   style:  GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
