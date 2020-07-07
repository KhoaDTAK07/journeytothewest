import 'package:flutter/material.dart';
import 'package:journeytothewest/src/viewmodel/actor_add_viewmodel.dart';

class ActorAddNewPage extends StatelessWidget {
  final ActorAddViewModel model;

  ActorAddNewPage({this.model});

  final username = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final sex = TextEditingController();
  final image = TextEditingController();
  final description = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {

                  }
              );
            },
          ),
          centerTitle: true,
          title: new Text(
            "Add new Actor",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (context) => ActorAddNewView(),
//                  ),
//                );
              },
              color: Colors.blueAccent,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

