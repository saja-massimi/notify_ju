import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          body: const Column(
            children: [
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  'Report Notification',
                  style: TextStyle(
                      fontSize: 25.2, color: Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 500,
                height: 200.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    'Report 1. car accident 2. faciluty of medicene',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
