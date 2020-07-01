import 'dart:async';
import 'dart:convert';

import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/user_model.dart';
import 'package:journeytothewest/src/repos/user_repos.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel{
  final _usernameSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  var usernameValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (username, sink){
      sink.add(Validation.validateUsername(username));
    }
  );

  var passwordValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink){
        sink.add(Validation.validateUsername(password));
      }
  );

  Stream<String> get usernameStream => _usernameSubject.stream.transform(usernameValidation);
  Sink<String> get usernameSink => _usernameSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream.transform(passwordValidation);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  LoginViewModel() {
    Observable.combineLatest2(_usernameSubject, _passwordSubject, (username, password) {
      return Validation.validateUsername(username) == null && Validation.validatePassword(password) == null;
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  UserRepo _userRepo = UserRepoImp();
  Future<dynamic> checkLogin(String username, String password) async {
    print("Username1: " + username);
    print("Password1: " + password);
    Map<String,dynamic> map = await _userRepo.checkLogin(username, password);
    return map;
  }

  dispose() {
    _usernameSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }
}