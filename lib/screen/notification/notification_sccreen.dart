import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Today',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _notificationTile(
              icon: 'assets/image/app_icon.png',
              title: 'Password reset',
              subtitle: 'You have successfully reset your password.',
              time: '10:30 am',
              backgroundColor: const Color(0xFFEFF8FF),
            ),
            const SizedBox(height: 24),
            const Text(
              'Yesterday',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _notificationTile(
              icon: 'assets/image/app_icon.png',
              title: 'What is Lorem Ipsum?',
              subtitle: 'Lorem Ipsum is simply dummy text of the printing',
              time: '10:30 am',
            ),
            _notificationTile(
              icon: 'assets/image/app_icon.png',
              title: 'What is Lorem Ipsum?',
              subtitle: 'Have a safe and wonderful trip!',
              time: '10:30 am',
            ),
            _notificationTile(
              icon: 'assets/image/app_icon.png',
              title: 'Payment Successful',
              subtitle: 'Lorem Ipsum is simply dummy text',
              time: '12:30 am',
              backgroundColor: const Color(0xFFE8FAEC),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFF47C183)),
                onPressed: () {},
              ),
            ),
            _notificationTile(
              icon: 'assets/image/app_icon.png',
              title: 'What is Lorem Ipsum?',
              subtitle: 'Lorem Ipsum is simply dummy text of the printing',
              time: '10:30 am',
            ),
            _notificationTile(
              icon: 'assets/image/app_icon.png',
              title: 'What is Lorem Ipsum?',
              subtitle: 'Have a safe and wonderful trip!',
              time: '10:30 am',
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile({
    required String icon,
    required String title,
    required String subtitle,
    required String time,
    Color? backgroundColor,
    Widget? trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(icon, height: 50, width: 50),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              if (trailing != null) trailing,
            ],
          )
        ],
      ),
    );
  }
}
