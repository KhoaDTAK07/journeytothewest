import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/view/drawer_bar_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_detail_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolDetailPage extends StatelessWidget {
  final ToolDetailViewModel model;

  ToolDetailPage({this.model});

  final toolName = TextEditingController();
  final description = TextEditingController();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ToolDetailViewModel> (
      model: model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Tool Detail",
            textAlign: TextAlign.center,
          ),
        ),
        body: ScopedModelDescendant<ToolDetailViewModel>(
          builder: (context, child, model) {
            if(model.isLoading) {
              return LoadingState();
            } else {
              return Builder(
                builder: (contextBuilder) => Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _toolImageField(),
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

                        _toolNameField(),

                        _toolDescriptionField(),

                        _toolAmountField(),

                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                bool isUpdated = await model.updateTool();
                                if(isUpdated) {
                                  Fluttertoast.showToast(
                                    msg: "Update Actor success",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Update Actor fail",
                                    textColor: Colors.red,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Update Actor",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
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

  Widget _toolNameField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "Tool Name: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.nameFieldController,
            onChanged: (text) {
              model.checkToolName(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
              errorText: model.toolName.error,
            ),
          ),
        ),
      ],
    );
  }

  Widget _toolDescriptionField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "Tool Description: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.descriptionFieldController,
            onChanged: (text) {
              model.checkDescription(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
              errorText: model.toolDescription.error,
            ),
          ),
        ),
      ],
    );
  }

  Widget _toolAmountField() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
          child: Text(
            "Tool Amount: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: model.amountFieldController,
            onChanged: (text) {
              model.checkAmount(text);
            },
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
              errorText: model.toolAmount.error,
            ),
          ),
        ),
      ],
    );
  }

  Widget _toolImageField() {
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
                model.getToolImage();
              },
            ),
          ),
        )
      ],
    );
  }
}