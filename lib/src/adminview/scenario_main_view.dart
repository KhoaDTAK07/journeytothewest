import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeytothewest/src/adminview/scenario_add_view.dart';
import 'package:journeytothewest/src/view/drawer_bar_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/scenario_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/scenario_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'not_found_page.dart';

class ScenarioMainPage extends StatelessWidget {
  final ScenarioMainViewModel model;

  ScenarioMainPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScenarioMainViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "List Of Scenario",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () async {
                final isCreate = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewScenarioPage(
                      model: ScenarioAddViewModel(),
                    ),
                  ),
                ).then((value) => model.getScenarioList());
              },
              color: Colors.blueAccent,
              child: Text(
                "Add new",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<ScenarioMainViewModel>(
                builder: (context, child, model) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: model.txtSearch,
                      onChanged: (value) {
                        model.searchScenarioList(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Search Scenario",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)))),
                    ),
                  );
                },
              ),
              ScopedModelDescendant<ScenarioMainViewModel>(
                builder: (context, child, model) {
                  if (model.isLoading) {
                    return LoadingState();
                  } else if (model.isLoading && model.isHave) {
                    return NotFoundState();
                  } else {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: _drawSlidable(context, model),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawSlidable(BuildContext context, ScenarioMainViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.scenarioList.scenarioList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.5,
          child: _getListScenario(context, index, model),
          secondaryActions: <Widget>[
            IconSlideAction(
              onTap: () {
                model.deleteScenario(model.scenarioList.scenarioList[index].scenarioID);
              },
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
            )
          ],
        );
      },
    );
  }

  Widget _getListScenario(BuildContext context, int index, ScenarioMainViewModel model) {
    return Column(
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
    );
  }

}


