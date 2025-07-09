import 'package:dizisalon_vender/model/home_model.dart';
import 'package:flutter/material.dart';

import '../salon_service/salon_service_screen.dart';

class CustomerListingScreen extends StatelessWidget {
  LoginUser? saalon;
   CustomerListingScreen({required this.saalon, super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> services = [
      'Hair Cut', 'Shaving', 'Shaving', 'Facial', 'Facial', 'Massage'
    ];

    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/image/splash_logo.png', height: 40),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'For Next Appointment will Book\n',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    TextSpan(
                      text: '<#8>',
                      style: TextStyle(color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' at the ',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    TextSpan(
                      text: '<5.15 PM 11-04-2023>',
                      style: TextStyle(color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Add Customer", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...[
              'Customer Name*',
              'Customer Phone Number*',
              'Customer E-Mail',
              'Customer Address',
              'Satate'
            ].map((text) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: text,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'City*',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Zip Code*',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Services Provided by Barber"),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: services.map((e) => Chip(
                      label: Text(e, style: const TextStyle(color: Colors.white)),
                      backgroundColor: const Color(0xFF002B5B),
                      deleteIcon: const Icon(Icons.close, color: Colors.white),
                      onDeleted: () {},
                    )).toList(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Add Services"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF002B5B),
                      elevation: 4,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: 'Barber Name*',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            value: null,
            items: const [
              DropdownMenuItem(
                value: "Barber 1",
                child: Text("Barber 1"),
              ),
              DropdownMenuItem(
                value: "Barber 2",
                child: Text("Barber 2"),
              ),
            ],
            onChanged: (value) {
              // Handle change
            },
          ),
        
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF002B5B),
                        ),
                        child: const Text("Select"),
                      ),
                      const SizedBox(width: 16),
                      const Text("No file selected")
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>ServiceListScreen(saalon: saalon,)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002B5B),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
