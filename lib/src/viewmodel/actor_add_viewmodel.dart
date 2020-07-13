import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/actor_add_model.dart';
import 'package:journeytothewest/src/repos/actor_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;

class ActorAddViewModel extends Model {
  ActorRepo _actorRepo = ActorRepoImp();
  AddActorModel _addActorModel;

  bool _isLoading = false;
  bool _isReady = true;

  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  DateTime _firstDate = DateTime(1950);
  DateTime _lastDate = DateTime.now();

  DateTime get firstDate => _firstDate;
  DateTime get lastDate => _lastDate;

  DateTime _selectedDateOfBirth = DateTime.now();
  DateTime get selectedDateOfBirth => _selectedDateOfBirth;

  String _selectedDateOfBirthFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get selectedDateOfBirthFormat => _selectedDateOfBirthFormat;

  set selectedDateOfBirth(DateTime selectedDateOfBirth) {
    _selectedDateOfBirth = selectedDateOfBirth;
    _selectedDateOfBirthFormat = DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth);
    notifyListeners();
  }

  String _defaultImage = "https://firebasestorage.googleapis.com/v0/b/prm-project-eb33f.appspot.com/o/defaultPerson_image.png?alt=media&token=f7b44339-c5cf-41b1-9790-5b1453bfe021";
  String get defaultImage => _defaultImage;

  File _image;
  File get image => _image;

  Validation _username = Validation(null, null);
  Validation _password = Validation(null, null);
  Validation _fullName = Validation(null, null);
  Validation _sex = Validation(null, null);
  Validation _description = Validation(null, null);
  Validation _phone = Validation(null, null);
  Validation _email = Validation(null, null);

  Validation get username => _username;
  Validation get password => _password;
  Validation get fullName => _fullName;
  Validation get sex => _sex;
  Validation get description => _description;
  Validation get phone => _phone;
  Validation get email => _email;

  void checkUsername(String username) {
    print(username);
    if(username == null || username.length == 0){
      _username = Validation(null, "Username can't be blank");
    } else {
      _username = Validation(username, null);
    }
    notifyListeners();
  }

  void checkPassword(String password) {
    print(password);
    if(password == null || password.length < 6){
      _password = Validation(null, "Password can't be blank and minimum 6 characters");
    } else {
      _password = Validation(password, null);
    }
    notifyListeners();
  }

  void checkFullName(String fullName) {
    print(fullName);
    if(fullName == null || fullName.length == 0){
      _fullName = Validation(null, "Fullname can't be blank");
    } else {
      _fullName = Validation(fullName, null);
    }
    notifyListeners();
  }

  void checkSex(String sex) {
    print(sex);
    if(sex == null || sex.length == 0){
      _sex = Validation(null, "Sex can't be blank");
    }
//    if (sex.compareTo("Male") != 1 || sex.compareTo("Female") != 1) {
//      _sex = Validation(null, "Sex must be Male or Female");
//    }
    else {
      _sex = Validation(sex, null);
    }
    notifyListeners();
  }

  void checkDescription(String description) {
    print(description);
    if(description == null || description.length == 0){
      _description = Validation(null, "Description can't be blank");
    } else {
      _description = Validation(description, null);
    }
    notifyListeners();
  }

  void checkPhone(String phone) {
    print(phone);
    if(phone == null || phone.length == 0){
      _phone = Validation(null, "Phone can't be blank");
    } else {
      _phone = Validation(phone, null);
    }
    notifyListeners();
  }

  void checkEmail(String email) {
    String check = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(check);
    print(email);
    if(email == null || email.length == 0){
      _email = Validation(null, "Email can't be blank");
    } else if (!regExp.hasMatch(email)) {
      _email = Validation(null, "Invalid Email!");
    } else {
      _email = Validation(email, null);
    }
    notifyListeners();
  }

  Future getUserImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    notifyListeners();
  }

  Future<String> upLoadImage() async {
    String basename = path.basename(_image.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  Future<bool> addNewActor() async {
    _isReady = true;
    if(_username.value == null) {
      print(_username.value);
      checkUsername(null);
      _isReady = false;
    }
    if(_password.value == null) {
      print(_password.value);
      checkPassword(null);
      _isReady = false;
    }
    if(_fullName.value == null) {
      print(_fullName.value);
      checkFullName(null);
      _isReady = false;
    }
    if(_sex.value == null) {
      print(_sex.value);
      checkSex(null);
      _isReady = false;
    }
    if(_description.value == null) {
      print(_description.value);
      checkDescription(null);
      _isReady = false;
    }
    if(_phone.value == null) {
      print(_phone.value);
      checkPhone(null);
      _isReady = false;
    }
    if(_email.value == null) {
      print(_email.value);
      checkEmail(null);
      _isReady = false;
    }

    if(_isReady = true) {
      _isLoading = true;
      notifyListeners();

      String currentImage;
      if(_image != null) {
        var url = await upLoadImage();
        currentImage = url.toString();
      } else {
        currentImage = defaultImage;
      }

      _addActorModel = new AddActorModel(
        username: _username.value,
        password: _password.value,
        fullName: _fullName.value,
        sex: _sex.value,
        description: description.value,
        phone: _phone.value,
        email: _email.value,
        image: currentImage,
        dob: _selectedDateOfBirth.toString(),
      );

      String addActorJson = jsonEncode(_addActorModel.toJson());

      return _actorRepo.addNewActor(addActorJson);
    }
  }

}