import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/profile/barbar_list_screen.dart';
import 'package:dizisalon_vender/screen/profile/edit_myservice_screen.dart';
import 'package:dizisalon_vender/screen/profile/my_service_screen.dart';
import 'package:dizisalon_vender/screen/profile/profile_details_screen.dart';
import 'package:dizisalon_vender/screen/profile/widget/my_salon_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../view_model/auth_viewmodel.dart';
import '../../view_model/home_viewmodel.dart';
import '../auth/login/loginscreen.dart';
import '../contact/contact_screen.dart';
import '../home/widget/detials_of_document.dart';
import '../home/widget/link_kyc_form.dart';
import '../mysalon/all_barberlist_screen.dart';
import '../refer_screen/refer_and_earning_screen.dart';
import '../review_screen/review_screen.dart';

class ProfileScreen extends StatelessWidget {
   final profile = Get.find<HomeViewmodel>();
   ProfileScreen({super.key});
   final auth = Get.find<AuthViewmodel>();
  void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    
    builder: (context) =>AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [

          Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.white, Colors.indigo,Colors.indigo.shade900],
        begin: Alignment.topRight,
        end: Alignment.bottomRight,
      ),
    borderRadius: BorderRadius.circular(12), // ✅ border radius
  ),
  padding: EdgeInsets.all(16),
  child: Icon(Icons.logout,size: 35,color: Colors.white,)),
          Text("Are you sure?",style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              // color: Colors.white,
                            ),),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 8.sp,),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Do you want to Logout',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '"Your Account"',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Text("Do you want to exit?",style: GoogleFonts.montserrat(
                            //   fontSize: 14,
                            //   fontWeight: FontWeight.w600,
                            //   color: Colors.black54,
                            // ),),
                            SizedBox(height: 16,),
                            SizedBox(
                              width: 120.w,
                              height: 48,
                              child: ElevatedButton(
                                    onPressed: () {
                                      auth.logout().then((v){
                                        if (v) {
                                          //logout Sucessfully
                                           Navigator.of(context).pop();
                                           Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),result: (route)=>false
                                );
                                        }
                                      });
                                     
                                    },
                                    child: Text("Yes",style: GoogleFonts.montserrat(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),),),
                            ),
                        // SizedBox(height: 8,),
                          TextButton(
                                  onPressed: () => Navigator.of(context).pop(false), // Cancel
                                  child: Text("Cancel",style: GoogleFonts.montserrat(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),),
                                ),
                                SizedBox(height: 16,),
                        
                          ],
                        ),
                      
      // actions: [
         
        
        
      // ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    auth.viewallsalontype();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 329.h,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF002B5B),
                  borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(50.r),
                    bottomRight: Radius.circular(50.r),
                  ),
                ),
                child: Obx(
                  ()=> Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            'Profile',
                            style: GoogleFonts.montserrat(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            iconAlignment: IconAlignment.start,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  SalonKycform(saalon: profile.homemodel.value.messages?.data?.loginUser,isEdit: true,),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.edit_square,
                              color: Color(0xFF002B5B),
                              size: 24,
                            ),
                            label:  Text(
                              'Edit',
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF002B5B),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: 10),
                       CircleAvatar(
                        radius: 67.r,
                        backgroundImage:profile.homemodel.value.messages?.data?.loginUser?.logoImage==null?AssetImage("assets/image/userimage.png"): NetworkImage('${AppUrl.imageApi}${profile.homemodel.value.messages?.data?.loginUser?.logoImage??""}'),
                      ),
                      const SizedBox(height: 15),
                       Text(
                        '${profile.homemodel.value.messages?.data?.loginUser?.fullName??""}',
                        style: GoogleFonts.montserrat(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                       Text(
                        '${profile.homemodel.value.messages?.data?.loginUser?.ownerName??""}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4,),
                       Text(
                        '${profile.homemodel.value.messages?.data?.loginUser?.email??""}',
                        style: GoogleFonts.montserrat(color: Colors.white70,fontSize: 14.sp, ),
                      ),
                       Text(
                        '${profile.homemodel.value.messages?.data?.loginUser?.address1??""}',
                        style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.white70),
                      ),
                      SizedBox(height: 12.h,)
                    ],
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  _buildOptionTile(Icons.blinds_closed_outlined, 'My Salon', () {
                    // debugPrint("Here");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  MySalonWidgetScreen()),
                    );
                  }),
                  // _buildOptionTile(Icons.calendar_today, 'Customer List',
                  //     () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) =>  AllBarberScreen()),
                  //   );
                  // }),
                  _buildOptionTile(Icons.settings_accessibility_rounded, 'My Barber',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  BarberListScreen()),
                    );
                  }),
                  _buildOptionTile(Icons.contact_mail_outlined, 'Contact Us', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ContactUsScreen()),
                    );
                  }),
                  _buildOptionTile(Icons.engineering_outlined, 'My Service', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  EditMyserviceScreen()),
                    );
                  }),
                  _buildOptionTile(Icons.share, 'Refer & Earn', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ReferAndEarnScreen()),
                    );
                  }),
                  _buildOptionTile(Icons.edit_square, 'Feedback', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  FeedbackScreen()),
                    );
                  }),
                  _buildOptionTile(Icons.security_sharp, 'privacy policy', () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsOfDocument(details: profile.cmsemodel.value.data?.privacyPolicy)));
                      
                  }),
                  _buildOptionTile(Icons.logout, 'Logout', () {
                    showLogoutDialog(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const ContactUsScreen()),
                    // );
                  }),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical:6),
        leading: Container(
          height: 44.h,
          width: 56.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child:
              Icon(icon, color: Color(0xFF002B5B)),
        ),
        title: Text(
          title,
          style:  GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
