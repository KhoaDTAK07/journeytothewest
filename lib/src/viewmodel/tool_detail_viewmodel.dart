import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:journeytothewest/src/models/update_tool_model.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;

class ToolDetailViewModel extends Model {
  ToolRepo _toolRepo = ToolRepoImp();
  UpdateToolModel _updateToolModel;
  int getToolID;

  Tool _tool;
  bool _isLoading = false;
  bool _isReady = true;

  Tool get tool => _tool;
  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  ToolDetailViewModel(int toolID) {
    getToolDetailByID(toolID);
  }

  void getToolDetailByID(int toolID) async{
    _isLoading = true;
    notifyListeners();
    _tool = await _toolRepo.getToolDetailByID(toolID);

    if(_tool != null) {
      getToolID = toolID;
      _tool = tool;
      _isLoading = false;
      nameFieldController.text = _tool.toolName;
      _toolName = Validation(_tool.toolName, null);
      descriptionFieldController.text = _tool.description;
      _toolDescription = Validation(_tool.description, null);
      amountFieldController.text = _tool.amount.toString();
      _toolAmount = Validation(_tool.amount.toString(), null);
      _defaultImage = _tool.image;
      notifyListeners();
    } else {

    }
  }

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();
  TextEditingController amountFieldController = TextEditingController();

  String _defaultImage;
  String get defaultImage => _defaultImage;

  File _image;
  File get image => _image;

  Validation _toolName = Validation(null, null);
  Validation _toolDescription = Validation(null, null);
  Validation _toolAmount = Validation(null, null);

  Validation get toolName => _toolName;
  Validation get toolDescription => _toolDescription;
  Validation get toolAmount => _toolAmount;

  void checkToolName(String name) {
    print(name);
    if(name == null || name.length == 0){
      _toolName = Validation(null, "Tool's name can't be blank");
    } else {
      _toolName = Validation(name, null);
    }
    notifyListeners();
  }

  void checkDescription(String description) {
    if(description == null || description.length == 0){
      _toolDescription = Validation(null, "Description can't be blank");
    } else {
      _toolDescription = Validation(description, null);
    }
    notifyListeners();
  }

  void checkAmount(String amount) {
    var isNum = r'^\d+$';
    RegExp regExp = new RegExp(isNum);
    if(amount == null || amount.length == 0){
      _toolAmount = Validation(null, "Amount can't be blank");
    }
    if(!regExp.hasMatch(amount)){
      _toolAmount = Validation(null, "Amount must be the integer");
    }
    if(int.parse(amount) <= 0){
      _toolAmount = Validation(null, "Amount must be higher than 0");
    } else {
      _toolAmount = Validation(amount, null);
    }
    notifyListeners();
  }

  Future getToolImage() async {
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

  Future<dynamic> updateTool() async {
    _isReady = true;
    if(_toolName.value == null) {
      print(_toolName.value);
      checkToolName(null);
      _isReady = false;
    }
    if(_toolDescription.value == null) {
      print(_toolDescription.value);
      checkDescription(null);
      _isReady = false;
    }
    if(_toolAmount.value == null) {
      print(_toolAmount.value);
      checkAmount(null);
      _isReady = false;
    }

    if(_isReady == true) {
      _isLoading = true;
      notifyListeners();

      String currentImage;
      if(_image != null) {
        var url = await upLoadImage();
        currentImage = url.toString();
      } else {
        currentImage = defaultImage;
      }

      _updateToolModel = new UpdateToolModel(
        toolID: getToolID,
        toolName: _toolName.value,
        description: _toolDescription.value,
        image: currentImage,
        amount: int.parse(_toolAmount.value)
      );

      String updateJson = jsonEncode(_updateToolModel.toJson());

      print(getToolID);

      return _toolRepo.updateTool(getToolID, updateJson);
    }
  }

}


