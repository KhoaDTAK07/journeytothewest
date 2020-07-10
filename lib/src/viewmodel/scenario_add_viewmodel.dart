
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/add_scenario_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;

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
  Validation _numOfScene = Validation(null, null);

  Validation get scenarioName => _scenarioName;
  Validation get description => _description;
  Validation get location => _location;
  Validation get numOfScene => _numOfScene;

  DateTime _firstDate = DateTime(2020);
  DateTime _lastDate = DateTime(2120);

  DateTime get firstDate => _firstDate;
  DateTime get lastDate => _lastDate;

  DateTime _selectedStartDate = DateTime.now();
  DateTime get selectedStartDate => _selectedStartDate;

  DateTime _selectedEndDate = DateTime.now();
  DateTime get selectedEndDate => _selectedEndDate;

  String _selectedStartDateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _selectedEndDateFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get selectedStartDateFormat => _selectedStartDateFormat;
  String get selectedEndDateFormat => _selectedEndDateFormat;


  set selectedDateStart(DateTime selectedDateStart) {
    _selectedStartDate = selectedDateStart;
    _selectedStartDateFormat = DateFormat('yyyy-MM-dd').format(_selectedStartDate);
    notifyListeners();
  }

  set selectedDateEnd(DateTime selectedDateEnd) {
    _selectedEndDate = selectedDateEnd;
    _selectedEndDateFormat = DateFormat('yyyy-MM-dd').format(_selectedEndDate);
    notifyListeners();
  }

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

  Future getFile() async {
    var file = await FilePicker.getFile(allowedExtensions: ['txt', 'doc', 'docx'], type: FileType.custom);
    _file = File(file.path);
    _fileString = path.basename(_file.path);
    notifyListeners();
  }

  Future<String> uploadFile() async {
    String basename = path.basename(_file.path);
    StorageReference storageReference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await storageReference.getDownloadURL();
    print(url);
    return url;
  }

  Future<bool> addScenario() async {
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

    _selectedEndDate.compareTo(_selectedStartDate);
    var compare = _selectedEndDate.compareTo(_selectedStartDate);

    if(compare < 0){
      _selectedEndDate = null;
      _isReady = false;
      notifyListeners();
    }

    if(_isReady == true){
      _isLoading = true;
      notifyListeners();

      String url;
      if(_file != null) {
        var fileUploadScript = await uploadFile();
        url = fileUploadScript;
      } else {
        url = null;
      }

      _addScenarioModel = new AddScenarioModel(
        scenarioName: _scenarioName.value,
        description: _description.value,
        location: _location.value,
        numOfScene: int.parse(_numOfScene.value),
        startOnDT: _selectedStartDate.toString(),
        endOnDT: _selectedEndDate.toString(),
        filePath: url
      );

      String addScenarioJson = jsonEncode(_addScenarioModel.toJson());
      print("-----------");
      print(addScenarioJson);

      return _scenarioRepo.addNewScenario(addScenarioJson);
    }
  }

}