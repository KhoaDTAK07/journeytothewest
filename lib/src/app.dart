import 'package:flutter/material.dart';
import 'package:journeytothewest/src/adminview/home_page_admin.dart';
import 'package:journeytothewest/src/view/login_page2.dart';
import 'package:journeytothewest/src/viewmodel/login_page_viewmodel2.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage2(LoginViewModel2())
    ); //Material App
  }
}