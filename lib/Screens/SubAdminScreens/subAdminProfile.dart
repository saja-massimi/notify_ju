// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Models/adminModel.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminDrawer.dart';
import 'package:notify_ju/Screens/SubAdminScreens/subAdminNavBar.dart';


class ProfileModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    studentIdController.dispose();
    phoneNumberController.dispose();
  }
}

final AdminController adminController = Get.put(AdminController());
final controller = Get.put(ProfileController());

class subsAdminProfile extends StatelessWidget {
  final Future<bool> isAdminFuture;

  const subsAdminProfile({super.key, required this.isAdminFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      drawer: subsAdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
  child: AdminPage(),
      ),
      bottomNavigationBar: const SubadminNavigationBarWidget(),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: controller.getAdminData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                adminModel admin = snapshot.data as adminModel;
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: admin.admin_name,
                        readOnly: true,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: admin.email,
                        readOnly: true,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: admin.admin_phone_num.toString(),
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        decoration:
                            const InputDecoration(labelText: 'Phone number'),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

