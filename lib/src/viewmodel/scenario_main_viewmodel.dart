import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioMainViewModel extends Model {
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();
  final txtSearch = TextEditingController();

  ScenarioList _scenarioList;
  bool _isLoading = false;
  bool _isNotHave = false;

  ScenarioList get scenarioList => _scenarioList;
  bool get isLoading => _isLoading;
  bool get isHave => _isNotHave;

  ScenarioMainViewModel() {
    getScenarioList();
  }

  void getScenarioList() async {
    _isLoading = true;
    notifyListeners();

    _scenarioList = await _scenarioRepo.getScenarioList().whenComplete(() {
      _scenarioList = scenarioList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteScenario(int scenarioID) async {
    String status = await _scenarioRepo.deleteScenario(scenarioID);
    getScenarioList();
    if(status == "Success") {
      Fluttertoast.showToast(
        msg: "Delete Scenario Success",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Delete Scenario Fail",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void searchScenarioList(String scenarioName) async {
    if(scenarioName == '') {
      getScenarioList();
    } else {
      _isLoading = true;

      if(_scenarioList == null) {
        _scenarioList.scenarioList.clear();
      }
      notifyListeners();

      _scenarioList = await _scenarioRepo.searchScenarioListByName(scenarioName).whenComplete(() {
        _scenarioList = scenarioList;
        _isLoading = false;
      });

      if(scenarioList == null) {
        _isNotHave = true;
      }

      notifyListeners();
    }

  }

}