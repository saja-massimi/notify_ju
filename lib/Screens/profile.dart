// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/profileController.dart';
import 'package:notify_ju/Models/userModel.dart';
import '../Widgets/drawer.dart';
import '../Widgets/bottomNavBar.dart';

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

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF69BE49),
        ),
        drawer: DrawerWidget(), 
        body:  SingleChildScrollView(
            padding:const EdgeInsets.all(16),
            child: FutureBuilder( 
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState== ConnectionState.done){
                  if(snapshot.hasData){
                    UserModel user = snapshot.data as UserModel;
                    return Form(
                      child: (Column(
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
                            decoration: const InputDecoration(labelText: 'Student ID'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: user.user_phone_num.toString(),
                            readOnly: true,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(labelText: 'Phone number'),
                          ),
                          const SizedBox(height: 16),
                      
                        ],
                      )),
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }else{
                    return const Center(child: Text("Something went wrong"));
                  }

                }else{
                  return const Center(child: CircularProgressIndicator());
                }
              },


            
            ),
          
        ),
        bottomNavigationBar:
            BottomNavigationBarWidget(), 
      
    );
  }
}
