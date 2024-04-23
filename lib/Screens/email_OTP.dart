import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/mail_authenticationController.dart';

class email_otp extends StatefulWidget {
  const email_otp({super.key});

  @override
  State<email_otp> createState() => _email_otpState();
}

class _email_otpState extends State<email_otp> {

    final controller = Get.put(MailAuthenticationController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: const Color(0xFF96DE7C),

      body: Stack(fit: StackFit.expand, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  const Icon(
                      Icons.email_outlined,
                      size: 100,
                    ),
                
                  const SizedBox(height: 20,),
                  const  Text('Verify your email address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            )
                            ),
                      const  SizedBox(height: 20,),
                      const Text('We have just sent an email verification link to \n your email address. Please click on the link to\n verify your email address.',
                      textAlign:TextAlign.center ,
                      style: TextStyle(color: Colors.white),),
                      const SizedBox(height: 25,),
                      const  Text('If you have not received the email, please check\n your spam folder or click on the button below to\n resend the email.',
                      textAlign:TextAlign.center ,
                      style: TextStyle(color: Colors.white),),
                      const  SizedBox(height: 25,),
                      
                        ElevatedButton(
                          onPressed: ()=>controller.sendVerficationEmail(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(
                            fontSize: 20,
                            )
                          ),
                          child: const Text('Resend Email'),
                        ),

      ],
          )



      
    
] ));




  }
}