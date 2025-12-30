import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

void main() {
  group('PortfolioApp', () {
    testWidgets('builds without error', (tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('shows home page initially', (tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      expect(find.text('Flutter Portfolio'), findsOneWidget);
    });

    testWidgets('displays all 7 topics on home page', (tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      expect(find.text('AI Tools Usage'), findsOneWidget);
      expect(find.text('Flutter Lifecycle + Clean Architecture'), findsOneWidget);
      expect(find.text('SOLID Principles'), findsOneWidget);
      expect(find.text('BLoC Pattern'), findsOneWidget);
      expect(find.text('go_router'), findsOneWidget);
      expect(find.text('RESTful API Integration'), findsOneWidget);
      expect(find.text('GitHub Flow'), findsOneWidget);
    });
  });
}
