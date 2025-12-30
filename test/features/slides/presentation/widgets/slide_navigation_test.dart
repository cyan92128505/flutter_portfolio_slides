import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/widgets/slide_navigation.dart';

void main() {
  group('SlideNavigation', () {
    testWidgets('displays correct page indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideNavigation(
              currentIndex: 2,
              totalSlides: 10,
              hasPrevious: true,
              hasNext: true,
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        ),
      );

      expect(find.text('3 / 10'), findsOneWidget);
    });

    testWidgets('previous button is disabled at first slide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideNavigation(
              currentIndex: 0,
              totalSlides: 5,
              hasPrevious: false,
              hasNext: true,
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        ),
      );
      final prevButton = tester.widget<FilledButton>(
        find.byKey(Key('SlideNavigationPrevButton')),
      );
      expect(prevButton.onPressed, isNull);
    });

    testWidgets('next button is disabled at last slide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideNavigation(
              currentIndex: 4,
              totalSlides: 5,
              hasPrevious: true,
              hasNext: false,
              onPrevious: () {},
              onNext: () {},
            ),
          ),
        ),
      );

      final nextButton = tester.widget<FilledButton>(
        find.byKey(Key('SlideNavigationNextButton')),
      );
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('onPrevious callback is triggered', (tester) async {
      var previousCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideNavigation(
              currentIndex: 2,
              totalSlides: 5,
              hasPrevious: true,
              hasNext: true,
              onPrevious: () => previousCalled = true,
              onNext: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(previousCalled, isTrue);
    });

    testWidgets('onNext callback is triggered', (tester) async {
      var nextCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideNavigation(
              currentIndex: 2,
              totalSlides: 5,
              hasPrevious: true,
              hasNext: true,
              onPrevious: () {},
              onNext: () => nextCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_forward));
      expect(nextCalled, isTrue);
    });
  });
}
