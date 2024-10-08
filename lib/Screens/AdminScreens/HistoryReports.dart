// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminRepDetails.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';

class HistoryReportsAdmin extends StatefulWidget {
  const HistoryReportsAdmin({super.key});

  @override
  State<HistoryReportsAdmin> createState() => _HistoryReportsAdminAdminState();
}

final controller = Get.put(AdminController());

class _HistoryReportsAdminAdminState extends State<HistoryReportsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Report History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: FutureBuilder(
        future: controller.getHistoryReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching reports"));
            } else {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text("No Reports Yet"));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
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
                  },
                );
              }
            }
          }
        },
      ),
      bottomNavigationBar: const AdminNavigationBarWidget(),
    );
  }
}
