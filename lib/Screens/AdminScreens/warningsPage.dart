import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Screens/AdminScreens/warningDetails.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';

class Warnings extends StatefulWidget {
  const Warnings({Key? key}) : super(key: key);

  @override
  State<Warnings> createState() => _WarningsAdminState();
}

class _WarningsAdminState extends State<Warnings> {
  final controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sub Admins',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.getAllAdmins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching admins'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No admins found'));
          }

          final admins = snapshot.data!;
          return ListView.builder(
            itemCount: admins.length,
            itemBuilder: (context, index) {
              final data = admins[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 7),
                height: 135,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: const Color.fromARGB(255, 207, 208, 214),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                  Get.to(WarningDetails(adminDetails: data,));
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['admin_name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['user_email'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF464A5E),
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const AdminNavigationBarWidget(),
    );
  }
}
