// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:auth_implementation/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_auth_controller.dart';

void main() {
  testWidgets('Landing screen builds correctly', (WidgetTester tester) async {
    final fakeController = FakeAuthController();

    // Build our app with the fake controller
    await tester.pumpWidget(MyApp(authController: fakeController));

    // Now you can test UI elements
    expect(find.text('This is the Landing Page'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
