// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Likes extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  Likes({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.keyboard_double_arrow_up : Icons.arrow_upward,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}
