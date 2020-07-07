import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeytothewest/src/adminview/tool_add_new_view.dart';
import 'package:journeytothewest/src/adminview/tool_detail_view.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/tool_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_detail_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'not_found_page.dart';

class ToolMainPage extends StatelessWidget {
  final ToolMainViewModel model;

  ToolMainPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ToolMainViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "List Of Tools",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewToolPage(
                      model: ToolAddViewModel(),
                    ),
                  ),
                );
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
              ScopedModelDescendant<ToolMainViewModel>(
                builder: (context, child, model) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: model.txtSearch,
                      onChanged: (value) {
                        model.searchToolList(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Search Tool",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)))),
                    ),
                  );
                },
              ),
              ScopedModelDescendant<ToolMainViewModel>(
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

  Widget _drawSlidable(BuildContext context, ToolMainViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.toolList.toolList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.5,
          child: _getListTool(context, index, model),
          secondaryActions: <Widget>[
            IconSlideAction(
              onTap: () {
                model.deleteTool(model.toolList.toolList[index].toolID);
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

  Widget _getListTool(BuildContext context, int index, ToolMainViewModel model) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(model.toolList.toolList[index].toolID);
            int toolID = model.toolList.toolList[index].toolID;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ToolDetailPage(
                  model: ToolDetailViewModel(toolID),
                ),
              ),
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  radius: 43.0,
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                    NetworkImage(model.toolList.toolList[index].image),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.toolList.toolList[index].toolName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Amount: ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.toolList.toolList[index].amount.toString(),
                          style:
                          TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
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

