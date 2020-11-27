import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testing/main.dart';

void main() {
  testWidgets("Contatore ha valore iniziale uguale a zero", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text("0"), findsOneWidget);
  });

  testWidgets("Contatore si incrementa correttamente", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final fabFinder = find.byKey(Key("counterButton"));
    expect(fabFinder, findsOneWidget);

    await tester.tap(fabFinder);
    await tester.pumpAndSettle();
    expect(find.text("1"), findsOneWidget);
  });
}
