import 'package:flutter/material.dart';

class email_auth extends StatefulWidget {
  const email_auth({super.key});

  @override
  State<email_auth> createState() => _email_auth();
}

class _email_auth extends State<email_auth> {
  final  _username_controller = TextEditingController();
  final _email_controller = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    //style:InputDecoration(),
                    controller: _email_controller,
                    validator: (value){

                      if(value==null||value.isEmpty)
                      {
                        return 'Enter your Email';
                      }
                      return null;

                    },
                  ),
                  TextFormField(
                 
                    controller: _username_controller,
                    validator: (value){

                      if(value==null||value.isEmpty)
                      {
                        return 'Enter your Usernsame';
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
              , child:  const Text('Sign in with Phone Number'))
          ],

        ),
      ),


    );

  
  }
}