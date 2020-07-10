import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:http/http.dart' as http;

abstract class ActorRepo {
  Future<ActorList> getActorList ();
  Future<Actor> getActorDetail(String username);
  Future<ActorList> searchActorListByName (String fullName);
  Future<dynamic> deleteActor(String username);
  Future<bool> addNewActor(String addActorJson);
}

class ActorRepoImp implements ActorRepo {

  @override
  Future<ActorList> getActorList() async {
    String apiGetActorList = APIString.apiGetAllActor();
    http.Response response = await http.get(apiGetActorList, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} ,);

    List<dynamic> list = jsonDecode(response.body);

    ActorList actorList;
    actorList = ActorList.fromJson(list);

    return actorList;
  }

  @override
  Future<Actor> getActorDetail(String username) async {
    String apiGetActorDetail = APIString.apiGetActorDetailByUsername()+username;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(apiGetActorDetail, headers: header);

    Actor actor;
    if(response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      actor = Actor.fromJson(map);
      return actor;
    } else {
      return actor;
    }
  }

  @override
  Future<ActorList> searchActorListByName(String fullName) async {
    String apiGetListByName = APIString.apiGetActorByName();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'fullName': fullName,
    };

    var uri = Uri.http(apiGetListByName, "/api/Actor", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ActorList actorList;

    actorList = ActorList.fromJson(list);

    return actorList;
  }

  @override
  Future deleteActor(String username) async {
    String apiDelete = APIString.apiDeleteActor();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'username': username,
    };

    var uri = Uri.http(apiDelete, "/api/Actor", param);
    http.Response response = await http.delete(uri, headers: header);

    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "Fail";
    }
  }

  @override
  Future<bool> addNewActor(String addActorJson) async {
    String apiAddActor = APIString.apiAddActor();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.post(apiAddActor, headers: header, body: addActorJson);

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