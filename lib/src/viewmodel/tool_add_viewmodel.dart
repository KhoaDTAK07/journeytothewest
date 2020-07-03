import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/add_tool_model.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class ToolAddViewModel extends Model {
  ToolRepo _toolRepo = ToolRepoImp();
  AddToolModel _addToolModel;

  String _defaultImage = "https://firebasestorage.googleapis.com/v0/b/prm-project-eb33f.appspot.com/o/default_image.png?alt=media&token=5a0737d8-a584-4c8a-a183-9ccbcbec868d";
  String get defaultImage => _defaultImage;

  File _image;
  File get image => _image;

  bool _isLoading = false;
  bool _isReady = true;

  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  Validation _toolName;
  Validation _description;
  Validation _amount;

  Validation get toolName => _toolName;
  Validation get description => _description;
  Validation get amount => _amount;


  void checkToolName(String name) {
    if(name == null){
      _toolName = Validation(null, "Tool's name can't be blank");
    } else {
      _toolName = Validation(name, null);
    }
    notifyListeners();
  }

  void checkDescription(String description) {
    if(description == null){
      _description = Validation(null, "Description can't be blank");
    } else {
      _description = Validation(description, null);
    }
    notifyListeners();
  }

  void checkAmount(String amount) {
    var isNum = r'^\d+$';
    RegExp regExp = new RegExp(isNum);
    if(!regExp.hasMatch(isNum)){
      _amount = Validation(null, "Amount must be the integer");
    } else if(int.parse(amount) <= 0) {
      _amount = Validation(null, "Amount must be higher than 0");
    } else if(amount == null){
      _amount = Validation(null, "Amount can't be blank");
    } else {
      _amount = Validation(amount, null);
    }
    notifyListeners();
  }

  Future getUserImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    notifyListeners();
  }

  Future<String> upLoadImage() async {
//    String basename =
  }

  void addNewTool(BuildContext context) async {
    if(_toolName.value == null) {
      checkToolName("");
      _isReady = false;
    }
    if(_description.value == null) {
      checkDescription("");
      _isReady = false;
    }
    if(_amount.value == null) {
      checkAmount("");
      _isReady = false;
    }

    if(_isReady = true) {
      _isLoading = true;

    }
  }
}