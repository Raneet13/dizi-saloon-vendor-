import 'package:dizisalon_vender/static/show_toast/showTost_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../model/salontype_model.dart';
import '../../../view_model/auth_viewmodel.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final login = Get.find<AuthViewmodel>();
   final _formKey = GlobalKey<FormState>();
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    login.clearSignup();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      login.viewallsalontype();
      print(login.salontypemodel.value.toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    
  
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () {
        //     // Handle back button press
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        
        padding: EdgeInsets.all(16),
        child: Obx(
          ()=> Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 3,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/image/pointer.png', // Replace with your logo asset
                      height: 60,
                    ),),
                SizedBox(height: 20),
                Text(
                  'Sign up',
                 style:  GoogleFonts.montserrat(
                                fontSize: 34.sp,
                                // color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                ),
                Text(
                  'Greeting From DiZi Salon!',
                  style: GoogleFonts.montserrat(
                    // color: Colors.white,
                    fontSize: 20.sp,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildInputField('Salon Owner Name*', 'e.g. John Doe',login.sownerName),
                SizedBox(height: 20),
                _buildInputField('Salon Name*', 'e.g. DiZi Salon',login.ssalonname),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
              "Salon Type",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
                    login.salontypemodel.value.data==null||login.isLoading.value?SizedBox(): 
                    DropdownButtonFormField<Gender>(
                        decoration: InputDecoration(
                          hintText: "Select Type",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        value: login.selectedGender.value.genderName==null?null:login.selectedGender.value,
                        items: login.salontypemodel.value.data?.gender!
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender.genderName??""),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (login.isLoading.value) {
                            null;
                          }else
                        login.updateGender(value!);
                        },
                        validator: (value) =>
                            value == null ? "Please select your Salon Type" : null,
                      ),
                  
                  ],
                ),
                  SizedBox(height: 20,),
                _buildPhoneNumberField(),
                SizedBox(height: 20),
                _buildOtpField(context),
              // SizedBox(height: 20),
                _buildInputField('E-Mail Address*', 'e.g. abc@gmail.com',login.semail),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Obx(
                    ()=> ElevatedButton(
                      onPressed: () {
                        print(login.selectedGender.value);
                        // Handle submit button press
                        if (_formKey.currentState!.validate()) {
                          // print("formvalidate");
                          if (login.isLoading.value) {
                            return null;
                          }else if(login.selectedGender.value.id == null){
                            // 
                            ShowToast(msg: "First Select your salon Type");
                          }else if(!login.verifiedPhone.value){
                            // 
                            ShowToast(msg: "First Verify Phone Number");
                          }else{
                            login.signup().then((v){
                              if(v){
                                Navigator.pop(context);
                              }
                            });
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
                      child:login.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
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
          style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 5),
        SizedBox(
        height: 48.h,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              errorStyle: TextStyle(height: 0.3),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey,width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
            ),
            validator: (value){
              if (controller==login.semail) {
                var isValid= RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(controller.text);
          if(isValid){
          
            return null;
          }else{
            return "Please Enter Valid Email Address";
          }
              }else  if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return Obx(
      ()=> Column(
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
                  controller: login.sphone,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  buildCounter: null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  readOnly: login.phonesendOtp.value,
                  decoration: InputDecoration(
                    
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
              SizedBox(width: 10),
              Obx(
                ()=>login.verifiedPhone.value?ElevatedButton(onPressed: (){
                  null;
                },
                 style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                child: Text("Verified",style: TextStyle(color: Colors.white, fontSize: 16),)) :
                ElevatedButton(
                  onPressed: () {
                    // Handle send button press
                    if (login.isLoading.value) {
                      null;
                    }else if(login.sphone.text.length<10){
                      ShowToast(msg: "Enter A Valid Phone Number");
                    }else
                    login.signupseendOtp( login.sphone.text.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:login.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): Text(
                    'Send',
                    style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField(BuildContext context) {

    return Obx(
      ()=>login.phonesendOtp.value&&!login.verifiedPhone.value? Column(
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
            login.phonesendOtp.value?  ElevatedButton(
                onPressed: () {
                  // Handle send button press
                  login.verifyPhone();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:login.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): Text(
                  'Verify',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ):SizedBox(),
            ],
          ),
          SizedBox(height: 5),
          PinCodeTextField(
                      appContext: context,
                      autoDisposeControllers: false,
                      pastedTextStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
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
                        inactiveColor: Colors.grey,
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
                      controller: login.sotp,
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
                 login.start.value==30? OutlinedButton(
                    onPressed: (){
                      login.startTimer(login.sphone.text.toString());
                  }, child: Text(
                    'Resend',
                    style: TextStyle(color: Color(0xFF002B5B), fontWeight: FontWeight.bold),
                  )):SizedBox()
                  ,
                SizedBox(width: 15),
              Text(
                  '00:${login.start.value}',
                  style: TextStyle(color: Colors.black),
                ),
              
                ],
              ),
              
                   
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: List.generate(4, (index) {
          //     return Container(
          //       width: 50,
          //       height: 50,
          //       margin: EdgeInsets.only(right: 12),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       child: Center(
          //         child: TextField(
          //           textAlign: TextAlign.center,
          //           style: TextStyle(fontSize: 24),
          //           keyboardType: TextInputType.number,
          //           maxLength: 1,
          //           decoration: InputDecoration(
          //             counterText: '',
          //             border: InputBorder.none,
          //           ),
          //         ),
          //       ),
          //     );
          //   }),
          // ),
      
      ],
      ):SizedBox(),
    );
  }
}