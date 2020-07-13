import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:http/http.dart' as http;

abstract class ScenarioRepo {
  Future<ScenarioList> getScenarioList();
  Future<Scenario> getScenarioDetailByID(int scenarioID);
  Future<ScenarioList> searchScenarioListByName(String scenarioName);
  Future<bool> addNewScenario(String addScenarioJson);
  Future<dynamic> deleteScenario(int scenarioID);
  Future<bool> updateScenario(int scenarioID, String updateJson);
}

class ScenarioRepoImp implements ScenarioRepo {

  @override
  Future<ScenarioList> getScenarioList() async {
    String apiGetScenarioList = APIString.apiGetAllScenario();
    http.Response response = await http.get(apiGetScenarioList, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} ,);

    List<dynamic> list = jsonDecode(response.body);

    ScenarioList scenarioList;
    scenarioList = ScenarioList.fromJson(list);

    return scenarioList;
  }

  @override
  Future<bool> addNewScenario(String addScenarioJson) async {
    String apiAddNewScenario = APIString.apiAddScenario();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.post(apiAddNewScenario, headers: header, body: addScenarioJson);

    bool isCreate = true;

    if(response.statusCode == 200) {
      return isCreate;
    } else {
      isCreate = false;
      return isCreate;
    }
  }

  @override
  Future deleteScenario(int scenarioID) async {
    String apiDelete = APIString.apiDeleteScenario();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'scenarioID': scenarioID.toString(),
    };

    var uri = Uri.http(apiDelete, "/api/Scenario", param);
    http.Response response = await http.delete(uri, headers: header);

    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "Fail";
    }
  }

  @override
  Future<Scenario> getScenarioDetailByID(int scenarioID) async {
    String apiGetScenarioDetail = APIString.apiGetScenarioDetail() + scenarioID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(apiGetScenarioDetail, headers: header);

    Scenario scenario;
    if(response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      scenario = Scenario.fromJson(map);
      return scenario;
    } else {
      return scenario;
    }
  }

  @override
  Future<ScenarioList> searchScenarioListByName(String scenarioName) async {
    String apiGetListByName = APIString.apiGetScenarioByName();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'scenarioName': scenarioName,
    };

    var uri = Uri.http(apiGetListByName, "/api/Scenario", param);

    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ScenarioList scenarioList;
    scenarioList = ScenarioList.fromJson(list);

    return scenarioList;
  }

  @override
  Future<bool> updateScenario(int scenarioID, String updateJson) async {
    String apiUpdateScenario = APIString.apiUpdateScenario() + scenarioID.toString();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.put(apiUpdateScenario, headers: header, body: updateJson);

    bool isUpdate = true;

    print("---------");
    print(response.statusCode);

    if(response.statusCode == 200) {
      return isUpdate;
    } else {
      isUpdate = false;
      return isUpdate;
    }

  }

}