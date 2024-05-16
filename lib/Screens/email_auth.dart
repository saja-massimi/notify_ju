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
          opacity: 0.4,
          child: Image.asset(
            'images/uniPic.jpeg',
            fit: BoxFit.cover,
            color: const Color(0xFF464A5E),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245).withOpacity(0.55),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/GradTransparentLogo.png'),
                      width: 250,
                      height: 240,
                    ),
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
                                " Enter your email",
                                style: TextStyle(
                                    color: Color.fromARGB(224, 65, 65, 65)),
                              ),
                            ],
                          ),
                          Card(
                            elevation:
                                4, // Adjust the elevation value as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'example@ju.edu.jo',
                              ),
                              controller: controller.email,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.endsWith('@ju.edu.jo')) {
                                  return 'Please enter your valid university email.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                " Enter your Password",
                                style: TextStyle(
                                    color: Color.fromARGB(224, 65, 65, 65)),
                              ),
                            ],
                          ),
                          Card(
                            elevation:
                                4, // Adjust the elevation value as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
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
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xFF464A5E)),
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
