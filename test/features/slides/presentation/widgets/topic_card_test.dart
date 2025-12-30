import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/widgets/topic_card.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('TopicCard', () {
    testWidgets('displays topic name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TopicCard(
              topic: Topic.aiTools,
              index: 0,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('AI Tools Usage'), findsOneWidget);
    });

    testWidgets('displays correct index number', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TopicCard(
              topic: Topic.bloc,
              index: 3,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('onTap callback is triggered', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TopicCard(
              topic: Topic.solid,
              index: 2,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TopicCard));
      expect(tapped, isTrue);
    });

    testWidgets('displays arrow icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TopicCard(
              topic: Topic.goRouter,
              index: 4,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });
  });
}
