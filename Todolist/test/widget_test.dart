import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todolist/main.dart';

void main() {
  testWidgets('shows validation when adding an empty quest', (tester) async {
    await _pumpApp(tester);

    await tester.ensureVisible(find.byKey(const Key('submit-quest')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('submit-quest')));
    await tester.pump();

    expect(find.text('Enter a quest name'), findsOneWidget);
  });

  testWidgets('clearing a medium quest gives exp and gold', (tester) async {
    await _pumpApp(tester);

    final now = DateTime.now();
    final begin = _dateTimeText(now);
    final deadline = _dateTimeText(now.add(const Duration(minutes: 30)));

    expect(find.text('RPG Quest Log'), findsOneWidget);
    expect(find.text('HP 10 / 10'), findsOneWidget);
    expect(find.text('EXP 0 / 100'), findsOneWidget);
    expect(find.text('Gold 0'), findsOneWidget);

    await _addQuest(
      tester,
      title: 'Finish Flutter homework',
      startDate: begin,
      endDate: deadline,
    );

    expect(find.text('Finish Flutter homework'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('+20 EXP'), findsOneWidget);
    expect(find.text('+12 Gold'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('Complete quest'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Complete quest'));
    await tester.pump();

    expect(
      find.textContaining('Quest cleared! +20 EXP, +12 Gold'),
      findsOneWidget,
    );
    expect(find.text('EXP 20 / 100'), findsOneWidget);
    expect(find.text('Gold 12'), findsOneWidget);

    await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Done'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Done'));
    await tester.pump();

    expect(find.text('Finish Flutter homework'), findsOneWidget);

    await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Active'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Active'));
    await tester.pump();

    expect(find.text('No quests in this filter'), findsOneWidget);
  });

  testWidgets('overdue quests reduce exp and hp then reset at zero hp', (
    tester,
  ) async {
    await _pumpApp(tester);

    final overdueTime = _dateTimeText(
      DateTime.now().subtract(const Duration(minutes: 1)),
    );

    for (var index = 1; index <= 5; index++) {
      await _addQuest(
        tester,
        title: 'Late quest $index',
        startDate: overdueTime,
        endDate: overdueTime,
      );
    }

    expect(find.textContaining('Hero fainted'), findsOneWidget);
    expect(find.text('HP 10 / 10'), findsOneWidget);
    expect(find.text('EXP 0 / 100'), findsOneWidget);
    expect(find.text('Failed: 5'), findsOneWidget);
  });

  testWidgets('profile can be edited and shop potion restores hp', (
    tester,
  ) async {
    await _pumpApp(tester);

    final now = DateTime.now();
    final begin = _dateTimeText(now);
    final deadline = _dateTimeText(now.add(const Duration(minutes: 30)));
    final overdueTime = _dateTimeText(now.subtract(const Duration(minutes: 1)));

    await _addQuest(
      tester,
      title: 'Earn potion money',
      startDate: begin,
      endDate: deadline,
    );
    await tester.ensureVisible(find.byTooltip('Complete quest'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Complete quest'));
    await tester.pump();

    await _addQuest(
      tester,
      title: 'Miss a training quest',
      startDate: overdueTime,
      endDate: overdueTime,
    );

    expect(find.text('HP 8 / 10'), findsOneWidget);
    expect(find.text('Gold 12'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nav-character')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('profile-name-input')),
      'Thien Hero',
    );
    await tester.tap(find.byKey(const Key('avatar-Mage')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('save-profile')));
    await tester.pump();

    expect(find.text('Thien Hero'), findsWidgets);
    expect(find.textContaining('Profile saved'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nav-shop')));
    await tester.pumpAndSettle();

    expect(find.text('Guild Shop'), findsOneWidget);
    await tester.tap(find.byKey(const Key('buy-heal-potion')));
    await tester.pump();

    expect(find.textContaining('Potion used. Restored 2 HP'), findsOneWidget);
    expect(find.text('Gold 2'), findsOneWidget);
    expect(find.text('Current HP 10 / 10'), findsOneWidget);
  });
}

Future<void> _addQuest(
  WidgetTester tester, {
  required String title,
  required String startDate,
  required String endDate,
}) async {
  await tester.ensureVisible(find.byKey(const Key('quest-input')));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('quest-input')), title);
  await tester.enterText(find.byKey(const Key('start-date-input')), startDate);
  await tester.enterText(find.byKey(const Key('end-date-input')), endDate);
  tester.testTextInput.hide();
  await tester.ensureVisible(find.byKey(const Key('submit-quest')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('submit-quest')));
  await tester.pump();
}

Future<void> _pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

String _dateTimeText(DateTime value) {
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '${value.year}-$month-$day $hour:$minute';
}
