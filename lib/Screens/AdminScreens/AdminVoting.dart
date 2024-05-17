import 'package:flutter/material.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';

class AdminVoting extends StatefulWidget {
  const AdminVoting({super.key});

  @override
  State<AdminVoting> createState() => _AdminVotingState();
}

class _AdminVotingState extends State<AdminVoting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 234, 238),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Votes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: const Center(
        child: Text("You haven't received any votes yet."),
      ),
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
