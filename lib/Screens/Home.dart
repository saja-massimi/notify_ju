import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      drawer: DrawerWidget(),
      body: Container(
          decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF8D7999),
            Color.fromARGB(255, 176, 168, 181),
            Color.fromARGB(255, 201, 194, 205),
            Color.fromARGB(255, 252, 252, 252),
          ],
        ),

        /*
        image: DecorationImage(
          image: AssetImage('images/uniLogo.png'),
          fit: BoxFit.cover,
        ),*/
      )),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
