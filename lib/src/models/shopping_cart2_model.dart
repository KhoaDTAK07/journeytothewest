class ShoppingCart2 {
  final String scenarioName, toolName;
  final int scenarioID, toolID, amount;

  ShoppingCart2({this.scenarioID, this.scenarioName, this.toolID, this.toolName, this.amount});

  factory ShoppingCart2.fromJson(Map<String, dynamic> json) {
    return ShoppingCart2(
      scenarioID: json['scenarioId'],
      scenarioName: json['scenarioName'],
      toolID: json['toolId'],
      toolName: json['toolName'],
      amount: json['amount'],
    );
  }
}

class ShoppingCart2List {
  List<ShoppingCart2> list;

  ShoppingCart2List({this.list});

  factory ShoppingCart2List.fromJson(List<dynamic> parseJson) {

    List<ShoppingCart2> lists = new List<ShoppingCart2>();

    lists = parseJson.map((i) => ShoppingCart2.fromJson(i)).toList();

    return new ShoppingCart2List(
      list: lists,
    );
  }
}