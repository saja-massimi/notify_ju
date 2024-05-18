import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class Warnings extends StatefulWidget {
  const Warnings({Key? key}) : super(key: key);

  @override
  State<Warnings> createState() => _WarningsAdminState();
}

final controller = Get.put(ReportsController());

class _WarningsAdminState extends State<Warnings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Warnings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: FutureBuilder(
        future: controller.viewAllHistoryReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching warnings"));
            } else {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text("No Warnings Yet"));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final items = snapshot.data!;

                    return Container(
                      key: Key(index.toString()),
                      child: ListTile(
                        tileColor: const Color.fromARGB(255, 202, 253, 198),
                        title: Text(items[index]['report_type']),
                        subtitle: Text(items[index]['incident_description']),
                        onTap: () {
                          // Get.to(()=> ReportDetails(report: items[index],));
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
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
