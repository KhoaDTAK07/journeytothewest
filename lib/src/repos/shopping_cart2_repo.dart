import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/shopping_cart2_model.dart';
import 'package:http/http.dart' as http;

abstract class ShoppingCart2Repo {
  Future<ShoppingCart2List> getAll(int scenarioID);

  Future<bool> addToolToScenario(String addJson);
}

class ShoppingCart2RepoImp implements ShoppingCart2Repo {
  @override
  Future<ShoppingCart2List> getAll(int scenarioID) async {
    String apiGetAll = APIString.apiGetAllShoppingCart2ByScenarioID();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'scenarioID': scenarioID.toString(),
    };

    var uri = Uri.http(apiGetAll, "api/ToolScenarioDetail/getall", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ShoppingCart2List shoppingCart2List;
    shoppingCart2List = ShoppingCart2List.fromJson(list);

    return shoppingCart2List;
  }

  @override
  Future<bool> addToolToScenario(String addJson) async{
    String apiAddActorToScenario = APIString.apiAddToolToScenario();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.post(apiAddActorToScenario, headers: header, body: addJson);

    bool isCreate = true;

    print("Status code: " +response.statusCode.toString());

    if(response.statusCode == 204) {
      return isCreate;
    } else {
      isCreate = false;
      return isCreate;
    }
  }

}