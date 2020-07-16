
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:journeytothewest/src/models/shopping_cart2_add_model.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:journeytothewest/src/repos/shopping_cart2_repo.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart2AddViewModel extends Model {
  ShoppingCart2Repo _shoppingCartRepo = ShoppingCart2RepoImp();
  ToolRepo _toolRepo = ToolRepoImp();
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();
  AddShoppingCart2Model _addShoppingCart2Model;
  int scenarioID;

  ToolList _toolList;
  ToolList get toolList => _toolList;

  Scenario _scenario;
  Scenario get scenario => _scenario;

  List<String> _toolName = [];
  List<String> get toolName => _toolName;

  String _selectedTool;
  String get selectedTool => _selectedTool;

  String _idTool;
  String _nameTool;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isReady = true;
  bool get isReady => _isReady;

  ShoppingCart2AddViewModel(int scenarioId) {
    getToolList();
    scenarioID = scenarioId;
  }

  void getToolList() async {
    _isLoading = true;
    notifyListeners();

    _toolList = await _toolRepo.getToolList().whenComplete(() {
      _toolList = toolList;
      _isLoading = false;
    });

    for(int i = 0; i < _toolList.toolList.length; i++) {
      _toolName.add(toolList.toolList[i].toolName);
    }

    _scenario = await _scenarioRepo.getScenarioDetailByID(scenarioID);

    if(_scenario != null) {
      _scenario = scenario;
    }
    scenarioNameField.text = _scenario.scenarioName;
    notifyListeners();
  }

  void changeSelectedTool(String newValue) {
    _selectedTool = newValue;
    _nameTool = _toolList.toolList[_toolName.indexOf(newValue)].toolName;
    _idTool = _toolList.toolList[_toolName.indexOf(newValue)].toolID.toString();
    print(_idTool);
    print(_nameTool);
    notifyListeners();
  }

  TextEditingController scenarioNameField = new TextEditingController();

  Validation _amount = Validation(null, null);
  Validation get amount => _amount;

  void checkAmount(int amount) {
    if(amount == null || amount == 0){
      _amount = Validation(null, "Amount can't be blank or equal 0");
    } else {
      _amount = Validation(amount.toString(), null);
    }
    notifyListeners();
  }

  Future<bool> addActorToScenario() async {
    _isReady = true;

    if(_amount.value == 0) {
      print(_amount.value);
      checkAmount(null);
      _isReady = false;
    }

    if(_idTool == null) {
      _isReady = false;
    }

    if(_isReady = true) {
      _isLoading = true;
      notifyListeners();

      _addShoppingCart2Model = new AddShoppingCart2Model(
        scenarioID: scenarioID,
        toolID: int.parse(_idTool),
        amount: int.parse(_amount.value),
        CreateOnDt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        status: 1,
      );

      String addJson = jsonEncode(_addShoppingCart2Model.toJson());

      return _shoppingCartRepo.addToolToScenario(addJson);
    }
  }
}