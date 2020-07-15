import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeytothewest/src/adminview/shopping_cart1_add_view.dart';
import 'package:journeytothewest/src/view/loading_state.dart';
import 'package:journeytothewest/src/viewmodel/shopping_cart1_add_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/shopping_cart1_main_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorInScenarioPage extends StatelessWidget {
  final ShoppingCart1MainViewModel model;

  ActorInScenarioPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ShoppingCart1MainViewModel>(
      model: model,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: new Text(
            "List Actor in Scenario",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: <Widget>[
            ScopedModelDescendant<ShoppingCart1MainViewModel>(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddShoppingCart1Page(model: ShoppingCart1AddViewModel(model.shoppingCart1List.list[0].scenarioID),),
              ),
            ).then((value) => model.getActorInScenario(model.shoppingCart1List.list[0].scenarioID));;
          },
          child: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }

  Widget _drawSlidable(BuildContext context, ShoppingCart1MainViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.shoppingCart1List.list.length,
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
      BuildContext context, int index, ShoppingCart1MainViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(150, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Text(
                model.shoppingCart1List.list[index].scenarioName,
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
                model.shoppingCart1List.list[index].fullName,
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
                model.shoppingCart1List.list[index].characterName,
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
