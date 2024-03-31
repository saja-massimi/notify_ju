import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
        body: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
          color: const Color(0xFF3A652B),
          borderRadius: BorderRadius.circular(30)
        
        ),
        child: Column(
        children: [
          Opacity(
          opacity: 0.6,
          child: Image.asset(
            'images/uniPic.jpeg',
            fit: BoxFit.cover,
            color: const Color(0xFF96DE7C),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          child: const Column(children: [Text("Welcome User!")],),
        ),
        const SizedBox(height: 15,)

],),

        ),
    );
  }
}