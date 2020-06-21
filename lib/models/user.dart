class User {
  final String token;
  final String userName;
  final String fullName;
  final String level;

  User({this.token, this.userName, this.fullName, this.level});

  factory User.fromJson(Map<String, String> json) {
    return User(
        userName: json['username'],
        fullName: json['firstName'] + ' ' + json['lastName'],
        level: json['level']);
  }
}
