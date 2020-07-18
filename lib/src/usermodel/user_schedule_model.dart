class UserSchedule {
  final int scenarioID;
  final String scenarioName, actorID, fullName, characterName, createBy, startOnDT, endOnDT;

  UserSchedule({this.scenarioID, this.scenarioName, this.actorID, this.fullName, this.characterName, this.createBy, this.startOnDT, this.endOnDT});

  factory UserSchedule.fromJson(Map<String, dynamic> json) {
    return UserSchedule(
      scenarioID: json['scenarioID'],
      scenarioName: json['scenarioName'],
      actorID: json['actorID'],
      fullName: json['fullName'],
      characterName: json['characterName'],
      createBy: json['createBy'],
      startOnDT: json['startOnDt'],
      endOnDT: json['endOnDt'],
    );
  }
}

class UserScheduleList {
  List<UserSchedule> userScheduleList;

  UserScheduleList({this.userScheduleList});

  factory UserScheduleList.fromJson(List<dynamic> parseJson) {

    List<UserSchedule> userSchedules = new List<UserSchedule>();

    userSchedules = parseJson.map((i) => UserSchedule.fromJson(i)).toList();

    return new UserScheduleList(
      userScheduleList: userSchedules,
    );
  }
}