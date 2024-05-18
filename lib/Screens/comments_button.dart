// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CommentsButton extends StatelessWidget {
  void Function()? onTap;
  CommentsButton({
    Key? key,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}
