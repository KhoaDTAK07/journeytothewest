class AddShoppingCart1Model {
  final int scenarioID;
  final String actorID, characterName, createBy, status;

  AddShoppingCart1Model({this.scenarioID, this.actorID, this.characterName, this.createBy, this.status});

  Map<String, dynamic> toJson() => {
    "ScenarioID": scenarioID,
    "ActorID": actorID,
    "CharacterName": characterName,
    "CreateBy": createBy,
    "Status": 1
  };
}