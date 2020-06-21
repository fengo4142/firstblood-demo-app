import '../models/user.dart';

class AppStarted {}

class UserLoginRequest {
  final String email;
  final String password;

  UserLoginRequest({this.email, this.password});
}

// Login Success action definition with params
class UserLoginSuccess {
  final String token;
  final String userName;
  final String firstName;
  final String lastName;
  final String level;

  UserLoginSuccess(
      {this.token, this.userName, this.firstName, this.lastName, this.level});
}

// action for loading and keeping user state data in store
class UserLoaded {
  final User user;

  UserLoaded({this.user});
}

// Login Failure action
class UserLoginFailure {
  final String error;

  UserLoginFailure({this.error});
}
// Logout action
class UserLogout {}
