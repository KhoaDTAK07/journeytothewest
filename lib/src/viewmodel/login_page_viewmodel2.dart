import 'package:journeytothewest/src/models/check_login_model.dart';
import 'package:journeytothewest/src/repos/user_repos.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginViewModel2 extends Model{

  CheckLogin _username = CheckLogin(null, null);
  CheckLogin _password = CheckLogin(null, null);

  CheckLogin get username => _username;
  CheckLogin get password => _password;

  void checkUsername(String username) async {
    String check = validateUsername(username);
    if(check == null){
      _username = CheckLogin(username, null);
    } else {
      _username = CheckLogin(null,check);
    }
    notifyListeners();
  }

  static String validateUsername(String username) {
    if(username == null){
      return "Username can't be blank";
    } else if (username.length < 6) {
      return "Username require minimum 6 characters";
    } else
      return null;
  }

  void checkPassword(String password) async {
    String check = validateUsername(password);
    if(check == null){
      _password = CheckLogin(password, null);
    } else {
      _password = CheckLogin(null,check);
    }
    notifyListeners();
  }

  static String validatePassword(String password) {
    if(password == null){
      return "Password can't be blank";
    } else if (password.length < 6) {
      return "Password require minimum 6 characters";
    } else
      return null;
  }

  UserRepo _userRepo = UserRepoImp();

  Future<dynamic> checkLogin() async {
    if(_username.value == null || password.value == null){
      Map<String,dynamic> map = new Map<String,dynamic>();
      map['StatusCode'] = 415;
      return map;
    } else {
      Map<String,dynamic> map = await _userRepo.checkLogin(_username.value.trim(), _password.value.trim());
      return map;
    }
  }

}