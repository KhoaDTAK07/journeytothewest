class Actor {
  final String username, fullName, sex, image, description, phone, email;
  final DateTime dob;
  final int status;

  Actor({this.username, this.fullName, this.sex, this.email, this.image, this.description, this.phone, this.dob, this.status});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      username: json['username'],
      fullName: json['fullName'],
      sex: json['sex'],
      image: json['image'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      dob: DateTime.parse(json['dob'].toString()),
      status: json['status'],
    );
  }
}

class ActorList {
  List<Actor> actorList;

  ActorList({this.actorList});

  factory ActorList.fromJson(List<dynamic> parseJson) {

    List<Actor> actors = new List<Actor>();

    actors = parseJson.map((i) => Actor.fromJson(i)).toList();

    return new ActorList(
      actorList: actors,
    );
  }
}