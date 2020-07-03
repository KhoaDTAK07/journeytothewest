import 'package:flutter/material.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/scenario_main_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioMainPage extends StatelessWidget {
  final ScenarioMainViewModel model;

  ScenarioMainPage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScopedModel<ScenarioMainViewModel>(
        model: model,
        child: Scaffold(
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
              "List Of Scenario",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
//                  Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (context) => ActorAddNewView(),
//                    ),
//                  );
                },
                color: Colors.blueAccent,
                child: Text(
                  "Add new",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
          body: BodyView(),
        ),
      ),
    );
  }
}

class BodyView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScenarioMainViewModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return LoadingState();
          } else {
            return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListView.builder(
                itemCount: model.scenarioList.scenarioList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print(model.scenarioList.scenarioList[index].scenarioID);
//                            Navigator.of(context).push(
//                              MaterialPageRoute(
//                                builder: (context) => ActorDetailPage(model: ActorDetailViewModel(model.actorList.actorList[index].username),),
//                              ),
//                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        model.scenarioList.scenarioList[index].scenarioName,
                                        style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Image.asset("location.png",height: 20,),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Location: ",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            model.scenarioList.scenarioList[index].location,
                                            style: TextStyle(fontSize: 18, color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Num of Scene: ",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            model.scenarioList.scenarioList[index].numOfScene.toString(),
                                            style: TextStyle(fontSize: 18, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}

