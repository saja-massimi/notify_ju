import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class HistoryReports extends StatefulWidget {
  const HistoryReports({Key? key}) : super(key: key);

  @override
  State<HistoryReports> createState() => _HistoryReportsState();
}

  final controller = Get.put(ReportsController());
class _HistoryReportsState extends State<HistoryReports> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFEFF5EA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('History Reports'),
      ),
      body: FutureBuilder(
        future: controller.viewAllHistoryReports()  ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching reports"));
            } else {
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text("You don't have any reports yet"));
              } else {
                return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        final items = snapshot.data!; 
            
                        return Container(
                          key: Key(index.toString()) ,
                          child: ListTile(
                          
                            tileColor: const Color.fromARGB(255, 202, 253, 198),
                            title: Text(items[index]['report_type']),
                            subtitle: Text(items[index]['incident_description']),
                            onTap: () {
                              // Handle tapping on the card
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
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
