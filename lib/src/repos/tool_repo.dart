import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:http/http.dart' as http;

abstract class ToolRepo {
  Future<ToolList> getToolList();
  Future<Tool> getToolDetailByID(int toolID);
  Future<dynamic> addNewTool(String addToolJson);
}

class ToolRepoImp implements ToolRepo {

  @override
  Future<ToolList> getToolList() async {
    String apiGetToolList = APIString.apiGetAllTool();
    http.Response response = await http.get(apiGetToolList, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} ,);

    List<dynamic> list = jsonDecode(response.body);

    ToolList toolList;
    toolList = ToolList.fromJson(list);

    return toolList;
  }

  @override
  Future<Tool> getToolDetailByID(int toolID) async{
    // TODO: implement getScenarioList
    throw UnimplementedError();
  }

  @override
  Future addNewTool(String addToolJson) async {
    String apiAddTool = APIString.apiAddTool();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.post(apiAddTool, headers: header, body: addToolJson);

    if(response.statusCode == 200) {
      return "Add new Tool success";
    } else {
      return "Add fail";
    }

  }

}