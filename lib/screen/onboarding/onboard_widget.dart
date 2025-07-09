import 'package:flutter/material.dart';

import '../../core/mediaquery.dart';

class OnboardingPage extends StatelessWidget {
  final String image, title, description;
  double screenWidth = MediaQueryUtil.screenWidth;
    double screenHeight = MediaQueryUtil.screenHeight;


  OnboardingPage({super.key, 
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1),
          Image.asset(image, height: screenHeight * 0.22, width:screenWidth * 0.6, fit: BoxFit.fill,),
         title==""?SizedBox(): SizedBox(height: screenHeight * 0.05),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
         title==""?SizedBox():  SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}