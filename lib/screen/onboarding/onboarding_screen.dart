import 'package:dizisalon_vender/screen/onboarding/onboard_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../auth/login/loginscreen.dart';

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
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      "image": "assets/image/onboarding/Group 33299.png",
      "title": "It's Time to save your\nPrecious Time",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      "image": "assets/image/onboarding/Barber-rafiki (1) 1.png",
      "title": "Professional & Best Quality\nSalon Services",
      "description":
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    },
    {
      "image": "assets/image/onboarding/Group 2.png",
      "title": "Get Your Best Look With\nOur Experts",
      "description":
          "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
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
          builder: (context) => SignInScreen(),
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
         _currentIndex==0?SizedBox(): DotsIndicator(
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
