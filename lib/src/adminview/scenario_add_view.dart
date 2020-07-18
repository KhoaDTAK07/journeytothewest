import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/adminview/scenario_main_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/scenario_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/scenario_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddNewScenarioPage extends StatelessWidget {
  final ScenarioAddViewModel model;

  AddNewScenarioPage({this.model});

  Future selectDateStart(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: model.selectedStartDate,
        firstDate: model.firstDate,
        lastDate: model.lastDate);
    if (pickedDate != null) {
      model.selectedDateStart = pickedDate;
    }
  }

  Future selectDateEnd(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: model.selectedEndDate,
        firstDate: model.firstDate,
        lastDate: model.lastDate);
    if (pickedDate != null) {
      model.selectedDateEnd = pickedDate;
    }
  }

  final scenarioName = TextEditingController();
  final scenarioDescription = TextEditingController();
  final scenarioLocation = TextEditingController();
  final numOfScene = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScenarioAddViewModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Add new Scenario",
            textAlign: TextAlign.center,
          ),
        ),
        body: ScopedModelDescendant<ScenarioAddViewModel>(
          builder: (context, child, addModel) {
            if (model.isLoading) {
              return LoadingState();
            } else {
              return Builder(
                builder: (contextBuilder) => Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                          child: Text(
                            "Scenario Name: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _scenarioNameField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                          child: Text(
                            "Description: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _scenarioDescriptionField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                          child: Text(
                            "Location: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _scenarioLocationField(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                          child: Text(
                            "Num of Scene: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _scenarioNumOfScene(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                          child: Text(
                            "Date Start: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _getDateStartField(context),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                          child: Text(
                            "Date End: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _getDateEndField(context),

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                          child: Text(
                            "Upload File: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        _getFileField(context),

                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                30, 30, 30, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                bool isCreate = await model.addScenario();
                                if(isCreate) {
                                  Fluttertoast.showToast(
                                    msg: "Add new Scenario success",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop(
                                    MaterialPageRoute(
                                      builder: (context) => ScenarioMainPage(model: ScenarioMainViewModel(),),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Add new Tool fail",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Add new Scenario",
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

  Widget _scenarioNameField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: scenarioName,
        onChanged: (text) {
          model.checkScenarioName(text);
        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.scenarioName.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _scenarioDescriptionField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: scenarioDescription,
        onChanged: (text) {
          model.checkScenarioDescription(text);
        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.description.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _scenarioLocationField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: scenarioLocation,
        onChanged: (text) {
          model.checkScenarioLocation(text);
        },
        decoration: new InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.location.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _scenarioNumOfScene() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: numOfScene,
        onChanged: (text) {
          model.checkNumOfScene(text);
        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.numOfScene.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _getDateStartField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDateStart(context);
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
                model.selectedStartDateFormat,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDateEndField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDateEnd(context);
      },
      child: ListTile(
        title: new InputDecorator(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal),
            ),
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                model.selectedEndDateFormat,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getFileField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        model.getFile();
      },
      child: ListTile(
        title: new InputDecorator(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_file),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal),
            ),
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                model.fileString,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
