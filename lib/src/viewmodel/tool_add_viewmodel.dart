import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeytothewest/src/adminview/tool_main_view.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/add_tool_model.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:journeytothewest/src/viewmodel/tool_main_viewmodel.dart';
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

  Validation _toolName = Validation(null, null);
  Validation _description = Validation(null, null);
  Validation _amount = Validation(null, null);

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
    if(amount == null){
      _amount = Validation(null, "Amount can't be blank");
    }
    if(!regExp.hasMatch(amount)){
      _amount = Validation(null, "Amount must be the integer");
    }
    if(int.parse(amount) <= 0){
      _amount = Validation(null, "Amount must be higher than 0");
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
    String basename = path.basename(_image.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  void addNewTool(BuildContext context) async {
    _isReady = true;
    if(_toolName.value == null) {
      print(_toolName.value);
      checkToolName("");
      _isReady = false;
    }
    if(_description.value == null) {
      print(_description.value);
      checkDescription("");
      _isReady = false;
    }
    if(_amount.value == null) {
      print(_amount.value);
      checkAmount("");
      _isReady = false;
    }
    print("-----------");
    print(_isReady);
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

      _addToolModel = new AddToolModel(
        toolName: _toolName.value,
        description: _description.value,
        image: currentImage,
        amount: int.parse(_amount.value)
      );

      String addToolJson = jsonEncode(_addToolModel.toJson());
      String msg = await _toolRepo.addNewTool(addToolJson);
      print('HI'+msg);
      if(msg == "Add new Tool success"){
        print('1');
        Fluttertoast.showToast(
          msg: "Add new tool success",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        print('2');
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ToolMainPage(model: ToolMainViewModel(),),
          ),
        );
      } else {
        _isLoading = false;
        Fluttertoast.showToast(
          msg: "Add new tool fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      }
    }
  }
}