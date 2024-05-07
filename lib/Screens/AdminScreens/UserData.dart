import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/userModel.dart';
import 'package:notify_ju/Repository/user_repository.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';

class userData extends StatelessWidget {
  const userData( {super.key, required this.userEmail});
  final String userEmail;
  @override
  Widget build(BuildContext context) {
      final _userRepo = Get.put(UserRepository());
                        
    return  Scaffold(

      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: _userRepo.getUserDetails(userEmail),
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
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}