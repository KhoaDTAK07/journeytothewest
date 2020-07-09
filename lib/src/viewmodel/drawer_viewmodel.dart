import 'package:flutter/material.dart';
import 'package:journeytothewest/src/view/login_page2.dart';
import 'package:journeytothewest/src/viewmodel/login_page_viewmodel2.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerViewModel extends Model {
  String username, fullName, image;

  DrawerViewModel() {
    getUserInfo();
  }

  void getUserInfo() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username");
    fullName = sharedPreferences.getString("fullName");
    image = sharedPreferences.getString("image");
    notifyListeners();
  }

  void signOut(BuildContext context) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        LoginPage2(LoginViewModel2())), (Route<dynamic> route) => false);
//    Navigator.pushReplacement(context,
//        MaterialPageRoute(builder: (context) => LoginPage2(LoginViewModel2())),
//    );
  }
}