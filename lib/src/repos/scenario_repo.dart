import 'dart:convert';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:http/http.dart' as http;

abstract class ScenarioRepo {
  Future<ScenarioList> getScenarioList();
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

}