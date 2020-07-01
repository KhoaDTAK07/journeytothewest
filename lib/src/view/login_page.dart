import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/adminview/home_page_admin.dart';
import 'package:journeytothewest/src/viewmodel/login_page_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginViewModel = LoginViewModel();
  
  String username, password;
  int role;
  Map<String,dynamic> map;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Catch username input data
    usernameController.addListener(() {
      // Call usernameSink to add data to Stream
      loginViewModel.usernameSink.add(usernameController.text);
      username = usernameController.text;
    });

    // Catch password input data
    passwordController.addListener(() {
      // Call passwordSink to add data to Stream
      loginViewModel.passwordSink.add(passwordController.text);
      password = passwordController.text;
    });
  }

  Future<dynamic> checkLogin() async {
    map = await LoginViewModel().checkLogin(username.trim(), password.trim());
    if(map.isNotEmpty)
      role = map['isAdmin'];
    else
      role = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("logo.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 160, 30, 0),
            child: Column(
              children: <Widget>[
                StreamBuilder<String>(
                  stream: loginViewModel.usernameStream,
                  builder: (context, snapshot) {
                    return Container(
                      child: TextFormField(
                        controller: usernameController,
                        style: TextStyle(fontSize: 18, color: Colors.black,),
                        decoration: InputDecoration(
                          hintText: "Username *",
                          errorText: snapshot.data,
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      color: Color.fromARGB(250, 193, 212, 241),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<String>(
                  stream: loginViewModel.passwordStream,
                  builder: (context, snapshot) {
                    return Container(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password *",
                          errorText: snapshot.data,
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      color: Color.fromARGB(250, 193, 212, 241),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<bool> (
                  stream: loginViewModel.btnStream,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: RaisedButton(
                        onPressed: snapshot.data == true ? () {
                          checkLogin().whenComplete(() {
                            if(role == 1) {
                              print("---------");
                              print(role);
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePageAdmin(),
                                ),
                              );
                            } else if(role == 2) {

                            } else {

                            }
                          });
                        } : null,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: () {
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277DB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
