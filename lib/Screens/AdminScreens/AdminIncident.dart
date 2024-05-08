import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportNotificationController.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminReportDetail.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class Incidents extends StatefulWidget {
  final String reportType;

  const Incidents({super.key, required this.reportType});

  @override
  State<Incidents> createState() => _IncidentsState();
}

final controller = Get.put(ReportNotification());

class _IncidentsState extends State<Incidents> {
  final controller = Get.put(ReportNotification());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.reportType} Reports'),
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

                      return ListTile(
                        tileColor: const Color.fromARGB(255, 202, 253, 198),
                        title: Text(items[index]['report_type']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminReportDetails(report: items[index]),
                            ),
                          );
                        },
                      );
                    });
              }
            }
          }),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
