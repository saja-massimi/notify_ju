import 'package:flutter/material.dart';

class verficationCode extends StatefulWidget {
  const verficationCode({super.key});

  @override
  State<verficationCode> createState() => _verficationCodeState();
}

class _verficationCodeState extends State<verficationCode> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Column(
        children: [
          Row(
          children:[  Image(image: AssetImage('images/uniLogo.png'),width: 150, height: 140,),
          ]
          )

        ],

      ),


    );
  }
}