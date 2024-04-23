import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/drawer.dart';
import '../Widgets/bottomNavBar.dart';

class ProfileModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

/*
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    studentIdController.dispose();
    phoneNumberController.dispose();
  }*/
}

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF69BE49),
        ),
        drawer: DrawerWidget(), // Use the DrawerWidget here
        body: Consumer<ProfileModel>(
          builder: (context, model, _) => SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: model.nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: model.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: model.studentIdController,
                  decoration: const InputDecoration(labelText: 'Student ID'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: model.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle save action
                    print('Save button pressed');
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            BottomNavigationBarWidget(), // Use the BottomNavigationBarWidget here
      ),
    );
  }
}
