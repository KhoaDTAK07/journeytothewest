import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/usermodel/user_schedule_model.dart';
import 'package:http/http.dart' as http;

abstract class UserScheduleRepo {
  Future<UserScheduleList> getScenarioHistory(String username);
  Future<UserScheduleList> getScenarioInProcess(String username);
  Future<UserScheduleList> getScenarioInComing(String username);
}

class UserScheduleRepoImp implements UserScheduleRepo {

  @override
  Future<UserScheduleList> getScenarioHistory(String username) async {
    String apiGetHistory = APIString.apiGetScheduleByUsername();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'username': username,
    };

    var uri = Uri.http(apiGetHistory, "api/ActorScenarioDetail/getHistory", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    UserScheduleList userScheduleList;
    userScheduleList = UserScheduleList.fromJson(list);

    return userScheduleList;
  }

  @override
  Future<UserScheduleList> getScenarioInComing(String username) async {
    String apiGetHistory = APIString.apiGetScheduleByUsername();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'username': username,
    };

    var uri = Uri.http(apiGetHistory, "api/ActorScenarioDetail/getComing", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    UserScheduleList userScheduleList;
    userScheduleList = UserScheduleList.fromJson(list);

    return userScheduleList;
  }

  @override
  Future<UserScheduleList> getScenarioInProcess(String username) async {
    String apiGetHistory = APIString.apiGetScheduleByUsername();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'username': username,
    };

    var uri = Uri.http(apiGetHistory, "api/ActorScenarioDetail/getInProcess", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    UserScheduleList userScheduleList;
    userScheduleList = UserScheduleList.fromJson(list);

    return userScheduleList;
  }

}