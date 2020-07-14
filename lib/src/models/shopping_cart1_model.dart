class ShoppingCart1 {
  final String scenarioName, actorID, fullName, characterName, createBy;
  final int scenarioID;

  ShoppingCart1({this.scenarioID, this.scenarioName, this.actorID, this.fullName, this.characterName, this.createBy});

  factory ShoppingCart1.fromJson(Map<String, dynamic> json) {
    return ShoppingCart1(
      scenarioID: json['scenarioID'],
      scenarioName: json['scenarioName'],
      actorID: json['actorID'],
      fullName: json['fullName'],
      characterName: json['characterName'],
      createBy: json['createBy'],
    );
  }
}

class ShoppingCart1List {
  List<ShoppingCart1> list;

  ShoppingCart1List({this.list});

  factory ShoppingCart1List.fromJson(List<dynamic> parseJson) {

    List<ShoppingCart1> lists = new List<ShoppingCart1>();

    lists = parseJson.map((i) => ShoppingCart1.fromJson(i)).toList();

    return new ShoppingCart1List(
      list: lists,
    );
  }
}