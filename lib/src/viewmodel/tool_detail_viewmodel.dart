import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolDetailViewModel extends Model {
  ToolRepo _toolRepo = ToolRepoImp();

  Tool _tool;
  bool _isLoading = false;

  Tool get tool => _tool;
  bool get isLoading => _isLoading;

  ToolDetailViewModel(int toolID) {
    getToolDetailByID(toolID);
  }

  void getToolDetailByID(int toolID) async{
    _isLoading = true;
    notifyListeners();
    _tool = await _toolRepo.getToolDetailByID(toolID);

    if(_tool != null) {
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

  void catchChangeName(String name) {
    if (name == null) {
      _toolName = Validation(null, "Tool's name can't be blank");
    } else {
      _toolName = Validation(name, null);
    }
    notifyListeners();
  }

  void catchChangeDescription(String description) {
    if (description == null) {
      _toolDescription = Validation(null, "Tool's description can't be blank");
    } else {
      _toolDescription = Validation(description, null);
    }
    notifyListeners();
  }

  void catchChangeAmount(String amount) {
    if(amount == null) {
      _toolAmount = Validation(null, "Tool's amount can't be blank");
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

}


