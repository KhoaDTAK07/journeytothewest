import 'package:journeytothewest/src/models/shopping_cart1_model.dart';
import 'package:journeytothewest/src/repos/shopping_cart1_repo.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingCart1MainViewModel extends Model{
  ShoppingCart1Repo _shoppingCartRepo = ShoppingCartRepoImp();

  ShoppingCart1List _shoppingCart1List;
  ShoppingCart1List get shoppingCart1List => _shoppingCart1List;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ShoppingCart1MainViewModel(int scenarioID) {
    getActorInScenario(scenarioID);
  }

  void getActorInScenario(int scenarioID) async {
    _isLoading = true;
    notifyListeners();

    _shoppingCart1List = await _shoppingCartRepo.getAll(scenarioID).whenComplete(() {
      _shoppingCart1List = shoppingCart1List;
      _isLoading = false;
      notifyListeners();
    });
  }

}