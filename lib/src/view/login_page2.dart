import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/adminview/home_page_admin.dart';
import 'package:journeytothewest/src/viewmodel/login_page_viewmodel2.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage2 extends StatelessWidget {
  final LoginViewModel2 model;

  LoginPage2(this.model);

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScopedModel<LoginViewModel2>(
        model: model,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("logo.png"), fit: BoxFit.cover),
          ),
          child: ScopedModelDescendant<LoginViewModel2>(
            builder: (context, child, model) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 170,
                  ),
                  _username(),
                  SizedBox(
                    height: 15,
                  ),
                  _password(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: RaisedButton(
                        onPressed: (){
                          login(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    Map<String, dynamic> map = await model.checkLogin();
    if(map['isAdmin'] == 1) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePageAdmin(),
        ),
      );
    } else if(map['isAdmin'] == 0) {

    } else if(map['StatusCode'] == 415) {
      username.text = "";
      password.text = "";
      Fluttertoast.showToast(
        msg: "Username and Password can't be blank",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      username.text = "";
      password.text = "";
      Fluttertoast.showToast(
        msg: "Username or Password incorrect. Please try again",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Widget _username() {
    return Material(
      color: Color.fromARGB(250, 193, 212, 241),
      child: TextField(
        controller: username,
        onChanged: (value) {
          model.checkUsername(value);
        },
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          errorText: model.username.error,
          border: InputBorder.none,
          hintText: "Username *",
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _password() {
    return Material(
      color: Color.fromARGB(250, 193, 212, 241),
      child: TextField(
        controller: password,
        onChanged: (value) {
          model.checkPassword(value);
        },
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        obscureText: true,
        decoration: InputDecoration(
          errorText: model.password.error,
          border: InputBorder.none,
          hintText: "Password *",
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }
}

