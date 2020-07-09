
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/add_scenario_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioAddViewModel extends Model {
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();
  AddScenarioModel _addScenarioModel;

  File _file;
  File get file => _file;

  String _fileString = "Please select File";
  String get fileString => _fileString;

  bool _isLoading = false;
  bool _isReady = true;

  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  Validation _scenarioName = Validation(null, null);
  Validation _description = Validation(null, null);
  Validation _location = Validation(null, null);
  Validation _startOnDT = Validation(null, null);
  Validation _endOnDT = Validation(null, null);
  Validation _filePath = Validation(null, null);
  Validation _numOfScene = Validation(null, null);

  Validation get scenarioName => _scenarioName;
  Validation get description => _description;
  Validation get location => _location;
  Validation get startOnDT => _startOnDT;
  Validation get endOnDT => _endOnDT;
  Validation get filePath => _filePath;
  Validation get numOfScene => _numOfScene;

  void checkScenarioName(String name) {
    print(name);
    if(name == null || name.length == 0){
      _scenarioName = Validation(null, "Scenario's name can't be blank");
    } else {
      _scenarioName = Validation(name, null);
    }
    notifyListeners();
  }

  void checkScenarioDescription(String description) {
    print(description);
    if(description == null || description.length == 0){
      _description = Validation(null, "Scenario's description can't be blank");
    } else {
      _description = Validation(description, null);
    }
    notifyListeners();
  }

  void checkScenarioLocation(String location) {
    print(location);
    if(location == null || location.length == 0){
      _location = Validation(null, "Scenario's location can't be blank");
    } else {
      _location = Validation(location, null);
    }
    notifyListeners();
  }

  void checkAmount(String scene) {
    var isNum = r'^\d+$';
    RegExp regExp = new RegExp(isNum);
    if(scene == null || scene.length == 0){
      _numOfScene = Validation(null, "Scene can't be blank");
    }
    if(!regExp.hasMatch(scene)){
      _numOfScene = Validation(null, "Scene must be the integer");
    }
    if(int.parse(scene) <= 0){
      _numOfScene = Validation(null, "Scene must be higher than 0");
    } else {
      _numOfScene = Validation(scene, null);
    }
    notifyListeners();
  }

}