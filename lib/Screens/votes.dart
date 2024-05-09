import 'package:flutter/material.dart';
import 'package:notify_ju/Widgets/drawer.dart';

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text('Voting'),
          backgroundColor: const Color.fromARGB(255, 195, 235, 197),
          centerTitle: true,
        ));
  }
}
