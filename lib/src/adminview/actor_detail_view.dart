import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/actor_detail_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorDetailPage extends StatelessWidget {
  final ActorDetailViewModel model;

  ActorDetailPage({this.model});

  final fullname = TextEditingController();
  final sex = TextEditingController();
  final image = TextEditingController();
  final description = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();
  final int isAdmin = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorDetailViewModel> (
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "Actor's Profile",
          ),
        ),
        body: ScopedModelDescendant<ActorDetailViewModel>(
          builder: (context, child, model){
            if(model.isloading){
              return LoadingState();
            } else {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: CircleAvatar(
                          radius: 73.0,
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundImage: NetworkImage(
                                model.actor.image
                            ),
                          ),
                        ),
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
                      _fullname(),
                      _sex(),
                      _description(),
                      _phone(),
                      _email(),
                      _dob(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _fullname() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
              "Fullname",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullname,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.teal)
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sex() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Sex",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullname,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.teal)
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Description",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullname,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.teal)
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _phone() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Phone",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullname,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.teal)
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _email() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Email",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullname,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.teal)
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dob() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "DOB",
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: fullname,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.teal)
              ),
            ),
          ),
        ),
      ],
    );
  }
}
