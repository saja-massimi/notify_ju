// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminRepDetails.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';

class Incidents extends StatefulWidget {
  final String reportType;

  const Incidents({super.key, required this.reportType});

  @override
  State<Incidents> createState() => _IncidentsState();
}

class _IncidentsState extends State<Incidents> {
  final controller = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.reportType} Reports'),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: StreamBuilder<dynamic>(
          stream: Stream.fromFuture(controller.getReports(widget.reportType)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching reports"));
            } else {
              if (snapshot.data == null) {
                return const Center(
                    child: Text("No reports for this category yet"));
              } else {
                return ListView.builder(
                    itemCount: (snapshot.data as List).length,
                    itemBuilder: (context, index) {
                      final items = snapshot.data!;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: const Color.fromARGB(185, 227, 226, 226),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            items[index]['report_type'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            items[index]['incident_description'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminReportDetails(report: items[index]),
                              ),
                            );
                          },
                        ),
                      );
                    });
              }
            }
          }),
      bottomNavigationBar: const AdminNavigationBarWidget(),
    );
  }
}
