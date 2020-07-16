import 'package:journeytothewest/src/models/shopping_cart2_model.dart';
import 'package:journeytothewest/src/repos/shopping_cart2_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingCart2MainViewModel extends Model{
  ShoppingCart2Repo _shoppingCartRepo = ShoppingCart2RepoImp();

  ShoppingCart2List _shoppingCart2List;
  ShoppingCart2List get shoppingCart2List => _shoppingCart2List;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ShoppingCart2MainViewModel(int scenarioID) {
    getToolInScenario(scenarioID);
  }

  void getToolInScenario(int scenarioID) async {
    _isLoading = true;
    notifyListeners();

    _shoppingCart2List = await _shoppingCartRepo.getAll(scenarioID).whenComplete(() {
      _shoppingCart2List = shoppingCart2List;
      _isLoading = false;
      notifyListeners();
    });
  }

}