import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:journeytothewest/src/models/actor_update_model.dart';
import 'package:journeytothewest/src/repos/actor_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ActorDetailViewModel extends Model{
  ActorRepo _actorRepo = ActorRepoImp();
  UpdateActorModel _updateActorModel;

  Actor _actor;
  bool _isLoading = false;
  bool _isReady = true;

  Actor get actor => _actor;
  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  String _lastUpdateDay;
  String get lastUpdateDay => _lastUpdateDay;

  ActorDetailViewModel(String username) {
    loadActorDetail(username);
  }

  void loadActorDetail(String username) async {
    _isLoading = true;
    notifyListeners();

    _actor = await _actorRepo.getActorDetail(username);

    if(_actor != null) {
      _actor = actor;
      _isLoading = false;

      fullnameField.text = _actor.fullName;
      sexField.text = _actor.sex;
      descriptionField.text = _actor.description;
      phoneField.text = _actor.phone;
      emailField.text = _actor.email;
      _defaultImage = _actor.image;
      _selectedDateOfBirth = _actor.dob;

      _fullName = Validation(_actor.fullName, null);
      _sex = Validation(_actor.sex, null);
      _description = Validation(_actor.description, null);
      _phone = Validation(_actor.phone, null);
      _email = Validation(_actor.email, null);

      notifyListeners();
    }
  }

  TextEditingController fullnameField = new TextEditingController();
  TextEditingController sexField = new TextEditingController();
  TextEditingController descriptionField = new TextEditingController();
  TextEditingController phoneField = new TextEditingController();
  TextEditingController emailField = new TextEditingController();
  TextEditingController lastUpdateDayField = new TextEditingController();

  String _defaultImage;
  String get defaultImage => _defaultImage;

  File _image;
  File get image => _image;


  DateTime _firstDate = DateTime(1950);
  DateTime _lastDate = DateTime.now();

  DateTime get firstDate => _firstDate;
  DateTime get lastDate => _lastDate;

  DateTime _selectedDateOfBirth;
  DateTime get selectedDateOfBirth => _selectedDateOfBirth;

  String _selectedDateOfBirthFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get selectedDateOfBirthFormat => _selectedDateOfBirthFormat;

  set selectedDateOfBirth(DateTime selectedDateOfBirth) {
    _selectedDateOfBirth = selectedDateOfBirth;
    _selectedDateOfBirthFormat = DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth);
    notifyListeners();
  }

  Validation _fullName = Validation(null, null);
  Validation _sex = Validation(null, null);
  Validation _description = Validation(null, null);
  Validation _phone = Validation(null, null);
  Validation _email = Validation(null, null);

  Validation get fullName => _fullName;
  Validation get sex => _sex;
  Validation get description => _description;
  Validation get phone => _phone;
  Validation get email => _email;


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

  Future<dynamic> updateActor() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String username = sharedPreferences.getString("username");

    _isReady = true;
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

      _updateActorModel = new UpdateActorModel(
        username: _actor.username,
        fullName: _fullName.value,
        sex: _sex.value,
        description: description.value,
        phone: _phone.value,
        email: _email.value,
        image: currentImage,
        dob: _selectedDateOfBirth.toString(),
        updateBy: username,
        updateOnDT: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );

      String addActorJson = jsonEncode(_updateActorModel.toJson());

      return _actorRepo.updateActor(addActorJson);
    }
  }

}