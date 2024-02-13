import 'package:flutter/material.dart';
import 'package:notify_ju/email_auth.dart';

class phone_auth extends StatefulWidget {
  const phone_auth({super.key});

  @override
  State<phone_auth> createState() => _phone_authState();
}

class _phone_authState extends State<phone_auth> {
  
   final _phone_controller = TextEditingController();
   final _username_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor:Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             const Text('Notify JU',style: TextStyle(color: Colors.black,decorationThickness: 2.85),),
             const  Image(image: AssetImage('images/uniLogo.png'),width: 200,height: 190,),
            //Form Feild
              Form(  
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _username_controller,
                    validator: (value){

                      if(value==null||value.isEmpty)
                      {
                        return 'Enter your Username';
                      }
                      return null;

                    },
                  ),
                  TextFormField(
                 
                    controller: _phone_controller,
                    validator: (value){

                      if(value==null||value.isEmpty)
                      {
                        return 'Enter your Phone Number';
                      }
                      return null;
                      
                    },

                  ),
                  ElevatedButton(onPressed: (){
                  if(_formkey.currentState!.validate()){
                    //add the redirection logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data'))
                    );
                  }                    
                  }, child: const Text('Submit'))

                ],
              )
              ),
              TextButton(onPressed:(){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>const email_auth()));
              } 
              , child:  const Text('Sign in with email'))
          ],

        ),
      ),


    );

  
  }
}