import 'dart:convert';
import 'dart:io';

import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:http/http.dart' as http;

abstract class ToolRepo {
  Future<ToolList> getToolList();
  Future<Tool> getToolDetailByID(int toolID);
  Future<dynamic> addNewTool(String addToolJson);
  Future<dynamic> deleteTool(int toolID);
  Future<ToolList> searchToolListByName(String toolName);
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
    String apiGetToolDetail = APIString.apiGetToolDetail() + toolID.toString();
    print(apiGetToolDetail);
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(apiGetToolDetail, headers: header);
    print(response.body);
    print(response.statusCode);
    Tool tool;

    if(response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      tool = Tool.fromJson(map);
      return tool;
    } else {
      return tool;
    }

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

  @override
  Future deleteTool(int toolID) async {
    String apiDelete = APIString.apiDeleteTool();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'toolID': toolID.toString(),
    };

    var uri = Uri.http(apiDelete, "/api/Tools", param);
    http.Response response = await http.delete(uri, headers: header);

    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "Fail";
    }

  }

  @override
  Future<ToolList> searchToolListByName(String toolName) async {
    String apiGetListByName = APIString.apiGetToolByName();

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Map<String, String> param = {
      'toolName': toolName,
    };

    var uri = Uri.http(apiGetListByName, "/api/Tools", param);
    http.Response response = await http.get(uri, headers: header);

    List<dynamic> list = jsonDecode(response.body);

    ToolList toolList;
    toolList = ToolList.fromJson(list);

    return toolList;
  }

}