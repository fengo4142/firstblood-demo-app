import '../models/user.dart';

class AppStarted {}

class UserLoginRequest {
  final String email;
  final String password;

  UserLoginRequest({this.email, this.password});
}

class UserLoginSuccess {
  final String token;
  final String userName;
  final String firstName;
  final String lastName;
  final String level;

  UserLoginSuccess(
      {this.token, this.userName, this.firstName, this.lastName, this.level});
}

class UserLoaded {
  final User user;

  UserLoaded({this.user});
}

class UserLoginFailure {
  final String error;

  UserLoginFailure({this.error});
}

class UserLogout {}
