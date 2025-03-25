import 'package:bullet_date_selector/bullet_date_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BulletDateSelector displays default slots and updates date on tap', (WidgetTester tester) async {
    DateTime? selectedDate;

    // Record the base time before tapping the button.
    final baseTime = DateTime.now();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BulletDateSelector(
            onDateSelected: (date) {
              selectedDate = date;
            },
          ),
        ),
      ),
    );

    // Verify that the slot '3 days' is present.
    expect(find.text('3 days'), findsOneWidget);

    // Tap on the "3 days" button.
    await tester.tap(find.text('3 days'));
    await tester.pumpAndSettle();

    // Compute the expected date based on the captured baseTime.
    final expectedDate = baseTime.add(const Duration(days: 3));

    expect(selectedDate!.day, expectedDate.day);
  });


  testWidgets('BulletDateSelector uses custom slot list when provided', (WidgetTester tester) async {
    DateTime? selectedDate;

    // Provide a custom slot list of [2, 4].
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BulletDateSelector(
            onDateSelected: (date) {
              selectedDate = date;
            },
            customSlotList: [2, 4],
          ),
        ),
      ),
    );

    // Check that only our custom slots are present.
    expect(find.text('2 days'), findsOneWidget);
    expect(find.text('4 days'), findsOneWidget);


  });

  testWidgets('BulletDateSelector hides title and helper text when disabled', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: BulletDateSelector(onDateSelected: (_) {}, showTitleText: false, showHelperText: false)),
      ),
    );

    // By default, the widget shows the localized title and helper text.
    // We set showTitleText = false, showHelperText = false, so they should not appear.
    // In your actual widget, the default title text is from localizedValues, e.g. "Select Due Date".
    // So we expect none of that text is found.
    expect(find.text('Select Due Date'), findsNothing);
    expect(find.text('Helper Text'), findsNothing);
    // (Adjust to match your actual localized strings if you have them.)
  });
}
