class UpdateScenarioModel {
  final int scenarioID, numOfScene, status;
  final String scenarioName, description, location, startOnDT, endOnDT, filePath;

  UpdateScenarioModel({
    this.scenarioID,
    this.scenarioName,
    this.description,
    this.location,
    this.numOfScene,
    this.startOnDT,
    this.endOnDT,
    this.filePath,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    "ScenarioID": scenarioID,
    "ScenarioName": scenarioName,
    "Description": description,
    "Location": location,
    "NumOfScene": numOfScene,
    "StartOnDT": startOnDT,
    "EndOnDT": endOnDT,
    "FileDescriptionPath": filePath,
    "Status": 1,
  };
}