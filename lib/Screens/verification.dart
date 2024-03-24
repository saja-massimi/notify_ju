// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class verficationCode extends StatefulWidget {
  final  userEmail ;

   verficationCode({super.key, this.userEmail });

  @override
  State<verficationCode> createState() => _verficationCodeState();
}




class _verficationCodeState extends State<verficationCode> {
  late EmailAuth email_Auth;


  final _codeController = TextEditingController();





void validateOTP()  {

  EmailAuth emailAuth = EmailAuth(sessionName: 'Test Session');

  var res =  emailAuth.validateOtp(userOtp: _codeController.text, recipientMail: widget.userEmail);
  if(res){
  
    log('OTP verified');
    
    }
}




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            fontWeight: FontWeight.bold)
                            ),
                  ],
                ),

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                    
                      const  Row(
                          children: [
                            Text("Enter the Verification Code",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20)),
                          ],
                        ),

                                const   TextField(
                               decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                                hintText: 'Code',
                              ),
                            ),
                            
                       const   Row(
                            children: [
                              TextButton(
                                  onPressed:null,
        
                                  child: Text(
                                    'Resend Code',
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
                              style:const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black) ,foregroundColor: MaterialStatePropertyAll(Colors.white)),
                                  onPressed: () => validateOTP,
                                    
                                  child: const Text('Submit')),
                            ],
                          )
                      ],
                    ),
                  )
            
            
              ],
            ),
          ),
        ),
      ]),
    );
  }
}