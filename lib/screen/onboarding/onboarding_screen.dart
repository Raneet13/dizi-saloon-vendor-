import 'package:dizisalon_vender/screen/onboarding/onboard_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../auth/login/loginscreen.dart';
import '../home/domy_home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/image/onboarding/dizi-salon-high-resolution-logo-color-on-transparent-background (1) 1.png",
      "title": "It's Time to save your\nPrecious Time",
      "description":
          "Welcome to DIZI Salon — your smart way to beauty and grooming. Skip waiting lines and book appointments instantly with trusted salon experts near you. From quick haircuts to full makeovers, we bring premium services to fit your schedule. Save time, stay stylish, and enjoy the convenience of DIZI Salon anytime, anywhere."
 },
    {
      "image": "assets/image/onboarding/Group 33299.png",
      "title": "It's Time to save your\nPrecious Time",
      "description":
               "Discover effortless salon booking with DIZI Salon. Browse a wide range of services including hairstyling, skincare, and grooming — all from your phone. Transparent pricing, expert professionals, and instant scheduling make self-care easier than ever. Enjoy the comfort and convenience you deserve, powered by DIZI Salon."
},
    {
      "image": "assets/image/onboarding/Barber-rafiki (1) 1.png",
      "title": "Professional & Best Quality\nSalon Services",
      "description":
            "Experience top-notch beauty and grooming services with DIZI Salon. Every professional is handpicked to ensure quality, hygiene, and style perfection. Whether you’re preparing for an event or just need a refresh, our experts make sure you look and feel your best — every single time."
  },
    {
      "image": "assets/image/onboarding/Group 2.png",
      "title": "Get Your Best Look With\nOur Experts",
      "description":
              "Let DIZI Salon help you look your best with personalized care and professional touch. Our experts understand your style and bring it to life with precision and creativity. From trendy cuts to relaxing treatments, we make every session comfortable, convenient, and confidence-boosting."
 },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                if (index==_pages.length-1) {
                      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DomyHomeScreen(),
        ),
      );
                } else {
                    setState(() {
                  _currentIndex = index;
                });
                }
              
              },
              
              itemBuilder: (context, index) {
                return OnboardingPage(
                  image: _pages[index]["image"]!,
                  title:index==0?"": _pages[index]["title"]!,
                  description: _pages[index]["description"]!,
                );
              },
            ),
          ),
          SizedBox(height: 20),
        //  _currentIndex==0?SizedBox(): 
         DotsIndicator(
  dotsCount: _pages.length,
  position: _currentIndex.toDouble(),
  decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  ),
),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
