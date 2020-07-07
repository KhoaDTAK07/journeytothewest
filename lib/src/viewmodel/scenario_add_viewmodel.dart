
import 'package:intl/intl.dart';
import 'package:journeytothewest/src/helper/validation.dart';
import 'package:journeytothewest/src/models/add_scenario_model.dart';
import 'package:journeytothewest/src/repos/scenario_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioAddViewModel extends Model {
  ScenarioRepo _scenarioRepo = ScenarioRepoImp();
  AddScenarioModel _addScenarioModelmodel;

  bool _isLoading = false;
  bool _isReady = true;

  bool get isLoading => _isLoading;
  bool get isReady => _isReady;

  Validation _scenarioName = Validation(null, null);
  Validation _description = Validation(null, null);
  Validation _location = Validation(null, null);
  Validation _startOnDT = Validation(null, null);
  Validation _endOnDT = Validation(null, null);
  Validation _filePath = Validation(null, null);
  Validation _numOfScene = Validation(null, null);

  Validation get scenarioName => _scenarioName;
  Validation get description => _description;
  Validation get location => _location;
  Validation get startOnDT => _startOnDT;
  Validation get endOnDT => _endOnDT;
  Validation get filePath => _filePath;
  Validation get numOfScene => _numOfScene;

  String _dateStartFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _dateEndFormat = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get dateStartFormat => _dateStartFormat;
  String get dateEndFormat => _dateEndFormat;


  DateTime _maxYear = DateTime(2120);
  DateTime get maxYear => _maxYear;

  DateTime _selectDateStart = DateTime.now();
  DateTime get selectDateStart => _selectDateStart;

  set selectDateStart(DateTime selectDateStart) {
      _selectDateStart = selectDateStart;
      if(_dateStartFormat == _dateEndFormat) {

      }
  }

}