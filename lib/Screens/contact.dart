import 'package:flutter/material.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:contactus/contactus.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class contact_us extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xFF464A5E),
        centerTitle: true,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: DrawerWidget(),
      body: ContactUs(
        email: 'Admin@ju.edu.jo',
        companyName: 'Contact Us',
        phoneNumber: '+96265355000',
        dividerThickness: 0,
        dividerColor: const Color.fromARGB(255, 175, 210, 134),
        website: 'https://www.ju.edu.jo/ar/arabic/Home.aspx',
        companyColor: Colors.white,
        textColor: Colors.black87,
        cardColor: Colors.white,
        taglineColor: Colors.white38,
        image: Image.asset(
          'images/uniLogo.png',
          scale: 2.0,
          alignment: const AlignmentDirectional(12.2, 13.1),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
