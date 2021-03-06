import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../actions/auth_actions.dart';
import '../models/app_state.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthMiddleware {
  final AuthService authService;

  const AuthMiddleware({this.authService = const AuthService()});

  List<Middleware<AppState>> createAuthMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, AppStarted>(_appStarted),
      TypedMiddleware<AppState, UserLoginRequest>(_login),
      TypedMiddleware<AppState, UserLoginSuccess>(_loginSuccess),
      TypedMiddleware<AppState, UserLogout>(_logout),
    ];
  }

  void _appStarted(
      Store<AppState> store, AppStarted action, NextDispatcher next) async {
    next(action);

    if (await _hasToken()) {
      store.dispatch(UserLoaded(user: User(token: await _getToken())));
    }
  }

  void _login(Store<AppState> store, UserLoginRequest action,
      NextDispatcher next) async {
    next(action);

    try {
      final Map<String, dynamic> authData =
          await authService.login(action.email, action.password);

      // if response arrived, dispatch login success action with response data (user info & token)
      _persistToken(authData['token']);
      store.dispatch(UserLoginSuccess(
          token: authData['token'],
          userName: authData['username'],
          firstName: authData['firstName'],
          lastName: authData['lastName'],
          level: authData['level']));
    } catch (e) {
      // if error occured, dispatch login failure action with that error 
      store.dispatch(UserLoginFailure(error: e.toString()));
    }
  }

  void _loginSuccess(Store<AppState> store, UserLoginSuccess action,
      NextDispatcher next) async {
    next(action);

    // keeping response data in store when login success
    store.dispatch(UserLoaded(
        user: User(
            userName: action.userName,
            fullName: '${action.firstName} ${action.lastName}',
            level: action.level)));
  }
  
  // get rid of token when logout
  void _logout(
      Store<AppState> store, UserLogout action, NextDispatcher next) async {
    await _deleteToken();

    next(action);
  }

  /// HELPER FUNCTIONS

  Future<String> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('Token removed');
  }

  Future<void> _persistToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token: $token');
  }

  Future<bool> _hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';

    if (token != '') {
      return true;
    } else {
      return false;
    }
  }
}
