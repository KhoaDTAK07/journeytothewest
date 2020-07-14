import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/actor_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/actor_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'actor_main_view.dart';

class ActorAddNewPage extends StatelessWidget {
  final ActorAddViewModel model;

  ActorAddNewPage({this.model});

  Future selectDateOfBirth(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: model.firstDate,
        lastDate: model.lastDate);
    if (pickedDate != null) {
      model.selectedDateOfBirth = pickedDate;
    }
  }

  final username = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final sex = TextEditingController();
  final description = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorAddViewModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Add new Tool",
            textAlign: TextAlign.center,
          ),
        ),
        body: ScopedModelDescendant<ActorAddViewModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return LoadingState();
            } else {
              return Builder(
                builder: (contextBuilder) =>
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            _imageField(),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    color: Colors.black12,
                                    width: double.infinity,
                                    height: 2,
                                  ),
                                ),
                              ],
                            ),

                            _usernameField(),

                            _passwordField(),

                            _fullNameField(),

                            _sexField(),

                            _descriptionField(),

                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                              child: Text(
                                "Date of Birth: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            _getDateOfBirthField(context),

                            _phoneField(),

                            _emailField(),

                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 30, 30, 0),
                                child: RaisedButton(
                                  onPressed: () async {
                                    bool isCreate = await model.addNewActor();
                                    print("---------");
                                    print(isCreate);
                                    if (isCreate) {
                                      Fluttertoast.showToast(
                                        msg: "Add new Actor success",
                                        textColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        gravity: ToastGravity.CENTER,
                                      );
                                      Navigator.of(context).pop(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActorMainPage(
                                                model: ActorMainViewModel(),),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Add new Actor fail. Username already exists",
                                        textColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        gravity: ToastGravity.CENTER,
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    "Add new Actor",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "Username: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: username,
            onChanged: (text) {
              model.checkUsername(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.username.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Password: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: password,
            onChanged: (text) {
              model.checkPassword(text);
            },
            obscureText: true,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.password.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fullNameField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Fullname: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullName,
            onChanged: (text) {
              model.checkFullName(text);
            },
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                errorText: model.fullName.error
            ),
          ),
        ),
      ],
    );
  }

  Widget _sexField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Sex: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: sex,
            onChanged: (text) {
              model.checkSex(text);
            },
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                errorText: model.sex.error
            ),
          ),
        ),
      ],
    );
  }

  Widget _descriptionField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Description: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: description,
            onChanged: (text) {
              model.checkDescription(text);
            },
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                errorText: model.description.error
            ),
          ),
        ),
      ],
    );
  }

  Widget _phoneField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Phone: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: phone,
            onChanged: (text) {
              model.checkPhone(text);
            },
            maxLength: 10,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                errorText: model.phone.error
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _emailField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Email: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: email,
            onChanged: (text) {
              model.checkEmail(text);
            },
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                errorText: model.email.error
            ),
          ),
        ),
      ],
    );
  }

  Widget _getDateOfBirthField(BuildContext context) {
    return Container(
      width: 380,
      child: GestureDetector(
        onTap: () {
          selectDateOfBirth(context);
        },
        child: ListTile(
          title: new InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  model.selectedDateOfBirthFormat,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
          child: CircleAvatar(
            radius: 110,
            backgroundColor: Colors.greenAccent,
            child: ClipOval(
              child: SizedBox(
                width: 200,
                height: 200,
                child: (model.image != null)
                    ? Image.file(
                  model.image,
                  fit: BoxFit.fill,
                )
                    : Image.network(
                  model.defaultImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 30,
              ),
              onPressed: () {
                model.getUserImage();
              },
            ),
          ),
        )
      ],
    );
  }

}

