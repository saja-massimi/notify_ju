import 'package:flutter/material.dart';
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
      drawer: DrawerWidget(), // Add the drawer here
      body: Builder(
        builder: (context) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 176, 168, 181),
                Color.fromARGB(255, 186, 181, 189),
                Color.fromARGB(255, 214, 209, 217),
                Color.fromARGB(255, 230, 228, 230),
                Color.fromARGB(255, 252, 252, 252),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
