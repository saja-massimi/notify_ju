import 'package:flutter/material.dart';

class ReportNotification extends StatelessWidget {
  const ReportNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
          backgroundColor: const Color.fromARGB(255, 175, 210, 134),
          appBar: AppBar(
          title: const Center(child:  Text('Report Notification')),
          backgroundColor: const Color.fromARGB(255, 175, 210, 134),
          ),
          body: const Column(
            children: [
              SizedBox(
                width: 500,
                height: 200.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    'Report 1. Car Accident at Faculaty of Medicine',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
              ),
            ],
          ));
  
  }
}
