class AddScenarioModel {
  final String scenarioName, description, location, startOnDT, endOnDT, filePath;
  final int numOfScene;

  AddScenarioModel({this.scenarioName, this.description, this.location, this.numOfScene, this.startOnDT, this.endOnDT, this.filePath});

  Map<String, dynamic> toJson() => {
    "ScenarioName": scenarioName,
    "Description": description,
    "Location": location,
    "NumOfScene": numOfScene,
    "StartOnDT": startOnDT,
    "EndOnDT": endOnDT,
    "FileDescriptionPath": filePath,
  };
}