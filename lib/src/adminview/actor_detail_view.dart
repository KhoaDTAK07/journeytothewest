import 'package:flutter/material.dart';

class ActorDetailView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Actor's Profile",
          ),
        ),
//        body: BodyView(),
      ),
    );
  }

}