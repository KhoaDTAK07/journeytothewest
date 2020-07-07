import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:journeytothewest/src/repos/actor_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorMainViewModel extends Model {
  ActorRepo _actorRepo = ActorRepoImp();
  final txtSearch = TextEditingController();

  ActorList _actorList;
  bool _isLoading = false;
  bool _isNotHave = false;

  ActorList get actorList => _actorList;
  bool get isLoading => _isLoading;
  bool get isHave => _isNotHave;

  ActorMainViewModel() {
    getActorList();
  }

  void getActorList() async {
    _isLoading = true;
    notifyListeners();

    _actorList = await _actorRepo.getActorList().whenComplete(() {
      _actorList = actorList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteActor(String username) async {
    String status = await _actorRepo.deleteActor(username);
    print(status);
    getActorList();
    if(status == "Success") {
      Fluttertoast.showToast(
        msg: "Delete Actor Success",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Delete Actor Fail",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void searchActorList(String fullName) async {
    if(fullName == '') {
      getActorList();
    } else {
      _isLoading = true;

      if(_actorList != null) {
        _actorList.actorList.clear();
      }

      notifyListeners();

      _actorList = await _actorRepo.searchActorListByName(fullName).whenComplete(() {
        _actorList = actorList;
        _isLoading = false;
      });

      if(actorList == null) {
        _isNotHave = true;
      }

      notifyListeners();
    }
  }

}