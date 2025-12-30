import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/pages/home_page.dart';
import 'package:app/features/slides/presentation/widgets/topic_card.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('HomePage', () {
    testWidgets('displays Flutter Portfolio title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.text('Flutter Portfolio'), findsOneWidget);
    });

    testWidgets('displays all 7 topics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      for (final topic in Topic.values) {
        expect(find.text(topic.displayName), findsOneWidget);
      }
    });

    testWidgets('displays 7 TopicCard widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.byType(TopicCard), findsNWidgets(7));
    });

    testWidgets('displays topic numbers 1-7', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      for (int i = 1; i <= 7; i++) {
        expect(find.text('$i'), findsOneWidget);
      }
    });
  });
}
