import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeytothewest/src/adminview/actor_add_new_view.dart';
import 'package:journeytothewest/src/adminview/actor_detail_view.dart';
import 'package:journeytothewest/src/adminview/home_page_admin.dart';
import 'package:journeytothewest/src/view/drawer_bar_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/actor_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/actor_detail_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/actor_main_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'not_found_page.dart';

class ActorMainPage extends StatelessWidget {
  final ActorMainViewModel model;

  ActorMainPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorMainViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "List Of Actor",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () async {
                final isCreate = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActorAddNewPage(
                      model: ActorAddViewModel(),
                    ),
                  ),
                ).then((value) => model.getActorList());
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
              ScopedModelDescendant<ActorMainViewModel>(
                builder: (context, child, model) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: model.txtSearch,
                      onChanged: (value) {
                        model.searchActorList(value);
                      },
                      decoration: InputDecoration(
                          hintText: "Search Actor",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)))),
                    ),
                  );
                },
              ),
              ScopedModelDescendant<ActorMainViewModel>(
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

  Widget _drawSlidable(BuildContext context, ActorMainViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.actorList.actorList.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.5,
          child: _getListActor(context, index, model),
          secondaryActions: <Widget>[
            IconSlideAction(
              onTap: () {
                model.deleteActor(model.actorList.actorList[index].username);
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

  Widget _getListActor(BuildContext context, int index, ActorMainViewModel model) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(model.actorList.actorList[index].username);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ActorDetailPage(model: ActorDetailViewModel(model.actorList.actorList[index].username),),
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
                    backgroundImage: NetworkImage(
                        model.actorList.actorList[index].image
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
                        model.actorList.actorList[index].fullName,
                        style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: <Widget>[
                          if(model.actorList.actorList[index].sex == "Male")
                            Image.asset("male.png",height: 20,)
                          else
                            Image.asset("female.png",height: 20,),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            model.actorList.actorList[index].sex,
                            style: TextStyle(fontSize: 18, color: Colors.black,),
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

class BodyView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActorMainViewModel>(
        builder: (context, child, model) {
      if (model.isLoading) {
        return LoadingState();
      } else {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ListView.builder(
            itemCount: model.actorList.actorList.length,
            itemBuilder: (context, index) {
             return Container(
               child: Column(
                 children: <Widget>[

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

