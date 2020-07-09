import 'package:journeytothewest/src/models/check_login_model.dart';
import 'package:journeytothewest/src/repos/user_repos.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel2 extends Model{

  CheckLogin _username = CheckLogin(null, null);
  CheckLogin _password = CheckLogin(null, null);

  CheckLogin get username => _username;
  CheckLogin get password => _password;

  void checkUsername(String username) async {
    notifyListeners();
    if(username != null){
      _username = CheckLogin(username, null);
    }
    if(username == null) {
      _username = CheckLogin(null,"Username can't be blank");
    }
    notifyListeners();
  }

  void checkPassword(String password) async {
    notifyListeners();
    if(password == null){
      _password = CheckLogin(null, "Password can't be blank");
    } else if(password.length < 6){
      _password = CheckLogin(null, "Password require minimum 6 characters");
    } else {
      _password = CheckLogin(password, null);
    }
    notifyListeners();
  }

  UserRepo _userRepo = UserRepoImp();

  Future<dynamic> checkLogin() async {
    Map<String,dynamic> map = new Map<String,dynamic>();
    if(_username.value == null){
      map['StatusCode'] = 415;
      return map;
    }
    if(_password.value == null) {
      map['StatusCode'] = 415;
      return map;
    }
    if(_username.value != null && _password.value != null) {
      map = await _userRepo.checkLogin(_username.value.trim(), _password.value.trim());

      if(map.isNotEmpty) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString("username", map['username']);
        sharedPreferences.setString("fullName", map['fullname']);
        sharedPreferences.setString("image", map['image']);
      }

      return map;
    }

  }

}