import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:journeytothewest/src/repos/actor_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorMainViewModel extends Model {
  ActorRepo _actorRepo = ActorRepoImp();

  ActorList _actorList;
  bool _isLoading = false;

  ActorList get actorList => _actorList;
  bool get isLoading => _isLoading;

  ActorMainViewModel() {
    getActorList();
  }

  void getActorList() async {
    _isLoading = true;
    notifyListeners();

    _actorList = await _actorRepo.getActorList().whenComplete(() {
      _actorList = actorList;
      _isLoading = false;
      notifyListeners();
    });
  }

}