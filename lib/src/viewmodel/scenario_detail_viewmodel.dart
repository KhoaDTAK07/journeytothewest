import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:journeytothewest/src/models/update_scenario_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;

class ScenarioDetailViewModel extends Model{
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();
  UpdateScenarioModel _updateScenarioModel;
  int scenarioId;

  Scenario _scenario;
  Scenario get scenario => _scenario;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isReady = true;
  bool get isReady => _isReady;

  DateTime _firstDate = DateTime(2020);
  DateTime _lastDate = DateTime(2120);

  DateTime get firstDate => _firstDate;
  DateTime get lastDate => _lastDate;

  DateTime _dateStart;
  DateTime _dateEnd;

  DateTime get dateStart => _dateStart;
  DateTime get dateEnd => _dateEnd;

  String _selectedDateStartFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get selectedDateStartFormat => _selectedDateStartFormat;

  String _selectedDateEndFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get selectedDateEndFormat => _selectedDateEndFormat;

  set selectedDateStart(DateTime selectedDateStart) {
    _dateStart = selectedDateStart;
    _selectedDateStartFormat = DateFormat('yyyy-MM-dd').format(_dateStart);
    notifyListeners();
  }

  set selectedDateEnd(DateTime selectedDateEnd) {
    _dateEnd = selectedDateEnd;
    _selectedDateEndFormat = DateFormat('yyyy-MM-dd').format(_dateEnd);
    notifyListeners();
  }

  TextEditingController scenarioNameField = new TextEditingController();
  TextEditingController descriptionField = new TextEditingController();
  TextEditingController locationField = new TextEditingController();
  TextEditingController numOfSceneField = new TextEditingController();

  Validation _scenarioName = Validation(null, null);
  Validation _description = Validation(null, null);
  Validation _location = Validation(null, null);
  Validation _numOfScene = Validation(null, null);

  Validation get scenarioName => _scenarioName;
  Validation get description => _description;
  Validation get location => _location;
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

  void checkNumOfScene(String scene) {
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

  File _file;
  String _fileString;
  String _isHaveFile = "Don't have any File!";

  File get file => _file;
  String get fileString => _fileString;
  String get isHaveFile => _isHaveFile;

  Future getFile() async {
    var file = await FilePicker.getFile(allowedExtensions: ['txt', 'doc', 'docx'], type: FileType.custom);
    _file = File(file.path);
    _isHaveFile = path.basename(_file.path);
    notifyListeners();
  }

  Future<String> upLoadFile() async {
    String basename = path.basename(_file.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = reference.putFile(_file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  ScenarioDetailViewModel(int scenarioID) {
    loadScenarioDetail(scenarioID);
    scenarioId = scenarioID;
  }

  void loadScenarioDetail(int scenarioID) async {
    _isLoading = true;
    notifyListeners();

    _scenario = await _scenarioRepo.getScenarioDetailByID(scenarioID);

    if(_scenario != null) {
      _scenario = scenario;
      _isLoading = false;

      scenarioNameField.text = _scenario.scenarioName;
      descriptionField.text = _scenario.description;
      locationField.text = _scenario.location;
      numOfSceneField.text = _scenario.numOfScene.toString();
      _dateStart = _scenario.startOnDT;
      _dateEnd = _scenario.endOnDT;
      _fileString = _scenario.fileDescriptionPath;

      _scenarioName = Validation(_scenario.scenarioName, null);
      _description = Validation(_scenario.description, null);
      _location = Validation(_scenario.location, null);
      _numOfScene = Validation(_scenario.numOfScene.toString(), null);

      if(_fileString != null) {
        _isHaveFile = "Click here to choose another file";
      }

      notifyListeners();
    }

  }

  Future<dynamic> updateScenario() async {
    _isReady = true;

    if(_scenarioName.value == null) {
      print(_scenarioName.value);
      checkScenarioName(null);
      _isReady = false;
    }
    if(_description.value == null) {
      checkScenarioDescription(null);
      _isReady = false;
    }
    if(_location.value == null) {
      checkScenarioLocation(null);
      _isReady = false;
    }
    if(_numOfScene.value == null) {
      checkNumOfScene(null);
      _isReady = false;
    }

    _dateEnd.compareTo(_dateStart);
    var compare = _dateEnd.compareTo(_dateStart);
    print("Compare: ");
    print(compare);

    if(compare < 0){
      _dateEnd = DateTime.now();
      _isReady = false;
      Fluttertoast.showToast(
        msg: "The end date cannot be earlier than the start date",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      notifyListeners();
    }

    if(_isReady == true) {
      _isLoading = true;
      notifyListeners();

      String url;
      if(_file != null) {
        var fileUploadScript = await upLoadFile();
        url = fileUploadScript;
      } else {
        url = _fileString;
      }

      _updateScenarioModel = new UpdateScenarioModel(
        scenarioID: scenarioId,
        scenarioName: _scenarioName.value,
        description: _description.value,
        location: _location.value,
        numOfScene: int.parse(_numOfScene.value),
        startOnDT: _dateStart.toString(),
        endOnDT: _dateEnd.toString(),
        filePath: url,
        status: 1,
      );

      String updateJson = jsonEncode(_updateScenarioModel.toJson());

      return _scenarioRepo.updateScenario(scenarioId, updateJson);

    }
  }

}