import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galzuu/main.dart'; // Make sure MainWrapper is exported here

void main() {
  testWidgets('MainWrapper smoke test', (WidgetTester tester) async {
    // Build the MainWrapper widget
    await tester.pumpWidget(const MaterialApp(home: MainWrapper()));

    // Verify initial page is HomeScreen by checking an element in HomeScreen
    expect(
      find.text('Hello, World!'),
      findsOneWidget,
    ); // adjust based on your HomeScreen content

    // Tap on the Shop tab
    await tester.tap(find.byIcon(Icons.store));
    await tester.pumpAndSettle();

    // Verify that ShopPage is now displayed
    expect(
      find.text('Shop Page'),
      findsOneWidget,
    ); // adjust based on your ShopPage content

    // Tap on the Add Friend tab
    await tester.tap(find.byIcon(Icons.group_add));
    await tester.pumpAndSettle();

    // Verify that AddFriendPage is now displayed
    expect(
      find.text('Add Friend Page'),
      findsOneWidget,
    ); // adjust based on your AddFriendPage content
  });
}
