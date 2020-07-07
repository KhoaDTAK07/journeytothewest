import 'package:flutter/material.dart';

class NotFoundState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Cannot found!",
        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

}