import 'package:flutter/material.dart';

class JumpingDotsScreen extends StatefulWidget {
  @override
  _JumpingDotsScreenState createState() => _JumpingDotsScreenState();
}

class _JumpingDotsScreenState extends State<JumpingDotsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentDot = 0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..addListener(() {
        if (_controller.status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          // Update the current dot index based on animation progress
          _currentDot = (_animation.value * 4).floor() % 4; // 4 dots
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: _currentDot == index ? 16.0 : 12.0,
      width: _currentDot == index ? 16.0 : 12.0,
      decoration: BoxDecoration(
        color: _currentDot == index ? Colors.grey.shade700 : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.sizeOf(context).height*0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Image.asset(
                'assets/image/onboarding/dizi-salon-high-resolution-logo-color-on-transparent-background (1) 1.png', // Replace with your logo asset
                height: 100,
              ),
          const SizedBox(height: 32),
      
          // Message Text
          // const Text(
          //   'Fetching Mobile Number and sending OTP',
          //   style: TextStyle(
          //     fontSize: 16,
          //     color: Colors.black54,
          //   ),
          // ),
      
          const SizedBox(height: 24),
      
          // Jumping Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, _buildDot),
          ),
        ],
      ),
    );
  }
}