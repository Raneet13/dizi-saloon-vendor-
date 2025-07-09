import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/profile/ediit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/auth_viewmodel.dart';
import '../../view_model/home_viewmodel.dart';
import '../auth/login/loginscreen.dart';
import '../data_delition/data_deletion_screen.dart';

class ProfileDetailScreen extends StatelessWidget {
  //  ProfileDetailScreen({super.key});

 final profile = Get.find<HomeViewmodel>();
  final auth = Get.find<AuthViewmodel>();
  void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: Text("No"),
        ),
        ElevatedButton(
          onPressed: () {
            // Close dialog
            // Add your logout logic here
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
            print("User logged out");
          },
          child: Text("Yes"),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  EditUserDetailsScreen(user: profile.homemodel.value.messages?.data?.loginUser,)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF002B5B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                'Edit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(
          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileDetail('Name', '${profile.homemodel.value.messages?.data?.loginUser?.fullName??""}'),
              _buildProfileDetail('Email', '${profile.homemodel.value.messages?.data?.loginUser?.email??""}'),
              _buildProfileDetail('Contact Phone', '${profile.homemodel.value.messages?.data?.loginUser?.contactNo??""}'),
              _buildProfileDetail('Your Address', '${profile.homemodel.value.messages?.data?.loginUser?.address1??""}'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        image:  DecorationImage(
                          image:profile.homemodel.value.messages?.data?.loginUser?.logoImage==null?AssetImage("assets/image/userimage.png"):  NetworkImage('${AppUrl.imageApi}${profile.homemodel.value.messages?.data?.loginUser?.logoImage??""}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // _buildOptionTile(Icons.vpn_key, 'MPIN'),
              _buildOptionTile(Icons.notifications, 'Notification'),
              _buildDeleteAccountTile(context),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showLogoutDialog(context);
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF002B5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.grey[600]),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 18, color: Colors.black54),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildDeleteAccountTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
          leading: Icon(Icons.delete, color: Colors.grey[600]),
          title: const Text(
            'Delete My Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  DataDeletionScreen()),
                  );
          },
        ),
      ),
    );
  }
}
