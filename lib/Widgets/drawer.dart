import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Controller/SignupController.dart';
import 'package:notify_ju/Screens/contact.dart';
import 'package:notify_ju/Screens/profile.dart';
import 'package:notify_ju/Screens/reportHistory.dart';
import 'package:notify_ju/Screens/viewMyPost.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  Future<String> getName() async {
    final profileData = Get.put(ProfileController());
      return await profileData.getUserName();
  }

  final controller = Get.put(SignupController());
  final controllerprof = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color:  Color(0xFF464A5E),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: ClipOval(
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Color.fromARGB(255, 215, 212, 212),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FutureBuilder<String>(
                  future: getName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      );
                    } else {
                      return const Text(
                        'Unknown',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          ListTile(                          
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: () {
              Get.to(()=>UserPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_rounded),
            title: const Text('Report History'),
            onTap: () {
              Get.to(() => const HistoryReports());
            },
          ),
          ListTile(
<<<<<<< HEAD
            title: const Text('My posts'),
            onTap: () {
              Get.to(ViewMyPost());
            },
          ),
          ListTile(
=======
            leading: const Icon(Icons.contact_mail_rounded),
>>>>>>> 5f15ce7c673c2dd8ab96e9db64b21f21a4dba453
            title: const Text('Contact Us'),
            onTap: () {
              Get.to(() => contact_us());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
