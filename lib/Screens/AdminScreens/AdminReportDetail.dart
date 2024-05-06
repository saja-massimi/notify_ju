import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:intl/intl.dart';

class AdminReportDetails extends StatefulWidget {
  final Map<String, dynamic> report;



  AdminReportDetails({super.key, required this.report});

  @override
  State<AdminReportDetails> createState() => _AdminReportDetailsState();
}

class _AdminReportDetailsState extends State<AdminReportDetails> {
  final controller = Get.put(AdminController());
final List<String> _dropdownItems = [
    'Pending',
    'Under Review',
    'Resolved',
    'On Hold',
    'Rejected',
  ];     
  @override
  Widget build(BuildContext context) {



    String? _selectedItem;


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
                controller: TextEditingController(text: widget.report['report_type']),
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                readOnly: true,
                enabled: false,
                decoration:
                    const InputDecoration(hintText: 'Address :', filled: true),
                    controller: TextEditingController(text: widget.report['incident_location']),
              ),
              const SizedBox(
                height: 20.2,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                readOnly: true,
                maxLines: 5,
                enabled: false,
                controller: TextEditingController(text: widget.report['incident_description']),
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
                  text: widget.report['report_date'] != null
                      ? DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.report['report_date'].seconds * 1000))
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
              const SizedBox(height: 20.2),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    value: _selectedItem,
                    items: _dropdownItems.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedItem = value!;
                      });
                    },
                  ),  
                  ElevatedButton(
                    onPressed: () {
                        
                        controller.changeReportStatus(_selectedItem!, widget.report['report_id'], widget.report['user_email']);
                  
                    },
                    child: const Text('Change Status'),
                  ),

                  
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

