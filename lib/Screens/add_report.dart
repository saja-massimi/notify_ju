import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/categories.dart';
import 'package:notify_ju/Widgets/mic.dart';
import '../Widgets/image_input.dart';
import 'ReportNotification.dart';
import 'package:intl/intl.dart';

class addReport extends StatelessWidget {
  final String reportType;

  addReport({required this.reportType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 175, 210, 134),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 132, 60),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 30.0),
                const Text(
                  'new Report',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  enabled: false,
                  readOnly: true,
                  decoration: const InputDecoration(
                      hintText: 'Report Type : ', filled: true),
                  controller: TextEditingController(text: reportType),
                ),
                const SizedBox(
                  height: 20.2,
                ),
                const TextField(
                  enabled: true,
                  decoration:
                      InputDecoration(hintText: 'Address :', filled: true),
                ),
                SizedBox(
                  height: 20.2,
                ),
                const TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: 'description : ',
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 20.2,
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'date : ',
                    filled: true,
                  ),
                  controller: TextEditingController(
                    text:
                        DateFormat('yyyy-MM-dd - h:mm').format(DateTime.now()),
                  ),
                ),
                ImageInput(),
                MicInput(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'notifications',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white),
          ],
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          onTap: (int index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportNotification()),
              );
            } else if (index == 1) {
              // Replace `HomePage` with the desired home page widget
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categories()),
              );
            }
          },
        ));
  }
}
