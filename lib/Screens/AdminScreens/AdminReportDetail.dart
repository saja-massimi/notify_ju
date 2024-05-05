import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:intl/intl.dart';

class AdminReportDetails extends StatelessWidget {
  final Map<String, dynamic> report;


  final controller = Get.put(ReportsController());


  AdminReportDetails({super.key, required this.report});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Report Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF69BE49),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100.2,
              ),
              TextField(
                enabled: false,
                readOnly: true,
                decoration: const InputDecoration(
                hintText: 'Report Type : ', filled: true),
                controller: TextEditingController(text: report['report_type']),
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                readOnly: true,
                enabled: true,
                decoration:
                    const InputDecoration(hintText: 'Address :', filled: true),
                    controller: TextEditingController(text: report['incident_location']),
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                readOnly: true,
                maxLines: 5,
                enabled: true,
                controller: TextEditingController(text: report['incident_description']),
                decoration: const InputDecoration(
                  hintText: 'Description : ',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                keyboardType: TextInputType.datetime,
                enabled: false,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'date : ',
                  filled: true,
                ),
                controller: TextEditingController(
                  text: report['incident_date'] != null
                      ? DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              report['incident_date'].seconds * 1000))
                      : 'No date provided',
                ),
              ),
              const SizedBox(
                height: 20.2,
              ),
              
              //     File( 
              //   keyboardType: TextInputType.datetime,
              //   enabled: false,
              //   readOnly: true,
              //   decoration: const InputDecoration(
              //     hintText: 'date : ',
              //     filled: true,
              //   ),
              //   controller: TextEditingController(
              //     text: report['incident_date'] != null
              //         ? DateFormat('yyyy-MM-dd').format(
              //             DateTime.fromMillisecondsSinceEpoch(
              //                 report['incident_date'].seconds * 1000))
              //         : 'No date provided',
              //   ),
              // ),
              // const SizedBox(height: 20.2),
              ElevatedButton(
                onPressed: () {
                      //change report status
                      // report.changreportStatus('resolved');

                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

