import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaisi_app/Screens/AuthentificationF/ForgotPassword/Components/forget_password_screen.dart';
import 'package:kaisi_app/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().intialize();
  testWidgets('ForgetForm widget test', (WidgetTester tester) async {
    // Build the ForgetForm widget
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ForgetForm())));

    // Verify if TextFormField is rendered
    expect(find.byType(TextFormField), findsOneWidget);

    // Enter a valid email address
    await tester.enterText(find.byType(TextFormField), 'test@example.com');

    // Tap the Reset Password button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that the password reset process was triggered
    // This could be checked by verifying the behavior after tapping the button

    // You can also test error handling by providing a non-existing email address
    // For simplicity, I'm assuming you have an error dialog that appears
    expect(find.text("Email provided doesn't exist Try again"), findsNothing);

    // Trigger button press with non-existing email
    await tester.enterText(
        find.byType(TextFormField), 'nonexisting@example.com');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that error dialog appears
    expect(find.text("Email provided doesn't exist Try again"), findsOneWidget);
  });
}
