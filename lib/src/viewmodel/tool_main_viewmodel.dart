import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journeytothewest/src/adminview/tool_detail_view.dart';
import 'package:journeytothewest/src/adminview/tool_main_view.dart';
import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:journeytothewest/src/viewmodel/tool_detail_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolMainViewModel extends Model {
  ToolRepo _toolRepo = ToolRepoImp();
  final txtSearch = TextEditingController();

  ToolList _toolList;
  bool _isLoading = false;
  bool _isNotHave = false;

  ToolList get toolList => _toolList;
  bool get isLoading => _isLoading;
  bool get isHave => _isNotHave;

  ToolMainViewModel() {
    getToolList();
  }

  void getToolList() async {
    _isLoading = true;
    notifyListeners();

    _toolList = await _toolRepo.getToolList().whenComplete(() {
      _toolList = toolList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteTool(int toolID) async {
    String status = await _toolRepo.deleteTool(toolID);
    getToolList();
    if(status == "Success") {
      Fluttertoast.showToast(
        msg: "Delete Tool Success",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Delete Tool Fail",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void searchToolList(String toolName) async {
    if(toolName == '') {
      getToolList();
    } else {
      _isLoading = true;

      if(_toolList != null) {
        _toolList.toolList.clear();
      }

      notifyListeners();

      _toolList = await _toolRepo.searchToolListByName(toolName).whenComplete(() {
        _toolList = toolList;
        _isLoading = false;
      });

      if(toolList == null) {
        _isNotHave = true;
      }

      notifyListeners();
    }
  }

}