import 'package:journeytothewest/src/usermodel/user_schedule_model.dart';
import 'package:journeytothewest/src/userrepo/user_schedule_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class UserScheduleInComingViewModel extends Model {
  UserScheduleRepo _userScheduleRepo = UserScheduleRepoImp();

  UserScheduleList _userScheduleList;
  UserScheduleList get userScheduleList => _userScheduleList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserScheduleInComingViewModel(String username) {
    getScenarioInComingByUsername(username);
  }

  void getScenarioInComingByUsername(String username) async {
    _isLoading = true;
    notifyListeners();

    _userScheduleList = await _userScheduleRepo.getScenarioInComing(username).whenComplete(() {
      _userScheduleList = userScheduleList;
      _isLoading = false;
      notifyListeners();
    });
  }
}