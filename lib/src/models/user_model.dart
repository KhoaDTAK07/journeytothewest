class User {
  String username, password;

  User(
    this.username,
    this.password,
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Password": password,
  };

}