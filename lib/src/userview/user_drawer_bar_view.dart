import 'package:flutter/material.dart';
import 'package:journeytothewest/src/userview/user_schedule_history_view.dart';
import 'package:journeytothewest/src/userview/user_schedule_incoming_view.dart';
import 'package:journeytothewest/src/userview/user_schedule_inprocess_view.dart';
import 'package:journeytothewest/src/userviewmodel/user_schedule_history_viewmodel.dart';
import 'package:journeytothewest/src/userviewmodel/user_schedule_incoming_viewmodel.dart';
import 'package:journeytothewest/src/userviewmodel/user_schedule_inprocess_viewmodel.dart';
import 'package:journeytothewest/src/viewmodel/drawer_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawerBar extends StatelessWidget {

  final DrawerViewModel model;

  UserDrawerBar({this.model});


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
                  leading: Icon(Icons.history),
                  title: Text('History'),
                  onTap: () async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String username = sharedPreferences.getString("username");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserScheduleHistoryPage(model: UserScheduleHistoryViewModel(username),),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_alarm),
                  title: Text('In Process'),
                  onTap: () async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String username = sharedPreferences.getString("username");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserScheduleInProcessPage(model: UserScheduleInProcessViewModel(username),),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.update),
                  title: Text('In Coming'),
                  onTap: () async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String username = sharedPreferences.getString("username");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserScheduleInComingPage(model: UserScheduleInComingViewModel(username),),
                      ),
                    );
                  },
                ),
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