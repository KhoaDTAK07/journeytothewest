class Scenario {
  final int scenarioID;
  final String scenarioName, description, location;
  final int numOfScene;
  final DateTime startOnDT, endOnDT;
  final String fileDescriptionPath;
  final int status;

  Scenario({this.scenarioID, this.scenarioName, this.description, this.location, this.numOfScene, this.startOnDT, this.endOnDT, this.fileDescriptionPath, this.status});

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      scenarioID: json['scenarioID'],
      scenarioName: json['scenarioName'],
      description: json['description'],
      location: json['location'],
      numOfScene: json['numOfScene'],
      startOnDT: DateTime.parse(json['startOnDT'].toString()),
      endOnDT: DateTime.parse(json['endOnDT'].toString()),
      fileDescriptionPath: json['fileDescriptionPath'],
      status: json['status'],
    );
  }
}

class ScenarioList {

  List<Scenario> scenarioList;

  ScenarioList({this.scenarioList});

  factory ScenarioList.fromJson(List<dynamic> parseJson) {

    List<Scenario> scenarios = new List<Scenario>();

    scenarios = parseJson.map((i) => Scenario.fromJson(i)).toList();

    return new ScenarioList(
        scenarioList: scenarios
    );
  }

}