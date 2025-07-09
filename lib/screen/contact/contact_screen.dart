import 'package:dizisalon_vender/view_model/form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../static/show_toast/showTost_msg.dart';

class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({super.key});
  final form = Get.find<FormViewmodel>();
 final _formKey = GlobalKey<FormState>();
  showSuccessMessageDialog(BuildContext context) {
   showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button in the top-right corner
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 8),
            // Illustration
            Image.asset(
              'assets/image/mobile_icon.png', // Replace with your asset path
              height: 80,
            ),
            const SizedBox(height: 16),
            // Success message
            const Text(
              "You have successfully sent your message",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                     if (form.isLoading.value) {
                              return null;
                            }else{
                              form.contact(inqeryType: "1").then((v){
                                if (v) {
                                  Navigator.of(context).pop(); // Close the dialog
                                    // Navigator.of(context, rootNavigator: true).pop();
                                    // return true;
                                }
            
                              });
                            }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Continue"),
              ),
            ),
            
          ],
        ),
      ),
    ),
  );
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Illustration
                Center(
                  child: Image.asset(
                    'assets/image/onboarding/Barber-rafiki (1) 1.png', // Replace with your asset path
                    height: 150,
                  ),
                ),
                const SizedBox(height: 24),
                // Name Field
                const Text(
                  "Name*",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller:form.contactName,
                  decoration: InputDecoration(
                    hintText: "e.g., John Doe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                   validator: (value){
            if (value == null || value.isEmpty) {
              return 'Please enter Name';
            }
            return null;
          },
                ),
                const SizedBox(height: 16),
                // Mobile Number Field
                const Text(
                  "Mobile Number*",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller:form.contactPhone,
                  decoration: InputDecoration(
                    hintText: "123456789",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                   validator: (value){
            if (value == null || value.isEmpty) {
              return 'Please enter Phone Number';
            }
            return null;
          },
                ),
                const SizedBox(height: 16),
                // Email Address Field
                const Text(
                  "E-Mail Address*",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller:form.contactemail,
                  decoration: InputDecoration(
                    hintText: "johndoe@unisol.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                   validator: (value){
            if (value == null || value.isEmpty) {
              return 'Please enter Email Address';
            }
            return null;
          },
                ),
                const SizedBox(height: 16),
                // Message Field
                const Text(
                  "Message",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller:form.contactmessage,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Lorem Ipsum.......................................................",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                   validator: (value){
            if (value == null || value.isEmpty) {
              return 'Please enter Message';
            }
            return null;
          },
                ),
                SizedBox(height: 20,),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Obx(
                      ()=> ElevatedButton(
                        onPressed: () {
                          
                          // Handle submit button press
                          if (_formKey.currentState!.validate()) {
                            // print("formvalidate");
                         showSuccessMessageDialog(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:form.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)): Text(
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
}