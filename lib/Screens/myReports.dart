import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Screens/AdminScreens/editReport.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Reports'),
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
                    if(items[index]["report_status"] == 'Pending'){
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
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd && items[index]["report_status"] == 'pending') {
                          controller.deleteReport(items[index]["report_id"]);
                        } 
                      },
                      child: Card(
                        color: const Color.fromARGB(184, 211, 207, 207),
                        child: ListTile(
                          title: Text(items[index]['report_type']),
                          subtitle: Text(items[index]['incident_description']),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(() => EditReport(report: items[index]));
                            },
                          ),
                          onTap: () {
                            Get.to(() =>  ReportDetails(report: items[index]));
                          },
                        ),
                      ),
                    );
                  }else{
                    return Card(
                      color: const Color.fromARGB(184, 211, 207, 207),
                      child: ListTile(
                        title: Text(items[index]['report_type']),
                        subtitle: Text(items[index]['incident_description']),
                        onTap: () {
                          Get.to(() =>  ReportDetails(report: items[index]));
                        },
                      ),
                    );
                  }
              });
              }
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
