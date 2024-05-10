import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
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
                    if(items[index]["report_status"] == 'pending'){
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
                      secondaryBackground: Container(
                        color: Colors.blue,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd && items[index]["report_status"] == 'pending') {
                          controller.deleteReport(items[index]["report_id"]);
                        } else if (direction == DismissDirection.endToStart) {
                          //edit item stuff
                        }
                      },
                      child: Card(
                        color: const Color.fromARGB(184, 211, 207, 207),
                        child: ListTile(
                          title: Text(items[index]['report_type']),
                          subtitle: Text(items[index]['incident_description']),
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
