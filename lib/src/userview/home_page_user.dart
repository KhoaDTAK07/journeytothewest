import 'package:flutter/material.dart';
import 'package:journeytothewest/src/userview/user_drawer_bar_view.dart';
import 'package:journeytothewest/src/view/drawer_bar_view.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';

class UserHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: new Text(
          "Home Page User",
          textAlign: TextAlign.center,
        ),
      ),
      drawer: UserDrawerBar(model: DrawerViewModel(),),
    );
  }

}