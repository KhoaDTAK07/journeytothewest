import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/adminview/tool_main_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/tool_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_main_viewmodel.dart';
import 'package:path/path.dart';
import 'package:scoped_model/scoped_model.dart';

class AddNewToolPage extends StatelessWidget {
  final ToolAddViewModel model;

  AddNewToolPage({Key key, this.model}) : super(key: key);

  final toolName = TextEditingController();
  final description = TextEditingController();
  final amount = TextEditingController();

  String msg;

  Future<dynamic> getMsgAdd(BuildContext context) async {
    String getMsg = await model.addNewTool(context);
    msg = getMsg;
    print(msg);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ToolAddViewModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "Add new Tool",
            textAlign: TextAlign.center,
          ),
        ),
        body: ScopedModelDescendant<ToolAddViewModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return LoadingState();
            } else {
              return Builder(
                builder: (context) =>
                    Container(
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
                                padding: const EdgeInsets.fromLTRB(
                                    30, 30, 30, 0),
                                child: RaisedButton(
                                  onPressed: () {
                                    getMsgAdd(context).whenComplete(() => {
                                      if(msg == "Add new Tool success") {
                                        Fluttertoast.showToast(
                                          msg: "Add new tool success",
                                          textColor: Colors.red,
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.white,
                                          gravity: ToastGravity.CENTER,
                                        ),
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>
                                              ToolMainPage(
                                                model: ToolMainViewModel(),),
                                          ),
                                        )
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Add new tool fail",
                                          textColor: Colors.red,
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.white,
                                          gravity: ToastGravity.CENTER,
                                        )
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Add new Tool",
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
            controller: toolName,
            onChanged: (text) {
              model.checkToolName(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.toolName.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
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
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Description: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: description,
            onChanged: (text) {
              model.checkDescription(text);
            },
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              errorText: model.description.error,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
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
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Text(
            "Amount: ",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            controller: amount,
            onChanged: (text) {
              model.checkAmount(text);
            },
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                errorText: model.amount.error
            ),
            keyboardType: TextInputType.number,
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
                model.getUserImage();
              },
            ),
          ),
        )
      ],
    );
  }

}
