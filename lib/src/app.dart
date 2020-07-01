import 'package:flutter/material.dart';
import 'package:journeytothewest/src/adminview/home_page_admin.dart';
import 'package:journeytothewest/src/view/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePageAdmin()
    ); //Material App
  }
}