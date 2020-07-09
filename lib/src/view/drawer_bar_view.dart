
import 'package:flutter/material.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerBar extends StatelessWidget {
  final DrawerViewModel model;

  DrawerBar({this.model});


  @override
  Widget build(BuildContext context) {
    return ScopedModel<DrawerViewModel>(
      model: model,
      child: ScopedModelDescendant<DrawerViewModel>(
        builder: (context, child, model){
          return Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text(model.username),
                  accountName: Text(model.fullName),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.brown,
                    radius: 83.0,
                    child: ClipOval(
                      child: SizedBox(
                        child: Image.network(model.image),
                      ),
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log out'),
                  onTap: () => model.signOut(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}