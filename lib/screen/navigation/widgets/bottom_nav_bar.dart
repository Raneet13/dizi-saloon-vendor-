import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF002B5B),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 24),
        selectedLabelStyle: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.bold),
        onTap: onTabSelected,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/icon/home2.png'
                  : 'assets/icon/home.png',
              width: 24,
              height: 24,
               color:selectedIndex == 1? const Color(0xFF002B5B):null
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 1
                  ? 'assets/icon/barber-shop.png'
                  : 'assets/icon/salon.png',
              width: 24,
              height: 24,
              
              color:selectedIndex == 1? const Color(0xFF002B5B):Colors.grey.shade400,
            ),
            label: "My Soalon",
          ),
          BottomNavigationBarItem(
             icon: Image.asset(
              selectedIndex == 2
                  ? 'assets/image/onboarding/order.png'
                  : 'assets/image/onboarding/people 1.png',
                   width: 24,
              height: 24,
             color:selectedIndex == 2? const Color(0xFF002B5B):Colors.grey.shade400,),
            // activeIcon: Icon(Icons.groups,size: 24,
          //  ),
            // icon: Image.asset(
            //   selectedIndex == 2
            //       ? 'assets/icons/order.png'
            //       : 'assets/icons/order.png',
            //   width: 24,
            //   height: 24,
            // ),
            label: "Order",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_4_outlined,size: 24,),
          //   activeIcon: Icon(Icons.person_4,size: 24,),
            
          //   // icon: Image.asset(
          //   //   selectedIndex == 3
          //   //       ? 'assets/icons/cart2.png'
          //   //       : 'assets/icons/cart.png',
          //   //   width: 24,
          //   //   height: 24,
          //   // ),
          //   label: "Cart",
          // ),
          BottomNavigationBarItem(
            icon:Image.asset(
              selectedIndex == 3
                  ? 'assets/image/onboarding/navigation (1).png'
                  : 'assets/image/onboarding/user.png',
                   width: 24,
              height: 24,
             color:selectedIndex == 3? const Color(0xFF002B5B):Colors.grey.shade400,),
            // activeIcon: Icon(Icons.person_rounded,size: 24,),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
