import 'package:flutter/material.dart';

class ContactUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.green)),
      home: ContactUs(),
    );
  }
}

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 239, 181),
      appBar: AppBar(
        title: const Text(
          'Contact us',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 30.2),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: const Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'phone number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
