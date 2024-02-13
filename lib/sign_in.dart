import 'package:flutter/material.dart';
import 'package:notify_ju/email_auth.dart';
import 'package:notify_ju/phone_auth.dart';

class sign_inPage extends StatefulWidget {
  const sign_inPage({super.key});

  @override
  State<sign_inPage> createState() => _sign_inPageState();
}

class _sign_inPageState extends State<sign_inPage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column( 
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
          children:[ 
            const Text('Notify JU',style: TextStyle(decorationThickness: 2.85, color: Colors.black,fontSize: 20),),
            const Image(image: AssetImage('images/uniLogo.png'),width: 150, height: 140,),
             TextButton(onPressed:()
             {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>const phone_auth() ));
             
             }, child: Text('Phone Number'),
             style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade700)),),
             TextButton(onPressed: ()
             {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>const email_auth() ));
             }, child: Text('Email'),
             style: ButtonStyle(  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40,0,40,0)),backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade700)),),


             
            
            ]
        
        ),
      ),


    );
   
  }
}