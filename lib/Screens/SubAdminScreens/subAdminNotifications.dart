import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminDetails.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminDrawer.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNavBar.dart';

class subAdminNotifications extends StatefulWidget {
  const subAdminNotifications({super.key, required this.reportType});
  final List<String> reportType;

  @override
  State<subAdminNotifications> createState() => _subAdminNotificationsState();
}

class _subAdminNotificationsState extends State<subAdminNotifications> {
  final controller = Get.put(AdminController());
  String reportType = 'Pending';

  Widget buildReports(String status) {
    return FutureBuilder(
      future: controller.getReportStatus(status, widget.reportType),
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
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          items[index]['incident_description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          items[index]['report_status'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          await controller.changeReportStatus(
                            'Under Review',
                            items[index]['report_id'],
                            items[index]['user_email'],
                          );

                          setState(() {
                            items[index]['report_status'] = 'Under Review';
                          });

                          Get.to(() => subAdminReportDetails(report: items[index]));
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: subsAdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(color: Color.fromARGB(255, 212, 209, 214), width: 2),
                ),
                child: const Text(
                  'Pending Reports',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    reportType = 'Pending';
                  });
                },
              ),
              const SizedBox(width: 30),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(color: Color.fromARGB(255, 212, 209, 214), width: 2),
                ),
                child: const Text(
                  'On Hold Reports',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    reportType = 'On Hold';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: buildReports(reportType),
          ),
        ],
      ),
      bottomNavigationBar: const SubadminNavigationBarWidget(),
    );
  }
}
