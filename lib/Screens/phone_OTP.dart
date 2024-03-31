import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/landingPage.dart';

class phoneOTP extends StatelessWidget {
  const phoneOTP
({super.key});

  @override
  Widget build(BuildContext context) {

    final _codeController = TextEditingController();
    
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
                    padding:const EdgeInsets.all(20.0),
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
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>const LandingPage(),
                                      ),
                                    ),
                                  },
                                    
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