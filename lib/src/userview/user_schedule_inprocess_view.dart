import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/userviewmodel/user_schedule_inprocess_viewmodel.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:scoped_model/scoped_model.dart';

class UserScheduleInProcessPage extends StatelessWidget {
  final UserScheduleInProcessViewModel model;

  UserScheduleInProcessPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserScheduleInProcessViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Scenario In Process",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: <Widget>[
            ScopedModelDescendant<UserScheduleInProcessViewModel>(
              builder: (context, child, model) {
                if (model.isLoading) {
                  return LoadingState();
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
    );
  }

  Widget _drawSlidable(BuildContext context, UserScheduleInProcessViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.userScheduleList.userScheduleList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.5,
          child: _getListScenario(context, index, model),
        );
      },
    );
  }

  Widget _getListScenario(
      BuildContext context, int index, UserScheduleInProcessViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(150, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Text(
                model.userScheduleList.userScheduleList[index].scenarioName,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Row(
            children: <Widget>[
              Text(
                "Actor: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                model.userScheduleList.userScheduleList[index].fullName,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Row(
            children: <Widget>[
              Text(
                "Character Name: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                model.userScheduleList.userScheduleList[index].characterName,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Row(
            children: <Widget>[
              Text(
                "Time: ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(DateTime.parse(model.userScheduleList.userScheduleList[index].startOnDT)),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "-",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(DateTime.parse(model.userScheduleList.userScheduleList[index].endOnDT)),
                style: TextStyle(fontSize: 18, color: Colors.black),
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