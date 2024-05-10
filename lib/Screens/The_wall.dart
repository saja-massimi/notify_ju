import 'package:flutter/material.dart';

class wallpost extends StatelessWidget {
  final String description;
  final String user_email;
  // final String time;
  const wallpost({
    super.key,
    required this.description,
    required this.user_email,
    // required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(user_email),
        Text(description),
      ],
    );
  }
}
