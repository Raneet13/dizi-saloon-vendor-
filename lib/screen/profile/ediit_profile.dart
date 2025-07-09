import 'package:dizisalon_vender/model/salontype_model.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../model/home_model.dart';
import '../../static/show_toast/showTost_msg.dart';
import '../../view_model/auth_viewmodel.dart';
final login = Get.find<AuthViewmodel>();
class EditUserDetailsScreen extends StatelessWidget {
  LoginUser? user;
 EditUserDetailsScreen({required this.user, super.key});
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => login.initprofile(user));
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/image/splash_logo.png', height: 28.h),
            // const SizedBox(width: 8),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Text(
                'Edit your Salon And Submit',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildInputField('Salon Owner Name*', 'e.g. John Doe',login.upsownerName),
              SizedBox(height: 20),
              _buildInputField('Salon Name*', 'e.g. DiZi Salon',login.upssalonname),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
            "Salon Type",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 5),
                  Obx(
                    ()=> DropdownButtonFormField<Gender>(
                        decoration: InputDecoration(
                          hintText: "Select Type",
                          border: OutlineInputBorder(),
                        ),
                        value:login.upselectedGender.value.id== null?null : login.upselectedGender.value,
                        items:login.salontypemodel.value.data?.gender!
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender.genderName??""),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // print(login.upselectedGender.value);
                        login.upupdateGender(value!);
                        },
                        validator: (value) =>
                            value == null ? "Please select your Salon Type" : null,
                      ),
                  ),
                ],
              ),
                SizedBox(height: 20,),
                 Obx(
                   ()=> Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Salon Logo"),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  login.insertFituredImage(context);
                                },//_pickImage,
                                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF002B5B)),
                                child: Text("Select"),
                              ),
                              SizedBox(width: 12),
                              Expanded(child: Text(
                                login.uploadlogoPick.value != null ? "${login.uploadlogoPick.value!.path}" : "No file selected",maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                 ),
                  SizedBox(height: 20),
              
              // _buildPhoneNumberField(),
              // SizedBox(height: 20),
              // _buildOtpField(context),
            // SizedBox(height: 20),
              _buildInputField('E-Mail Address*', 'e.g. abc@gmail.com',login.upsemail),
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
                        }else if(login.upselectedGender.value.id == null){
                          // 
                          ShowToast(msg: "First Select your salon Type");
                        }else{
                          login.updateProfile().then((v){
                            if (v) {
                              Get.find<HomeViewmodel>().home();
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
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
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
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
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
                controller: login.sphone,
                maxLength: 10,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                buildCounter: null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                readOnly: login.verifiedPhone.value,
                decoration: InputDecoration(
                  
                  hintText: 'Phone Number',
                  prefixText: "+91  ",
                  prefixStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                   counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
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
              ()=>login.verifiedPhone.value?ElevatedButton.icon(onPressed: (){},
               style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              icon: Icon(Icons.check,color: Colors.white,), label: Text("Verified",style: TextStyle(color: Colors.white, fontSize: 16),)) :ElevatedButton(
                onPressed: () {
                  // Handle send button press
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
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ],
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
          // PinCodeTextField(
          //             appContext: context,
          //             pastedTextStyle: TextStyle(
          //               color: Colors.green.shade600,
          //               fontWeight: FontWeight.bold,
          //             ),
          //             length: 4,
          //             obscureText: false,
          //             // obscuringCharacter: '*',
          //             // obscuringWidget: const FlutterLogo(
          //             //   size: 24,
          //             // ),
          //             blinkWhenObscuring: true,
          //             animationType: AnimationType.fade,
          //             // validator: (v) {
          //             //   if (v!.length < 3) {
          //             //     return "I'm from validator";
          //             //   } else {
          //             //     return null;
          //             //   }
          //             // },
          //             pinTheme: PinTheme(
          //               shape: PinCodeFieldShape.box,
          //               borderRadius: BorderRadius.circular(5),
          //               fieldHeight: 50,
          //               fieldWidth: 50,
          //               inactiveColor: Colors.white,
          //               inactiveFillColor: 
          //               Colors.white,
          //               selectedFillColor: Colors.white,
          //               activeFillColor: Colors.white,
          //               fieldOuterPadding: const EdgeInsets.only(right: 20)
          //             ),
          //             cursorColor: Colors.black,
          //             animationDuration: const Duration(milliseconds: 300),
          //             enableActiveFill: true,
                      
          //             // errorAnimationController: errorController,
          //             controller: login.sotp,
          //             keyboardType: TextInputType.number,
                      
          //              mainAxisAlignment: MainAxisAlignment.start,
          //             onCompleted: (v) {
          //               debugPrint("Completed");
          //             },
          //             // onTap: () {
          //             //   print("Pressed");
          //             // },
          //             onChanged: (value) {
          //               debugPrint(value);
          //               // setState(() {
          //               //   currentText = value;
          //               // });
          //             },
          //             beforeTextPaste: (text) {
          //               debugPrint("Allowing to paste $text");
          //               //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //               //but you can show anything you want here, like your pop up saying wrong paste format or etc
          //               return true;
          //             },
                      
          //           ),
          //      SizedBox(height: 10),
          //     Row(
          //       children: [
          //         TextButton(
          //           onPressed: (){
          //             login.startTimer(login.sphone.text.toString());
          //         }, child: Text(
          //           'Resend',
          //           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          //         ))
          //         ,
          //       SizedBox(width: 15),
          //     Text(
          //         '00:${login.start.value}',
          //         style: TextStyle(color: Colors.black),
          //       ),
              
          //       ],
          //     ),
              
                   
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
