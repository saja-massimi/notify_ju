// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/ReportDetails.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNavBar.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';

class subAdminNotifications extends StatefulWidget {
  const subAdminNotifications({super.key});

  @override
  State<subAdminNotifications> createState() => _subAdminNotificationsState();
}

class _subAdminNotificationsState extends State<subAdminNotifications> {
  final controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: FutureBuilder(
          future: controller.getReportStatus('Pending'),
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

                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd ||
                                direction == DismissDirection.endToStart) {
                              controller.changeReportStatus(
                                  'Under Review',
                                  items[index]['report_id'],
                                  items[index]['user_email']);
                              Get.to(() => ReportDetails(report: items[index]));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            height: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: const Color.fromARGB(185, 227, 226, 226),
                              elevation: 6,
                              child: ListTile(
                                title: Text(
                                  items[index]['report_type'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  items[index]['incident_description'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  items[index]['user_email'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        );
                      });
                }
              }
            }
          }),
      bottomNavigationBar: const subadminNavigationBarWidget(),
    );
  }
}
