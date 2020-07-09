
import 'package:flutter/material.dart';
import 'package:journeytothewest/src/adminview/actor_main_view.dart';
import 'package:journeytothewest/src/adminview/scenario_main_view.dart';
import 'package:journeytothewest/src/adminview/tool_main_view.dart';
import 'package:journeytothewest/src/view/drawer_bar_view.dart';
import 'package:journeytothewest/src/viewmodel/actor_main_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/scenario_main_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_main_viewmodel.dart';

class HomePageAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Journey to the West App",
          ),
        ),
        drawer: DrawerBar(model: DrawerViewModel(),),
        body: BodyView(),
      ),
    );
  }

}

class BodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScenarioMainPage(model: ScenarioMainViewModel(),),
                ),
              );
            },
            child: Card(
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/prm-project-eb33f.appspot.com/o/scenario.png?alt=media&token=b59ca46f-3578-4430-8253-87e1075c2883',
                  height: 100,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Scenarios",
                    style: TextStyle(fontSize: 50,),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ToolMainPage(model: ToolMainViewModel(),),
                ),
              );
            },
            child: Card(
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/prm-project-eb33f.appspot.com/o/tool.png?alt=media&token=5de25e3f-d7c2-4f1c-91f5-c2f7636ff28c',
                    height: 100,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Tools",
                    style: TextStyle(fontSize: 50,),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ActorMainPage(model: ActorMainViewModel(),),
                ),
              );
            },
            child: Card(
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/prm-project-eb33f.appspot.com/o/actor.png?alt=media&token=b2712a7d-ab88-492f-9979-8cdb402ea5dd',
                    height: 100,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Actors",
                    style: TextStyle(fontSize: 50,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}