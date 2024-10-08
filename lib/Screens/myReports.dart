import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Screens/editReport.dart';
import 'package:notify_ju/Screens/ReportDetails.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class MyReports extends StatefulWidget {
  const MyReports({Key? key}) : super(key: key);
  @override
  State<MyReports> createState() => _MyReportsState();
}

final controller = Get.put(ReportsController());

class _MyReportsState extends State<MyReports> {
  Future<void> _confirmDelete(String reportId) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this report?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      controller.deleteReport(reportId);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        backgroundColor: const Color(0xFF464A5E),
        centerTitle: true,
        title: const Text('My Reports', style: TextStyle(color: Colors.white)),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: FutureBuilder(
        future: controller.viewCurrentReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching reports"));
            } else {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("You don't have any reports yet"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final items = snapshot.data!;
                      if (items[index]["report_status"] == 'Pending') {
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd &&
                                items[index]["report_status"] == 'Pending') {
                              _confirmDelete(items[index]["report_id"]);
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
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Get.to(
                                        () => EditReport(report: items[index]));
                                  },
                                ),
                                onTap: () {
                                  Get.to(() =>
                                      ReportDetails(report: items[index]));
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Card(
                            color: const Color.fromARGB(185, 227, 226, 226),
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: ListTile(
                              title: Text(items[index]['report_type'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  items[index]['incident_description'],
                                  maxLines: 1),
                              onTap: () {
                                Get.to(
                                    () => ReportDetails(report: items[index]));
                              },
                            ),
                          ),
                        );
                      }
                    });
              }
            }
          }
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
