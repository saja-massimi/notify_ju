// ignore_for_file: camel_case_types



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Models/reportModel.dart';
import 'package:notify_ju/Widgets/mic.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class addReport extends StatelessWidget {
  final String reportType;
  final description = TextEditingController();

  addReport({super.key, required this.reportType});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportsController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Report', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF69BE49),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                enabled: false,
                readOnly: true,
                decoration: const InputDecoration(
                hintText: 'Report Type : ', filled: true),
                controller: TextEditingController(text: reportType),
              ),
              const TextField(
                enabled: true,
                decoration:
                    InputDecoration(hintText: 'Address :', filled: true),
              ),
        
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                enabled: true,
                controller: description,
                decoration: const InputDecoration(
                  hintText: 'Description : ',
                  filled: true,
                ),
              ),
          
              TextField(
                keyboardType: TextInputType.datetime,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: 'date : ',
                  filled: true,
                ),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd - h:mm').format(DateTime.now()),
                ),
              ),
              
              const MicInput(),
              ElevatedButton(
                onPressed: () {

                  final report = reportModel(
                  report_id: randomAlphaNumeric(20),
                  report_type: reportType, 
                  incident_description: description.text,
                  report_date: DateTime.now(),
                  report_status: 'History',
                  );

                controller.createReport(report);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
