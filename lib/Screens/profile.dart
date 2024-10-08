// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Models/userModel.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import '../Controller/profileController.dart';

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

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
          title:
              const Text('My Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF464A5E),      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          initialValue: user.username,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: user.user_email,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: user.student_id,
                          readOnly: true,
                          decoration:
                              const InputDecoration(labelText: 'Student ID'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: user.user_phone_num.toString(),
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
      ),
      bottomNavigationBar:const BottomNavigationBarWidget() ,
    );
    
    
  }
}
