import 'package:flutter/material.dart';

class AddNewScenarioPage extends StatelessWidget {

  Future selectDateStart(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030)
    );
//    if(pickedDate != null) setState(() => dayStart = pickedDate.toString());
  }

  final dayStart = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: new Text(
          "Add new Scenario",
          textAlign: TextAlign.center,
        ),
      ),
      body: Builder(
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
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  _scenarioNameField(),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Text(
                      "Description: ",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  _scenarioDescriptionField(),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Text(
                      "Location: ",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  _scenarioLocationField(),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Text(
                      "Num of Scene: ",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  _scenarioNumOfScene(),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Text(
                      "Date Start: ",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  _getDateStartField(context),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    child: Text(
                      "Date End: ",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  _getDateEndField(context),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                    child: Text(
                      "Upload File: ",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }

  Widget _scenarioNameField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
//        controller: description,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
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
//        controller: description,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
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
//        controller: description,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        decoration: new InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
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
//        controller: description,
//        onChanged: (text) {
//          model.checkDescription(text);
//        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//          errorText: model.description.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _getDateStartField(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                    "abc"
                  ),
                ],
              ),
          )),
    );
  }

  Widget _getDateEndField(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                    "abc"
                ),
              ],
            ),
          )),
    );
  }
}

