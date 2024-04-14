import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../drawer.dart';
import '../bottomNavBar.dart';

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
          title: Text('Profile'),
          backgroundColor: Color(0xFF69BE49),
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
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: model.emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: model.studentIdController,
                  decoration: InputDecoration(labelText: 'Student ID'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: model.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone number'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle save action
                    print('Save button pressed');
                  },
                  child: Text('Save'),
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
