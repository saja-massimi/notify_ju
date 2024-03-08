import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 175, 210, 134),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 132, 60),
        ),
        body: ContactUs(
          email: 'Admin@ju.edu.jo',
          companyName: 'Contact Us',
          phoneNumber: '+96265355000',
          dividerThickness: 0,
          dividerColor: Color.fromARGB(255, 175, 210, 134),
          website: 'https://www.ju.edu.jo/ar/arabic/Home.aspx',
          companyColor: Colors.white,
          textColor: Colors.black87,
          cardColor: Colors.white,
          taglineColor: Colors.white38,
        ),
      ),
    );
  }
}
