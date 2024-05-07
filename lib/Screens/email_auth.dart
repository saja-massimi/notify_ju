// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/SignupController.dart';

class email_auth extends StatefulWidget {
  const email_auth({Key? key}) : super(key: key);

  @override
  State<email_auth> createState() => _email_auth();
}

// ignore: camel_case_types
class _email_auth extends State<email_auth> {
  final controller = Get.put(SignupController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            'images/uniPic.jpeg',
            fit: BoxFit.cover,
            color: const Color(0xFF96DE7C),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3A652B).withOpacity(0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  children: [
                    Image(
                      image: AssetImage('images/uniLogo.png'),
                      width: 150,
                      height: 140,
                    ),
                    Text('Notify JU',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Enter your email",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              hintText: 'example@ju.edu.jo',
                            ),
                            controller: controller.email,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@ju.edu.jo')) {
                                return 'Enter your university email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                "Enter your Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              hintText: 'Password',
                            ),
                            controller: controller.password,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black),
                                      foregroundColor: MaterialStatePropertyAll(
                                          Colors.white),
                                      elevation: MaterialStatePropertyAll(4)),
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      controller.loginUser(
                                          controller.email.text,
                                          controller.password.text);
                                    }
                                  },
                                  child: const Text('Submit')),
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
