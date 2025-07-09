import 'package:flutter/material.dart';

import '../customer/add_customer_form.dart';

class BarberListingScreen extends StatelessWidget {
  const BarberListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> services = [
      'Hair Cut',
      'Shaving',
      'Shaving',
      'Facial',
      'Facial',
      'Massage',
    ];

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {},
        // ),
        title: const Text('Barber Listing'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/image/splash_logo.png',
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Barber Listing',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildInputField('Barber Name*', 'e.g. Junny'),
            SizedBox(height: 20),
            _buildPhoneNumberField(),
            SizedBox(height: 20),
            _buildOtpField(),
            SizedBox(height: 10),
            Text(
              'Resend',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '00:30',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            _buildTextField("Barber Address"),
            _buildTextField("State*"),
            Row(
              children: [
                Expanded(child: _buildTextField("City*")),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField("Zip Code*")),
              ],
            ),
            const SizedBox(height: 16),
            _buildFileUploadBox(),
            const SizedBox(height: 16),
            _buildServiceChipsBox(services),
            const SizedBox(height: 16),
            ...services.map((service) => _buildServiceInputRow(service)),
            _submitButton(context)
          ],
        ),
      ),
    );
  }
    Widget _submitButton(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerListingScreen(saalon: null)));
        },
        style: ElevatedButton.styleFrom(
          // backgroundColor: Colors.blue,
          
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFileUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            // offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Passport Size Photo",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          SizedBox(height:8,),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF002B5B)),
                child: const Text("Select"),
              ),
              const SizedBox(width: 12),
              const Text("No file selected"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChipsBox(List<String> services) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            // offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Services Provided by Barber", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: services
                .map(
                  (service) => Chip(
                    backgroundColor: const Color(0xFF002B5B),
                    label: Text(service, style: const TextStyle(color: Colors.white)),
                    deleteIcon: const Icon(Icons.close, color: Colors.white),
                    onDeleted: () {},
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Color(0xFF002B5B)),
            label: const Text("Add Services", style: TextStyle(color: Color(0xFF002B5B))),
          )
        ],
      ),
    );
  }

  Widget _buildServiceInputRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Container(
              // width: 90,
              height: 50,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF002B5B),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _buildTextField("Price")),
          const SizedBox(width: 10),
          Expanded(child: _buildTextField("Time Taken")),
        ],
      ),
    );
  }
   Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        SizedBox(height: 5),
        TextField(
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
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
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
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Handle send button press
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtpField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OTP',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(4, (index) {
            return Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

}
