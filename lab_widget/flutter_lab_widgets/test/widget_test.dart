import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_lab_widgets/main.dart';

void main() {
  testWidgets('home screen opens counter lab', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter Lab Widgets'), findsWidgets);
    expect(find.text('Enhanced Counter App'), findsOneWidget);

    await tester.tap(find.text('Enhanced Counter App'));
    await tester.pumpAndSettle();

    expect(find.text('Current number'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
