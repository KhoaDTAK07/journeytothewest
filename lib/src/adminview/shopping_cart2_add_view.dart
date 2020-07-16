import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/shopping_cart2_add_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddShoppingCart2Page extends StatelessWidget {
  final ShoppingCart2AddViewModel model;

  AddShoppingCart2Page({this.model});

  final scenarioName = TextEditingController();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ShoppingCart2AddViewModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Shopping Cart 2",
            textAlign: TextAlign.center,
          ),
        ),
        body: ScopedModelDescendant<ShoppingCart2AddViewModel>(
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
                              padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                              child: Text(
                                "Tool: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            _actorListField(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
                              child: Text(
                                "Amount: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            _amountField(),
                            SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 30, 30, 0),
                                child: RaisedButton(
                                  onPressed: () async {
                                    bool isCreate = await model
                                        .addActorToScenario();
                                    if (isCreate) {
                                      Fluttertoast.showToast(
                                        msg: "Add Tool to Scenario success",
                                        textColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        gravity: ToastGravity.CENTER,
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Add Tool to Scenario fail",
                                        textColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.white,
                                        gravity: ToastGravity.CENTER,
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    "Add Actor To Scenario",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
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
        controller: model.scenarioNameField,
        readOnly: true,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  Widget _actorListField() {
    return Container(
        height: 50,
        width: 375,
        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
        decoration: new BoxDecoration(
          border: Border.all(
            color: Colors.teal,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: <Widget>[
            DropdownButton<String>(
              items: model.toolName.map((String dropdownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropdownStringItem,
                  child: Text(dropdownStringItem),
                );
              }).toList(),
              onChanged: (selectedValue) {
                model.changeSelectedTool(selectedValue);
              },
              value: model.selectedTool,
              hint: Text(
                'Choose Tool',
                style: TextStyle(fontSize: 18),
              ),
              iconSize: 28,
              elevation: 16,
            ),
          ],
        ));
  }

  Widget _amountField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
      child: TextField(
        controller: amount,
        keyboardType: TextInputType.number,
        onChanged: (text) {
          model.checkAmount(int.parse(text));
        },
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          errorText: model.amount.error,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }
}