import 'package:journeytothewest/src/models/tool_model.dart';
import 'package:journeytothewest/src/repos/tool_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolMainViewModel extends Model {
  ToolRepo _toolRepo = ToolRepoImp();

  ToolList _toolList;
  bool _isLoading = false;

  ToolList get toolList => _toolList;
  bool get isLoading => _isLoading;

  ToolMainViewModel() {
    getActorList();
  }

  void getActorList() async {
    _isLoading = true;
    notifyListeners();

    _toolList = await _toolRepo.getToolList().whenComplete(() {
      _toolList = toolList;
      _isLoading = false;
      notifyListeners();
    });
  }
}