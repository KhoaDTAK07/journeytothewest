import 'dart:convert';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:http/http.dart' as http;

abstract class ActorRepo {
  Future<ActorList> getActorList ();
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

}