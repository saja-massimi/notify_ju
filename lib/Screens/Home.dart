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
                Color(0xFF1b6770),
                Color(0xFF464A5E),
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
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 77.0), // Adjust top padding here
                  child: Text(
                    'Welcome aman aloudat!',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top:
                          110.0), // Adjust top padding here to position below the first text
                  child: Text(
                    'Your voice matters here.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 230, 230, 230),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 160, // Adjust the top position to make space for the text
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'How satisfied are you with JU services?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),

                          SizedBox(height: 20),
                          Text(
                            'Be part of the solution! Report any campus issues and help us improve the environment.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Add more widgets as needed
                          /*  Container(
                            height: 100,
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                'Placeholder for more content',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
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
