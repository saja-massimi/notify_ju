import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/email_OTP.dart';
import 'package:notify_ju/Screens/phone_OTP.dart';

//changed it to choose otp send method
// the user could choose sending an email
// or a phomne number to +962 XXXXX last two digits
class sign_inPage extends StatefulWidget {
  const sign_inPage({super.key});

  @override
  State<sign_inPage> createState() => _sign_inPageState();
}


class _sign_inPageState extends State<sign_inPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(  
            opacity: 0.6,
            child: Image.asset(
              'images/uniPic.jpeg',
              fit: BoxFit.cover,
              color:const Color(0xFF96DE7C), 
              colorBlendMode: BlendMode.modulate,
            
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: Container(
              decoration: BoxDecoration(
                color:const Color(0xFF3A652B).withOpacity(0.4), 
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const Text('Notify JU',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Image(
                        image: AssetImage('images/uniLogo.png'),
                        width: 150,
                        height: 140,
                      ),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Send Code Via",
                            style: TextStyle(
                                decorationThickness: 50,
                                color: Colors.white,
                                fontSize: 20)),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const phoneOTP()));
                        },
                        
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                          const EdgeInsets.all(25)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Phone Number',style: TextStyle(fontWeight: FontWeight.w700),),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EmailOTP()));
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(47,25,47,25)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Email',style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}