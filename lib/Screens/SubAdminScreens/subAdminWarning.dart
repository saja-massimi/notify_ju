// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notify_ju/Controller/WarningsController.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminDrawer.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNavBar.dart';

class subAdminWarnings extends StatelessWidget {
    const subAdminWarnings({super.key});
  @override
  Widget build(BuildContext context) {

final cont = Get.put(WarningsController());
final currentUser = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
drawer: subsAdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title:  const Text(
        "All Warnings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),

        body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: cont.getAllWarnings(currentUser!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching warnings'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No warnings found'));
          }

          final warning = snapshot.data!;
          return ListView.builder(
            itemCount: warning.length,
            itemBuilder: (context, index) {
              final data = warning[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 7),
                height: 135,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: const Color.fromARGB(255, 163, 167, 189),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.black, size: 30),
                        const SizedBox(width: 16),
                        Expanded(
                          
                          child: Text(
                            data['message'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              data['subAdminEmail'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF464A5E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                                DateFormat.yMMMd()
                                  .add_jm()
                                  .format(data['timestamp'].toDate()),                                
                                  style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF464A5E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: const SubadminNavigationBarWidget(),

    );
  }
}