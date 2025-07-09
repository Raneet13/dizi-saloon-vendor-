import 'package:dizisalon_vender/screen/auth/login/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../view_model/auth_viewmodel.dart';
import '../signup/signup_screen.dart';

class SignInScreen extends StatefulWidget {
   SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKeyy = GlobalKey<FormState>();

  // final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  
   final login = Get.find<AuthViewmodel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKeyy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                'assets/image/splash_logo.png',
                                height: 50,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/image/pointer.png',
                      height: 47,
                      width: 47,
                    ),
                  ),
                  const SizedBox(height: 20),
                   Text(
                    'Sign in',
                    style:  GoogleFonts.montserrat(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                   Text(
                    'Welcome! Please enter your mobile number',
                    style:   GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 16.sp,
                    ),
                  ),
                  const SizedBox(height: 30),
                   Text(
                    'Mobile Number',
                    style:  GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: login.phone,
                    // focusNode: FocusNode(),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter your mobile number',
                      prefixIcon: SizedBox(width: 20, child: Align(alignment: Alignment.centerRight, child: Text("+91  "))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (value.length != 10) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(
                      ()=> ElevatedButton(
                            onPressed: (){
                              
                              if (_formKeyy.currentState!.validate()) {
                                if (!login.isLoading.value) {
                                 login.getOtp(contact: login.phone.text.toString()).then((value){
                                  if (value!="") {
                                     Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPScreen(phoneNumber:login.phone.text,otp: value,),
                                  ),
                                );
                                  }
                               
                              }); 
                                }
                                
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF002B5B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child:login.isLoading.value?const Center(child: CircularProgressIndicator(),):  Text(
                              'Get OTP',
                              style:  GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    ),
                    ),
                    
                  
                  const SizedBox(height: 10),
                  // Row(
                  //    mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Are you a New User?",style:  GoogleFonts.montserrat(
                                fontSize: 16,
                                // color: const Color(0xFF002B5B),
                                fontWeight: FontWeight.w500,
                              )),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                          }, child: Text("Please Sign up!",style:  GoogleFonts.montserrat(
                                fontSize: 16,
                                color: const Color(0xFF002B5B),
                                fontWeight: FontWeight.w500,
                              ),))
                        ],
                      ),
                      // TextButton(onPressed: (){}, child: Text("Forget M"))
                  //   ],
                  // )
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
