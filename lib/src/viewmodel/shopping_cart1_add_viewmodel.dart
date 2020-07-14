import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:journeytothewest/src/models/shopping_cart1_add_model.dart';
import 'package:journeytothewest/src/repos/actor_repo.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:journeytothewest/src/repos/shopping_cart1_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart1AddViewModel extends Model {
  ShoppingCartRepo _shoppingCartRepo = ShoppingCartRepoImp();
  ActorRepo _actorRepo = ActorRepoImp();
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();
  AddShoppingCart1Model _addShoppingCart1Model;
  int scenarioID;

  ActorList _actorList;
  ActorList get actorList => _actorList;

  Scenario _scenario;
  Scenario get scenario => _scenario;

  List<String> _actorName = [];
  List<String> get actorName => _actorName;

  String _selectedActor;
  String get selectedActor => _selectedActor;

  String _idActor;
  String _nameActor;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isReady = true;
  bool get isReady => _isReady;

  ShoppingCart1AddViewModel(int scenarioId) {
    getActorList();
    scenarioID = scenarioId;
  }

  void getActorList() async {
    _isLoading = true;
    notifyListeners();

    _actorList = await _actorRepo.getActorList().whenComplete(() {
      _actorList = actorList;
      _isLoading = false;
    });

    for(int i = 0; i < _actorList.actorList.length; i++) {
      _actorName.add(actorList.actorList[i].fullName);
    }

    _scenario = await _scenarioRepo.getScenarioDetailByID(scenarioID);

    if(_scenario != null) {
      _scenario = scenario;
    }
    scenarioNameField.text = _scenario.scenarioName;
    notifyListeners();
  }

  void changeSelectedActor(String newValue) {
    _selectedActor = newValue;
    _nameActor = _actorList.actorList[_actorName.indexOf(newValue)].fullName;
    _idActor = _actorList.actorList[_actorName.indexOf(newValue)].username;
    print(_idActor);
    print(_nameActor);
    notifyListeners();
  }

  TextEditingController scenarioNameField = new TextEditingController();

  Validation _characterName = Validation(null, null);
  Validation get characterName => _characterName;

  void checkCharacterName(String characterName) {
    print(characterName);
    if(characterName == null || characterName.length == 0){
      _characterName = Validation(null, "Character Name can't be blank");
    } else {
      _characterName = Validation(characterName, null);
    }
    notifyListeners();
  }

  Future<bool> addActorToScenario() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String username = sharedPreferences.getString("username");

    _isReady = true;
    if(_characterName.value == null) {
      print(_characterName.value);
      checkCharacterName(null);
      _isReady = false;
    }

    if(_idActor == null) {
      _isReady = false;
    }

    if(_isReady = true) {
      _isLoading = true;
      notifyListeners();

      _addShoppingCart1Model = new AddShoppingCart1Model(
        scenarioID: scenarioID,
        actorID: _idActor,
        characterName: _characterName.value,
        createBy: username,
      );

      String addJson = jsonEncode(_addShoppingCart1Model.toJson());

      return _shoppingCartRepo.addActorToScenario(addJson);
    }
  }
}