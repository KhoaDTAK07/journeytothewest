import 'package:journeytothewest/src/models/actor_model.dart';
import 'package:journeytothewest/src/repos/actor_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorDetailViewModel extends Model{
  ActorRepo _actorRepo = ActorRepoImp();

  Actor _actor;
  bool _isLoading = false;

  Actor get actor => _actor;
  bool get isloading => _isLoading;

  ActorDetailViewModel(String username) {
    loadActorDetail(username);
  }

  void loadActorDetail(String username) async {
    _isLoading = true;
    notifyListeners();
    _actor = await _actorRepo.getActorDetail(username).whenComplete(() {
      _actor = actor;
      _isLoading = false;
      notifyListeners();
    });
  }

}