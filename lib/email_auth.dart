import 'package:flutter/material.dart';
import 'package:notify_ju/phone_auth.dart';
import 'package:notify_ju/verification.dart';
import 'package:email_auth/email_auth.dart';

class email_auth extends StatefulWidget {

  const email_auth({super.key});

  @override
  State<email_auth> createState() => _email_auth();
}

class _email_auth extends State<email_auth> {
  final  _username_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

void sendOTP() async {

  EmailAuth emailAuth = EmailAuth(sessionName: 'Test Session');

 var res = await emailAuth.sendOtp(recipientMail: _email_controller.text);
 if(res){
    print('OTP sent');
 }
  
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
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

                //Form Feild
                Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Enter your username",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              hintText: 'Username',
                            ),
                            controller: _username_controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your Username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                "Enter your email",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              hintText: 'Email',
                            ),
                            controller: _email_controller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your Email';
                              }
                              return null;
                            },
                          ),

                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const phone_auth()));
                                  },
                                  child: const Text(
                                    'Sign in another way',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 158, 217, 244),
                                        decoration: TextDecoration.underline,
                                        decorationColor:  Color.fromARGB(255, 158, 217, 244)
                                        ),
                                  )),
                            ],
                          ),

                          const SizedBox(height: 10), 
                           Row(
                            children: [
                              ElevatedButton(
                              style:const 
                              ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black) ,
                              foregroundColor: MaterialStatePropertyAll(Colors.white)),
                                  onPressed: () {



                                    if (_formkey.currentState!.validate()) {
                                        Navigator.push(context,MaterialPageRoute(
                                            builder: (context) =>
                                                 verficationCode()));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar( content: Text('Signing in'))                                        
                                          );
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