import 'package:flutter/material.dart';
import 'package:flutter_hiring_exercise/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hiring_exercise/globals.dart' as globals;
import 'utils.dart';

// http mock client
class MockClient extends Mock implements http.Client {}

void main() {

  testWidgets('Can navigate to profile tab', (WidgetTester tester) async {
    // Build our app and trigger a frame
    final app = await TestUtils.createApp();

    await tester.pumpWidget(app);

    // widget existed
    final profileNavItem = find.text('Profile');
    expect(profileNavItem, findsOneWidget);

    // widget clicked
    await tester.tap(profileNavItem);
    await tester.pump();
    expect(app.store.state.navState.selectedBottomNav, 2);

    // login screen come out
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Can register with valid user', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(await TestUtils.createApp());

    // go to login screen
    await tester.tap(find.text('Profile'));
    await tester.pump();

    // widget existed
    final registerBtn = find.text('Create account');
    expect(registerBtn, findsOneWidget);

    // widget clicked
    await tester.tap(registerBtn);
    await tester.pump();
    expect(find.text('Feature not available yet!'), findsOneWidget);

  });

  testWidgets('Can login with a valid user', (WidgetTester tester) async {

    final invalidEmail = 'testemail.com';
    final validEmail = 'test@gmail.com';
    final password = '123456';

    // Build our app and trigger a frame
    final app = await TestUtils.createApp();
    await tester.pumpWidget(app);

    // Use Mockito to return a successful response when it calls the provided http.Client.
    final mockClient = MockClient();
    final path = globals.apiURL;
    
    when(mockClient.post('$path/login', body: {'email': validEmail, 'password': password}))
          .thenAnswer((_) async => http.Response('{"firstName": "John","lastName": "Appleseed","username": "flurryflutter", "level": "100"}', 200));  

    globals.httpClient = mockClient;


    // go to login screen
    await tester.tap(find.text('Profile'));
    await tester.pump();

    final emailWidget = find.byKey(Key('email'));
    // email field exists
    expect(emailWidget, findsOneWidget);

    await tester.enterText(emailWidget, invalidEmail);
    await tester.pump();

    // password field exists
    final pwdWidget = find.byKey(Key('password'));
    expect(pwdWidget, findsOneWidget);

    await tester.enterText(pwdWidget, password);
    await tester.pump();

    // login button exists
    final loginBtn = find.text('Login');
    expect(loginBtn, findsOneWidget);

    await tester.tap(loginBtn);
    await tester.pump();

    // invalid email validation
    expect(find.text('Email is not valid'), findsOneWidget);

    await tester.enterText(emailWidget, validEmail);
    await tester.pump();

    // login request clicking login button
    await tester.tap(loginBtn);
    await tester.pump();

    // it must pass email validation
    expect(find.text('Email is not valid'), findsNothing);

    // logout can be seen after successful login
    expect(find.text('Logout'), findsOneWidget);

  });
}

