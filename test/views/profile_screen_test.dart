import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/order_screen.dart';

void main() {
  group('ProfileScreen', () {
    testWidgets('displays initial UI elements correctly',
        (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Your Information'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('displays logo in app bar', (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final appBarImagesFinder = find.descendant(
        of: appBarFinder,
        matching: find.byType(Image),
      );
      expect(appBarImagesFinder, findsOneWidget);
    });

    testWidgets('displays default name in text field',
        (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      final nameTextField = find.byType(TextField).first;
      final TextField textField = tester.widget<TextField>(nameTextField);

      expect(textField.controller?.text, equals('Your Name'));
    });

    testWidgets('displays default phone number in text field',
        (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      final phoneTextField = find.byType(TextField).last;
      final TextField textField = tester.widget<TextField>(phoneTextField);

      expect(textField.controller?.text, equals('(555) 123-4567'));
      expect(textField.keyboardType, equals(TextInputType.phone));
    });

    testWidgets('name text field is editable', (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      final nameTextField = find.byType(TextField).first;

      await tester.enterText(nameTextField, 'John Doe');
      await tester.pump();

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('phone text field is editable', (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      final phoneTextField = find.byType(TextField).last;

      await tester.enterText(phoneTextField, '(555) 987-6543');
      await tester.pump();

      expect(find.text('(555) 987-6543'), findsOneWidget);
    });

    testWidgets('back button navigates back', (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      final MaterialApp app = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profileScreen),
                  );
                },
                child: const Text('Go to Profile'),
              );
            },
          ),
        ),
      );

      await tester.pumpWidget(app);

      await tester.tap(find.text('Go to Profile'));
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);

      final backButton = find.widgetWithText(StyledButton, 'Back to Order');
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.text('Go to Profile'), findsOneWidget);
      expect(find.text('Profile'), findsNothing);
    });

    testWidgets('displays Back to Order button', (WidgetTester tester) async {
      const ProfileScreen profileScreen = ProfileScreen();
      const MaterialApp app = MaterialApp(home: profileScreen);

      await tester.pumpWidget(app);

      final backButton = find.widgetWithText(StyledButton, 'Back to Order');
      expect(backButton, findsOneWidget);

      final StyledButton button = tester.widget<StyledButton>(backButton);
      expect(button.onPressed, isNotNull);
    });
  });
}
