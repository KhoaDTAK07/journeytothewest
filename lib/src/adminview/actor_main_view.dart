import 'package:flutter/material.dart';
import 'package:journeytothewest/src/adminview/home_page_admin.dart';
import 'package:journeytothewest/src/viewmodel/actor_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorMainPage extends StatelessWidget {
  final ActorMainViewModel model;

  ActorMainPage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScopedModel<ActorMainViewModel>(
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
              "List Of Actor",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {},
                color: Colors.blueAccent,
                child: Text(
                  "Add new",
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
                   Row(
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

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
