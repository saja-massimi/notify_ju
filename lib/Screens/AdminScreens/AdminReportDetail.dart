
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Widgets/image_input.dart';
import 'package:notify_ju/Widgets/mic.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:intl/intl.dart';

class AdminReportDetails extends StatelessWidget {
  final String report;
  final description = TextEditingController();


  final controller = Get.put(ReportsController());


  AdminReportDetails({super.key, required this.report});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportsController());
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
                controller: TextEditingController(text: report.toString()),
              ),
              const SizedBox(
                height: 20.2,
              ),
              const TextField(
                enabled: true,
                decoration:
                    InputDecoration(hintText: 'Address :', filled: true),
              ),
              const SizedBox(
                height: 20.2,
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
              const SizedBox(
                height: 20.2,
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
              const ImageInput(),
              const MicInput(),
              const SizedBox(height: 20.2),
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

