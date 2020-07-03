import 'package:flutter/material.dart';
import 'package:journeytothewest/src/adminview/tool_add_new_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/tool_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/tool_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolMainPage extends StatelessWidget {
  final ToolMainViewModel model;

  ToolMainPage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScopedModel<ToolMainViewModel>(
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
              "List Of Tools",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewToolPage(model: ToolAddViewModel(),),
                    ),
                  );
                },
                color: Colors.blueAccent,
                child: Text(
                  "Add New",
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
    return ScopedModelDescendant<ToolMainViewModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return LoadingState();
          } else {
            return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListView.builder(
                itemCount: model.toolList.toolList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print(model.toolList.toolList[index].toolID);
//                            Navigator.of(context).push(
//                              MaterialPageRoute(
//                                builder: (context) => ActorDetailPage(model: ActorDetailViewModel(model.actorList.actorList[index].username),),
//                              ),
//                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 43.0,
                                  child: CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(
                                        model.toolList.toolList[index].image
                                    ),
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
                                        style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Amount: ",
                                            style: TextStyle(fontSize: 18, color: Colors.black,),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            model.toolList.toolList[index].amount.toString(),
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