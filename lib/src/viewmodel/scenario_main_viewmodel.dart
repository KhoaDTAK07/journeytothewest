import 'package:journeytothewest/src/models/scenario_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioMainViewModel extends Model {
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();

  ScenarioList _scenarioList;
  bool _isLoading = false;

  ScenarioList get scenarioList => _scenarioList;
  bool get isLoading => _isLoading;

  ScenarioMainViewModel() {
    getScenarioList();
  }

  void getScenarioList() async {
    _isLoading = true;
    notifyListeners();

    _scenarioList = await _scenarioRepo.getScenarioList().whenComplete(() {
      _scenarioList = scenarioList;
      _isLoading = false;
      notifyListeners();
    });
  }

}