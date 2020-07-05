import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journeytothewest/src/helper/api_string.dart';
import 'package:journeytothewest/src/models/user_model.dart';

abstract class UserRepo {
  Future<dynamic> checkLogin(String username, String password);
}

class UserRepoImp implements UserRepo {
  @override
  Future<dynamic> checkLogin(String username, String password) async {
    String api = APIString.apiLogin();
    print("Username2: " + username);
    print("Password2: " + password);
    String _userJsonLogin = jsonEncode(User(username, password).toJson());
    print("Json: " + _userJsonLogin);
    http.Response response = await http.post(api,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: _userJsonLogin);

    if (response.statusCode == 204) {
      Map<String, dynamic> map = new Map<String, dynamic>();
      print("Status code: " + response.statusCode.toString());
      map['StatusCode'] = 204;
      return map;
    } else
      print("Status code: " + response.statusCode.toString());
    Map<String, dynamic> map = jsonDecode(response.body);
    print("Response body" + response.body);
    return map;
  }
}
