import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:http/http.dart' as http;
import 'package:journeytothewest/src/models/shopping_cart1_model.dart';

abstract class ShoppingCart1Repo {
  Future<ShoppingCart1List> getAll(int scenarioID);
  Future<bool> addActorToScenario(String addJson);
  Future<dynamic> deleteActorFromScenario(int AsdID);
}

class ShoppingCartRepoImp implements ShoppingCart1Repo {

  @override
  Future<bool> addActorToScenario(String addJson) async {
    String apiAddActorToScenario = APIString.apiAddActorToCart();

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

  @override
  Future<ShoppingCart1List> getAll(int scenarioID) async {
    String apiGetAll = APIString.apiGetAllShoppingCart1ByScenarioID();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'scenarioID': scenarioID.toString(),
    };

    var uri = Uri.http(apiGetAll, "api/ActorScenarioDetail/getall", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ShoppingCart1List shoppingCart1List;
    shoppingCart1List = ShoppingCart1List.fromJson(list);

    return shoppingCart1List;
  }

  @override
  Future deleteActorFromScenario(int AsdID) async {
    String apiDelete = APIString.apiDeleteActorFromCart();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'AsdID': AsdID.toString(),
    };

    var uri = Uri.http(apiDelete, "/api/ActorScenarioDetail", param);

    http.Response response = await http.delete(uri, headers: header);

    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "Fail";
    }
  }

}